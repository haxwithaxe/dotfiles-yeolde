#include <curl/curl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <stdbool.h>

char *test_image(char *input,char *output);

int main(void)
{
/* Pause conky if open */

    FILE *pid=popen("kill -STOP $(pidof conky)","r");
    pclose(pid);

    
    char acc_addr[120]="http://www.accuweather.com/en/gr/kastoria/178682/weather-forecast/178682";

    char *last_number;
    last_number=strstr(acc_addr,"weather-forecast/")+17;
    char temp[120]="";
    *(strstr(acc_addr,"weather-forecast"))='\0';
    strcpy(temp,acc_addr);

    char curr_addr[120];
    strcpy(curr_addr,temp);
    strcat(curr_addr,"current-weather/");
    strcat(curr_addr,last_number);

    char addr1[120];
    strcpy(addr1,temp);
    strcat(addr1,"daily-weather-forecast/");
    strcat(addr1,last_number);

    char addr2[120];
    strcpy(addr2,addr1);
    strcat(addr2,"?day=6");

    CURL* easyhandle = curl_easy_init();
    
    curl_easy_setopt( easyhandle, CURLOPT_URL, curr_addr ) ;
    FILE* file_curr = fopen( "/home/teo/1a_accuweather_conkyweather_font/curr_cond", "w");
    curl_easy_setopt( easyhandle, CURLOPT_WRITEDATA, file_curr) ;
    curl_easy_perform( easyhandle );
    fclose(file_curr);

	curl_easy_setopt( easyhandle, CURLOPT_URL, addr1) ;
    FILE* file_tod_ton = fopen( "/home/teo/1a_accuweather_conkyweather_font/tod_ton", "w");
    curl_easy_setopt( easyhandle, CURLOPT_WRITEDATA, file_tod_ton) ;
    curl_easy_perform( easyhandle );
    fclose(file_tod_ton);

    curl_easy_setopt( easyhandle, CURLOPT_URL, addr2) ;
    FILE* file_last_days = fopen( "/home/teo/1a_accuweather_conkyweather_font/last_days", "w");
    curl_easy_setopt( easyhandle, CURLOPT_WRITEDATA, file_last_days) ;
    curl_easy_perform( easyhandle );
    fclose(file_last_days);

    curl_easy_cleanup( easyhandle );


/******************
* FILE: curr_cond *
*******************/

    struct stat st;
    stat("/home/teo/1a_accuweather_conkyweather_font/curr_cond",&st);
    int size=st.st_size;
    
    int i=0,j,k;
    char tmp[502]="",buff[2]="";

    if (size>0) {
        file_curr = fopen( "/home/teo/1a_accuweather_conkyweather_font/curr_cond", "r");
        char *arr_cc=malloc(size+1);
        fread(arr_cc,1,size,file_curr);
        fclose(file_curr);

        memmove(arr_cc,strstr(arr_cc,"#detail-now"),strlen(strstr(arr_cc,"#detail-now")));
        *(strstr(arr_cc,"#details"))='\0';

        file_curr = fopen( "/home/teo/1a_accuweather_conkyweather_font/curr_cond", "w");

        while (arr_cc[i] != '\0') {
           j=0;
           while (arr_cc[i] != '\n' && arr_cc[i] != '\0' && arr_cc[i] != '\r' && j <= 500)
               tmp[j++]=arr_cc[i++];

            tmp[j]='\n';
            tmp[++j]='\0';

           if (arr_cc[i] != '\0')
               i++;

           if (strstr(tmp,"\"detail-tab-panel ")) {
               memmove(tmp,strstr(tmp,"\"detail-tab-panel ")+18,strlen(strstr(tmp,"\"detail-tab-panel ")+18));
               *(strstr(tmp,"\">"))='\n';
               *(strstr(tmp,">"))='\0';
               fwrite(tmp,1,strlen(tmp),file_curr);
           } else if (strstr(tmp,"icon i-")) {
               memmove(tmp,strstr(tmp,"icon i-")+7,strlen(strstr(tmp,"icon i-")+7));
               *(strstr(tmp,"-"))='\0';
               test_image(tmp,buff);
               fwrite(buff,1,strlen(buff),file_curr);
               fprintf(file_curr,"\n");
           } else if (strstr(tmp,"cond\">")) {
               memmove(tmp,strstr(tmp,"cond\">")+6,strlen(strstr(tmp,"cond\">")+6));
               *(strstr(tmp,"</span>"))='\n';
               k=0;
               while (tmp[k]!='\n')
                   fprintf(file_curr,"%c",tmp[k++]);
               fprintf(file_curr,"\n");
               memmove(tmp,strstr(tmp,"/span> <span class=\"temp\">")+26,strlen(strstr(tmp,"/span> <span class=\"temp\">")+26));
               *(strstr(tmp,"<span>"))='\n';
               *(strstr(tmp,"span>"))='\0';
               fwrite(tmp,1,strlen(tmp),file_curr);
           }
        }
        
        free(arr_cc);
        fclose(file_curr);
    }

    
/****************
* FILE: tod_ton *
*****************/

    stat("/home/teo/1a_accuweather_conkyweather_font/tod_ton",&st);
    size=st.st_size;
    
    if (size>0) {
        file_tod_ton = fopen( "/home/teo/1a_accuweather_conkyweather_font/tod_ton", "r");
        char *arr_tt=malloc(size+1);
        fread(arr_tt,1,size,file_tod_ton);
        fclose(file_tod_ton);

        memmove(arr_tt,strstr(arr_tt,"\"feed-tabs"),strlen(strstr(arr_tt,"\"feed-tabs")));
        *(strstr(arr_tt,".feed-tabs"))='\0';

        file_tod_ton = fopen( "/home/teo/1a_accuweather_conkyweather_font/tod_ton", "w");

        i=0;
        bool night=false;
        strcpy(tmp,"");
        strcpy(buff,"");
        while (arr_tt[i] != '\0') {
           j=0;
           while (arr_tt[i] != '\n' && arr_tt[i] != '\0' && arr_tt[i] != '\r' && j <= 500)
               tmp[j++]=arr_tt[i++];

            tmp[j]='\n';
            tmp[++j]='\0';

           if (arr_tt[i] != '\0')
               i++;

           if (strstr(tmp,"href=\"#\">")) {
               memmove(tmp,strstr(tmp,"href=\"#\">")+9,strlen(strstr(tmp,"href=\"#\">")+9));
               *(strstr(tmp,"</a>"))='\n';
               *(strstr(tmp,"/a>"))='\0';
               if (strstr(tmp,"Tonight") || strstr(tmp,"Early AM"))
                   night=true;
               else 
                   night=false;
               if (strstr(tmp,"Early AM"))
                       fwrite("AM\n",1,strlen("AM\n"),file_tod_ton);
               else if (strstr(tmp,"Today"))
                       fwrite("TOD\n",1,strlen("TOD\n"),file_tod_ton);
               else if (strstr(tmp,"Tonight"))
                       fwrite("TON\n",1,strlen("TON\n"),file_tod_ton);
               else if (strstr(tmp,"Mon"))
                       fwrite("MON\n",1,strlen("MON\n"),file_tod_ton);
               else if (strstr(tmp,"Tue"))
                       fwrite("TUE\n",1,strlen("TUE\n"),file_tod_ton);
               else if (strstr(tmp,"Wed"))
                       fwrite("WED\n",1,strlen("WED\n"),file_tod_ton);
               else if (strstr(tmp,"Thu"))
                       fwrite("THU\n",1,strlen("THU\n"),file_tod_ton);
               else if (strstr(tmp,"Fri"))
                       fwrite("FRI\n",1,strlen("FRI\n"),file_tod_ton);
               else if (strstr(tmp,"Sat"))
                       fwrite("SAT\n",1,strlen("SAT\n"),file_tod_ton);
               else if (strstr(tmp,"Sun"))
                       fwrite("SUN\n",1,strlen("SUN\n"),file_tod_ton);
           } else if (strstr(tmp,"icon i-")) {
               memmove(tmp,strstr(tmp,"icon i-")+7,strlen(strstr(tmp,"icon i-")+7));
               *(strstr(tmp,"-"))='\0';
               test_image(tmp,buff);
               fwrite(buff,1,strlen(buff),file_tod_ton);
               fprintf(file_tod_ton,"\n");
           } else if (strstr(tmp,"cond\">")) {
               memmove(tmp,strstr(tmp,"cond\">")+6,strlen(strstr(tmp,"cond\">")+6));
               *(strstr(tmp,"</span>"))='\n';
               *(strstr(tmp,"/span>"))='\0';
               fwrite(tmp,1,strlen(tmp),file_tod_ton);
           } else if (strstr(tmp,"temp\">")) {
               memmove(tmp,strstr(tmp,"temp\">")+6,strlen(strstr(tmp,"temp\">")+6));
               *(strstr(tmp,"<span>&deg"))='\n';
               if (night) {
                   *(strstr(tmp,"span>&deg"))='\0';
                   fprintf(file_tod_ton,"-\n");
                   fwrite(tmp,1,strlen(tmp),file_tod_ton);
               } else {
                   k=0;
                   while (tmp[k]!='\n')
                       fprintf(file_tod_ton,"%c",tmp[k++]);
                   fprintf(file_tod_ton,"\n");
                   memmove(tmp,strstr(tmp,"Lo</span> ")+10,strlen(strstr(tmp,"Lo</span> ")+10));
                   *(strstr(tmp,"<span>&deg"))='\n';
                   *(strstr(tmp,"span>&deg"))='\0';
                   fwrite(tmp,1,strlen(tmp),file_tod_ton);
               }
           }
        }

        free(arr_tt);
        fclose(file_tod_ton);
    }


/*****************
* FILE: last_days*
******************/

    stat("/home/teo/1a_accuweather_conkyweather_font/last_days",&st);
    size=st.st_size;
    
    if (size>0) {
        file_last_days= fopen( "/home/teo/1a_accuweather_conkyweather_font/last_days", "r");
        char *arr_ld=malloc(size+1);
        fread(arr_ld,1,size,file_last_days);
        fclose(file_last_days);

        memmove(arr_ld,strstr(arr_ld,"\"feed-tabs"),strlen(strstr(arr_ld,"\"feed-tabs")));
        *(strstr(arr_ld,".feed-tabs"))='\0';

        file_last_days = fopen( "/home/teo/1a_accuweather_conkyweather_font/last_days", "w");

        i=0;
        strcpy(tmp,"");
        strcpy(buff,"");
        while (arr_ld[i] != '\0') {
           j=0;
           while (arr_ld[i] != '\n' && arr_ld[i] != '\0' && arr_ld[i] != '\r' && j <= 500)
               tmp[j++]=arr_ld[i++];

            tmp[j]='\n';
            tmp[++j]='\0';

           if (arr_ld[i] != '\0')
               i++;
           
           if (strstr(tmp,"href=\"#\">")) {
               memmove(tmp,strstr(tmp,"href=\"#\">")+9,strlen(strstr(tmp,"href=\"#\">")+9));
               *(strstr(tmp,"</a>"))='\n';
               *(strstr(tmp,"/a>"))='\0';
               if (strstr(tmp,"Mon"))
                       fwrite("MON\n",1,strlen("MON\n"),file_last_days);
               else if (strstr(tmp,"Tue"))
                       fwrite("TUE\n",1,strlen("TUE\n"),file_last_days);
               else if (strstr(tmp,"Wed"))
                       fwrite("WED\n",1,strlen("WED\n"),file_last_days);
               else if (strstr(tmp,"Thu"))
                       fwrite("THU\n",1,strlen("THU\n"),file_last_days);
               else if (strstr(tmp,"Fri"))
                       fwrite("FRI\n",1,strlen("FRI\n"),file_last_days);
               else if (strstr(tmp,"Sat"))
                       fwrite("SAT\n",1,strlen("SAT\n"),file_last_days);
               else if (strstr(tmp,"Sun"))
                       fwrite("SUN\n",1,strlen("SUN\n"),file_last_days);
           } else if (strstr(tmp,"icon i-")) {
               memmove(tmp,strstr(tmp,"icon i-")+7,strlen(strstr(tmp,"icon i-")+7));
               *(strstr(tmp,"-"))='\0';
               test_image(tmp,buff);
               fwrite(buff,1,strlen(buff),file_last_days);
               fprintf(file_last_days,"\n");
           } else if (strstr(tmp,"cond\">")) {
               memmove(tmp,strstr(tmp,"cond\">")+6,strlen(strstr(tmp,"cond\">")+6));
               *(strstr(tmp,"</span>"))='\n';
               *(strstr(tmp,"/span>"))='\0';
               fwrite(tmp,1,strlen(tmp),file_last_days);
           } else if (strstr(tmp,"temp\">")) {
               memmove(tmp,strstr(tmp,"temp\">")+6,strlen(strstr(tmp,"temp\">")+6));
               *(strstr(tmp,"<span>&deg"))='\n';
               k=0;
               while (tmp[k]!='\n')
                   fprintf(file_last_days,"%c",tmp[k++]);
               fprintf(file_last_days,"\n");
               memmove(tmp,strstr(tmp,"Lo</span> ")+10,strlen(strstr(tmp,"Lo</span> ")+10));
               *(strstr(tmp,"<span>&deg"))='\n';
               *(strstr(tmp,"span>&deg"))='\0';
               fwrite(tmp,1,strlen(tmp),file_last_days);
           }
        }

        free(arr_ld);
        fclose(file_last_days);
    }


/* Resume conky if paused */
    
    pid=popen("kill -CONT $(pidof conky)","r");
    pclose(pid);

    return 0;
}

