i3dir = os.getenv('I3_DIR')

package.path = i3dir .. '/?.lua;' .. package.path

DEFAULT_COLOR = 'ffffff'
WARN_COLOR = 'f0f000'
ALERT_COLOR = 'ffa0a0'

lib = require('lib')
log = lib.log:new(lib.log.INFO)

power = require('power').power_supply:new('BAT0')


weather = require('weather')
weather.config.units = 'metric'
weather.config.zipcode = '20895'
weather.config.apikey = '0cdcb01d44ef6c8109da7024566fc22b'
weather.config.cache_filename = '/tmp/i3-conky-weather.json'

undefined = 'undefined'

conky_fparse = function(fmt, ...)
	log:debug('fmt: %s', fmt:format(unpack(arg)))
	log:debug('parsed: %s', conky_parse(fmt:format(unpack(arg))))
	return conky_parse(fmt:format(unpack(arg)))
end

Conditional = {
	match = function()
	end,
	filter = function()
	end
}

Conditional.__index = Conditional

Conditional.new = function(self, match, filter)
	local spec = {}
	setmetatable(spec, Conditional)
	self.__index = self
	return spec
end


I3barItem = {
	conditions = {},
	full_text = undefined,
	short_text = undefined,
	color = undefined,
	background = undefined,
	border = undefined,
	min_width = undefined,
	align = undefined,
	name = undefined,
	instance = undefined,
	urgent = undefined,
	separator = undefined,
	separator_block_width = undefined,
	markup  = undefined,
	static_string = undefined,

	attrs = function(self)
		return {
			full_text = self.full_text,
			short_text = self.short_text,
			color = self.color,
			background = self.background,
			border = self.border,
			min_width = self.min_width,
			align = self.align,
			name = self.name,
			instance = self.instance,
			urgent = self.urgent,
			separator = self.separator,
			separator_block_width = self.separator_block_width,
			markup = self.markup,
			static_string = self.static_string
		}
	end,

	__call = function(self)
		return self:__tostring()
	end,

	__tostring = function(self)
		if self.static_string ~= undefined then
			return self.static_string
		end
		pair_template = '"%s" : "%s"' -- key, value
		unquoted_pair_template = '"%s" : %s' -- key, value
		attrs = {}
		for key, value in pairs(self:attrs()) do
			if value ~= undefined then
				for _, v in ipairs({'color', 'background', 'border'}) do
					if key == v then
						if string.match(value, '^[\\#]+%x%x%x%x%x%x$') then
							value = value:gsub('[\\#]', '')
						end
						if string.match(value, '^%x%x%x%x%x%x$') ~= nil then
							value = ([[#%s]]):format(value)
						end
						log:debug('color: %s', value)
						break
					end
				end
				if string.find(value, '"') then
					log:debug('unquoted: %s, %s', key, value)
					table.insert(attrs, unquoted_pair_template:format(key, value))
				else
					log:debug('quoted: %s, %s', key, value)
					table.insert(attrs, pair_template:format(key, value))
				end
			end
		end
		return ('{ %s }'):format(table.concat(attrs, ', '))
	end
}

I3barItem.__index = I3barItem

I3barItem.new = function(self, spec)
	local spec = spec or {}
	setmetatable(spec, I3barItem)
	self.__index = self
	return spec
end

i3bar_item = function(spec)
	return I3barItem:new(spec):__tostring()
end

needs_reeboot = function()
	local flag_file = io.open('/var/run/reboot-required', 'r')
	if flag_file then
		flag_file.close()
		return i3bar_item({ full_text = 'Reboot Required', color = 'ff0000'})
	else
		return i3bar_item({ full_text = '' })
	end
end

wireless_state = function(iface)
	if conky_fparse('${if_up %s}UP${endif}', iface) == 'UP' then
		full_text = iface .. ':'
		full_text = full_text .. conky_fparse('${addr %s}', iface) .. ' '
		full_text = full_text .. conky_fparse('${wireless_link_qual %s}db', iface) .. ' '
		wireless_mode = conky_fparse('${wireless_mode %s}', iface)
		if wireless_mode == 'Ad-Hoc' then
			full_text = full_text .. conky_fparse('adhoc:${wireless_ap %s}', iface)
		else
			full_text = full_text .. conky_fparse('e:${wireless_essid %s}', iface)
		end
	else
		full_text = iface .. ':down'
	end
	return i3bar_item({ full_text = full_text })
end

diskio = function()
	return i3bar_item({ full_text = 'sda:' .. conky_parse('${diskio sda}') })
end

disk_space = function(alias, path, low_space_perc, low_space_color)
	local low_color = low_sapce_color or ALERT_COLOR
	free_perc = tonumber(conky_fparse('${fs_free_perc %s}', path))
	if free_perc <= low_space_perc then
		color = low_color
	else
		color = DEFAULT_COLOR
	end
	return i3bar_item({
		full_text = conky_parse(('%s:${fs_free %s} ${fs_free_perc %s}'):format(alias, path, path)),
		color = color
	})
end

cpu_usage = function(alias, core, high_color, high_perc)
	high_color = high_color or ALERT_COLOR
	high_perc = high_perc or 90
	cpu_perc = tonumber(conky_fparse('${cpu %d}', core))
	if cpu_perc < high_perc then
		color = DEFAULT_COLOR
	else
		color = high_color
	end
	return i3bar_item({
		full_text = conky_fparse('%s:${cpu %d}', alias, core),
		color = color
	})
end

cpu_temp = function(device, subdevice, critical_color, warn_color, critical_temp)
	critical_color = critical_color or ALERT_COLOR
	warn_color = warn_color or WARN_COLOR
	crit_path = ('/sys/class/hwmon/hwmon%d/temp%d_crit'):format(device, subdevice)
	critical_temp = critical_temp or tonumber(io.open(crit_path):read())/1000
	temp = tonumber(conky_fparse('${hwmon %d temp %d}', device, subdevice))
	log:debug('temp = %d, critical temp = %d, %d, %d', temp, critical_temp, critical_temp*0.90, critical_temp*0.75)
	if temp >= critical_temp*0.90 then
		color = critical_color
		temp = ('🔥%d🔥'):format(temp)
	elseif temp >= critical_temp*0.75 then
		color = warn_color
	else
		color = DEFAULT_COLOR
	end
	return i3bar_item({
		full_text = temp,
		color = color
	})
end

mem_space = function(low_memperc, low_space_color)
	low_memperc = low_memperc or 90
	low_sapce_color = low_sapce_color or ALERT_COLOR
	memperc = tonumber(conky_parse('${memperc}'))
	if memperc <= low_memperc then 
		color = DEFAULT_COLOR
	else
		color = low_space_color
	end
	return i3bar_item({
		full_text = conky_parse('mem: f/m/s:${memfree}/${memmax}/${swap}'),
		color = color
	})
end


function conky_i3bar_main()
	status = table.concat(
			{
				needs_reeboot(),
				wireless_state('wlp58s0'),
				diskio('sda'),
				disk_space('/', '/', 10),
				disk_space('h', '/home', 10),
				cpu_usage('c0', 0),
				cpu_temp(0, 1, ALERT_COLOR, WARN_COLOR),
				mem_space(),
				weather.getf('{ "full_text" : "%t%u %c" }, { "full_text" : "%i" }'),
				i3bar_item(power:conky_spec()),
				i3bar_item({full_text = conky_parse('${time %d.%m %H:%M}')})
			},
			',\n'
		)
	print([[
		[
		]] .. status .. [[
		],
	]])
end

-- vim: set filetype=lua:
