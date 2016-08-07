
## Control Pipe
Requires the creation of a fifo at the specified location.
```
mkfifo "$control_pipe"
```

### Set location
```
control_pipe="${XDG_CONFIG_HOME:-$HOME/.config}/pianobar/ctl"
```

## play/pause
```
echo -n "p" > "$control_pipe"
```

## download
```
echo -n "$" > "$control_pipe"
```

## love
```
echo -n "+" > "$control_pipe"
```

## next
```
echo -n "n" > "$control_pipe"
```

## tired
```
echo -n "t" > "$control_pipe"
```

## quit
```
echo -n "q" > "$control_pipe"
```

## explain
```
echo -n "e" > "$control_pipe"
```