char *test_image(char *input,char *output)
{
    if (strcmp(input,"1") == 0) 
        strcpy(output,"a");
    else if (strcmp(input,"2") == 0 || strcmp(input,"3") == 0)
        strcpy(output,"b ");
    else if (strcmp(input,"4") == 0 || strcmp(input,"5") == 0)
        strcpy(output,"c");
    else if (strcmp(input,"6") == 0)
        strcpy(output,"d");
    else if (strcmp(input,"7") == 0)
        strcpy(output,"e");
    else if (strcmp(input,"8") == 0)
        strcpy(output,"f");
    else if (strcmp(input,"11") == 0)
        strcpy(output,"0");
    else if (strcmp(input,"12") == 0)
        strcpy(output,"h");
    else if (strcmp(input,"13") == 0 || strcmp(input,"14") == 0)
        strcpy(output,"g");
    else if (strcmp(input,"15") == 0)
        strcpy(output,"m");
    else if (strcmp(input,"16") == 0 || strcmp(input,"17") == 0)
        strcpy(output,"k");
    else if (strcmp(input,"18") == 0)
        strcpy(output,"i");
    else if (strcmp(input,"19") == 0)
        strcpy(output,"q");
    else if (strcmp(input,"20") == 0 || strcmp(input,"21") == 0 || strcmp(input,"23") == 0)
        strcpy(output,"o");
    else if (strcmp(input,"22") == 0)
        strcpy(output,"r");
    else if (strcmp(input,"24") == 0 || strcmp(input,"31") == 0)
        strcpy(output,"E");
    else if (strcmp(input,"25") == 0)
        strcpy(output,"v");
    else if (strcmp(input,"26") == 0)
        strcpy(output,"x");
    else if (strcmp(input,"29") == 0)
        strcpy(output,"y");
    else if (strcmp(input,"30") == 0)
        strcpy(output,"5");
    else if (strcmp(input,"32") == 0)
        strcpy(output,"6");
    else if (strcmp(input,"33") == 0)
        strcpy(output,"A");
    else if (strcmp(input,"34") == 0 || strcmp(input,"35") == 0)
        strcpy(output,"B");
    else if (strcmp(input,"36") == 0 || strcmp(input,"37") == 0)
        strcpy(output,"C");
    else if (strcmp(input,"38") == 0)
        strcpy(output,"D");
    else if (strcmp(input,"39") == 0 || strcmp(input,"40") == 0)
        strcpy(output,"G");
    else if (strcmp(input,"41") == 0 || strcmp(input,"42") == 0)
        strcpy(output,"K");
    else if (strcmp(input,"43") == 0 || strcmp(input,"44") == 0)
        strcpy(output,"O");
    else 
        strcpy(output,"-");

    return output;
}

