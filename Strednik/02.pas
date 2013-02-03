program s02;

var co, cim, kde : string;
var p, i : integer;

begin

readln(co);
readln(cim);
readln(kde);

while length(kde) > 0 do
  begin
    p := pos(co, kde);
    for i:=1 to p-1 do
      write(kde[i]);
    write(cim);
    delete(kde, 1, p+length(co)-1);
  end;

end.