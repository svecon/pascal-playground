program ukazatele;
{MODE $DELPHI}
uses crt;

type spoj = ^student;
student = record
  jmeno : string;
  roky : integer;
  dalsi : spoj;
end;
var prvni,druhy,treti, p : spoj;

begin

new(prvni);
new(druhy);
new(treti);

new(p);
p^.jmeno := 'PePa';
p^.roky := 15;

prvni := p;

new(p);
p^.jmeno := 'Katka';
p^.roky := 30;

druhy := p;
prvni^.dalsi := druhy;

new(p);
p^.jmeno := 'Luba';
p^.roky := 45;

treti := p;
druhy^.dalsi := treti;

new(p);
p := prvni^.dalsi^.dalsi;

writeln(p^.jmeno);

readkey;
end.