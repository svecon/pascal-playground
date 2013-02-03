program dec2frac;
  uses crt;

  var
  x,z,d,n : extended;
  p,s,l : extended;
  sign : integer;
  accuracy : extended;
  
begin

  accuracy := 0.0005;

  write('Vlozte desetinne cislo: ');
  readln(x);
  
  {znamenko}
  if x < 0 then
    sign := -1
  else
    sign := +1;
  x := x * sign;
  
  {x je cele cislo?}
  if x = int(x) then
    begin
      n := x * sign;
      d := 1;
    end
  {x je mensi než 0.000000000000000001}
  else if x < 1E-19 then
    begin
      n := 1 * sign;
      d := 99999999999999999;
    end
  {x je vetsi než   999999999999999999}
  else if x > 1E+19 then
    begin
      n := 999999999999999999 * sign;
      d := 1;  
    end
  {samotny algoritmus}
  else
    begin
      z := x;
      d := 1;
      p := 0;
      
      repeat
        z := 1 / ( Z - int(Z) );
        
        s := d;
        d := d * int(z) * s;
        p := s;
        
        n := int( x * d + 0.5 );
        
      until
        (abs((x - (n/d))) < accuracy) 
        or
        (z = int(z));
      
      n := n * sign;
    
    
    
    end; 
  
  writeln(n:0:0, ' / ', d:0:0);  
   
  
  
  readln;
end.