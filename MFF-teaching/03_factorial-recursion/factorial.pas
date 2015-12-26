var i : Integer;
var A : array[1..200] of LongInt;

function F(n:Integer):LongInt;
begin
   if A[n] > 0 then
         F := A[n]
   else begin
         F := F(n-1) + F(n-2);
         A[n] := F;
      end;

end;

begin
   A[1] := 1; A[2] := 1;
   for i:= 3 to 200 do
      A[i] := 0;

   for i:= 1 to 50 do
      writeln(i, '   ', F(i));
end.