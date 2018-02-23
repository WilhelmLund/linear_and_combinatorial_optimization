function problem = demoproblem(problem);

alfabet='. abcdefghijklmnopqrstuvwxyzåäö';
nalfabet=size(alfabet,2);
ialfabet=invalfabet(alfabet);

% Kryptotext
fidin = fopen('vigtext1','r') ; %try deciphering other texts by changing the file name here
[klartext,count] = fread(fidin) ;
klartext=klartext';
klartext=setstr(klartext);
%klartext=klartext(1:350); %if you want to use a shorter text
fclose(fidin);
iklartext=stringtoint(klartext,ialfabet);

%kod=[3 5 23];
%kod='optimering';
kod='kombinatoriskoptimering';
%kod='soqï¿½upï¿½joluks onjuqylupw';
kod=kod(1:3); %with a longer code, the optimization propblem will take longer to solve
kod=stringtoint(kod,ialfabet)-2;
period=size(kod,2);
ikryptotext=viginerekryptera(iklartext,kod,nalfabet);

% Statistik
load svtrifrekdubbel
if 1,
  tristat(find(tristat>1000)) = -3*ones(size(find(tristat>1000)));
end;

problem = vigcrypto(ikryptotext,alfabet,ltristat,tristat,utristat,size(kod,2),kod);
 
