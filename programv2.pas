program Minesweepers;
var
    randnum : array[1..100] of integer;
    i,j,H,W,x,y,bomb,limit,limitH: integer;
    counter : integer;
    notRepeated, trapped , win: boolean;
    hidden: array[1..50,1..50] of char;
    show: array[1..50,1..50]of char;
    used: array[1..50,1..50]of boolean;

procedure Reveal(x,y:integer);
begin
    if (hidden[x,y]='*') then trapped:=true;
    if (ord(hidden[x,y]) <> ord('*')) then counter:=counter+1;
    show[x,y]:= hidden[x,y];
    used[x,y] := true;
    if (ord(hidden[x,y]) = ord('0')) then
    begin
	if (x-1>0) and (y-1>0) and  (used[x-1,y-1]=false)   then Reveal(x-1,y-1);
	if (y-1>0) and              (used[x,y-1]=false)     then Reveal(x,y-1);
	if (x+1<=W) and (y-1>0) and (used[x+1,y-1]=false)   then Reveal(x+1,y-1);
	if (x-1>0) and (y+1<=H) and (used[x-1,y+1]=false)   then Reveal(x-1,y+1);
	if (y+1<=H) and             (used[x,y+1]=false)     then Reveal(x,y+1);
	if (x+1<=W) and (y+1<=H) and(used[x+1,y+1]=false)   then Reveal(x+1,y+1);
	if (x-1>0) and              (used[x-1,y]=false)     then Reveal(x-1,y);
	if (x+1<=W) and             (used[x+1,y]=false)     then Reveal(x+1,y);
    end;
    show[x,y] := hidden[x,y];
end;
begin

  randomize;
  limitH :=10;
  write('What is the height?(height must less than 10):');
  readln(H);
  if H=0 then repeat
	      writeln('    __  ____                                                        ');
	      writeln('   /  |/  (_____  ___  ______      _____  ___  ____  ___  __________');
	      writeln('  / /|_/ / / __ \/ _ \/ ___| | /| / / _ \/ _ \/ __ \/ _ \/ ___/ ___/');
	      writeln(' / /  / / / / / /  __(__  )| |/ |/ /  __/  __/ /_/ /  __/ /  (__  ) ');
	      writeln('/_/  /_/_/_/ /_/\___/____/ |__/|__/\___/\___/ .___/\___/_/  /____/  ');
	      writeln('                                           /_/                      ');
	      until H=1;
repeat
    if H>limitH
     then
	 begin writeln('Height must less than ',limitH,'and more than 0 !Please enter again!');

		write('What is the height?');
		readln(H);
	 end;
  until H<=limitH;


  write('What is the width?(width must less than 10):');
  readln(W);
  if W=0 then repeat
	      writeln('    __  ____                                                        ');
	      writeln('   /  |/  (_____  ___  ______      _____  ___  ____  ___  __________');
	      writeln('  / /|_/ / / __ \/ _ \/ ___| | /| / / _ \/ _ \/ __ \/ _ \/ ___/ ___/');
	      writeln(' / /  / / / / / /  __(__  )| |/ |/ /  __/  __/ /_/ /  __/ /  (__  ) ');
	      writeln('/_/  /_/_/_/ /_/\___/____/ |__/|__/\___/\___/ .___/\___/_/  /____/  ');
	      writeln('                                           /_/                      ');
	      until W=1;
  repeat
    if W>limitH
     then
	 begin writeln('Height must less than ',limitH,' and more than 0 !Please enter again!');

		write('What is the height?');
		readln(W);
	 end;
  until W<=limitH;
  limit := (H*W)div 4;



  write('How many bomb?');
  readln(bomb);
  repeat
    if bomb>limit
     then
	 begin writeln('Number of bombs must less than ',limit,'more than 0 !Please enter again!');

		write('How many bomb?');
		readln(bomb);
	 end;
  until bomb<=limit;



  for i := 1 to H do
      for j := 1 to W do
	begin
	  hidden[j,i] :='0';
	  used[j,i] := false
	end;
  for i := 1 to bomb do
  begin
    repeat
	randnum[i] := random(W*H);
	notRepeated := true;
	for j := 1 to i-1 do
	begin
	    if randnum[i]=randnum[j] then
		notRepeated := false;
	end;
    until notRepeated;
    y:=randnum[i] div W +1;
    x:=randnum[i] mod W +1;
    hidden[x , y]:='*';
    if (x-1>0) and (y-1>0) and (hidden[x-1,y-1]<>'*') then hidden[x-1,y-1]:=chr(ord(hidden[x-1,y-1])+1);
    if (y-1>0) and (hidden[x,y-1]<>'*') then hidden[x,y-1]:=chr(ord(hidden[x,y-1])+1);
    if (x+1<=W) and (y-1>0) and (hidden[x+1,y-1]<>'*') then hidden[x+1,y-1]:=chr(ord(hidden[x+1,y-1])+1);
    if (x-1>0) and (y+1<=H) and (hidden[x-1,y+1]<>'*') then hidden[x-1,y+1]:=chr(ord(hidden[x-1,y+1])+1);
    if (y+1<=H) and (hidden[x,y+1]<>'*') then hidden[x,y+1]:=chr(ord(hidden[x,y+1])+1);
    if (x+1<=W) and (y+1<=H) and (hidden[x+1,y+1]<>'*') then hidden[x+1,y+1]:=chr(ord(hidden[x+1,y+1])+1);
    if (x-1>0) and (hidden[x-1,y]<>'*') then hidden[x-1,y]:=chr(ord(hidden[x-1,y])+1);
    if (x+1<=W) and (hidden[x+1,y]<>'*') then hidden[x+1,y]:=chr(ord(hidden[x+1,y])+1);
  end;
   for y:=1 to H do
   begin
	for x := 1 to W do
	begin
	    show[x,y] :='?';
	    write(show[x,y],' ');
	end;
	writeln;
   end;
   trapped:=false;
   counter:=0;
   repeat
	readln(x,y);
	Reveal(x,y);
	for y:=1 to H do
	begin
	    for x := 1 to W do
	    begin
		write(show[x,y],' ');
	    end;
	    writeln;
	end;
    until (trapped) or (counter=H*W-bomb);
    if trapped then writeln(' Game over! ')
    else writeln(' You Win! ');
    for y:=1 to H do
    begin
	for x := 1 to W do
	begin
	    write(hidden[x,y],' ');
	end;
    writeln;
    end;
end.                  

