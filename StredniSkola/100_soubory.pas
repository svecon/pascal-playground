program soubory;
uses crt;

  type Zak = record
    jmeno,prijmeni : string;
    prumer : real;
  end;
  var VZak : Zak;
  FZaci : file of Zak;
  var ch : char;
  var prumer : real;

procedure seznam;
  var i:integer;
  begin
    write('Zaky s jakym nejhorsim prumerem potrebujete? '); readln(prumer);
    clrscr;
    writeln('S E Z N A M  Z A K U'); writeln;
    for i:=0 to filesize(FZaci)-1 do
      begin
        seek(FZaci, i);
        read(FZaci, VZak);
        if VZak.prumer<prumer then
          begin
            writeln('---');
            writeln(VZak.jmeno, ' ', VZak.prijmeni, ': ', VZak.prumer:1:2);
          end;
      end;
  end;

procedure pridat;
  begin
    write('Jmeno: '); readln(VZak.jmeno);
    write('Prijmeni: '); readln(VZak.prijmeni);
    write('Prumer: '); readln(VZak.prumer);
    seek(FZaci, filesize(FZaci));
    write(FZaci, VZak);
  end;

begin
  clrscr;
  
  assign(FZaci, 'Zaci.dat');
  {$I-} reset(FZaci); {$I+}
  if IOResult=2 then rewrite(FZaci);

  repeat
    begin
      writeln('Chces pridat dalsiho zaka? <Y/N>');
      ch := readkey;
      if upcase(ch)='Y' then pridat;
    end;
  until 'N'=upcase(ch);

  seznam;
  
  close(FZaci);
  
  writeln('---');
//  writeln('Entrem ukoncis aplikaci');
  readln;
end.