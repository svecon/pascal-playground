program cas;
uses crt, sysutils;

Var HH,II,SS,MS: Word;
Var YY,MM,DD : Word;

Begin
  DecodeTime(Time,HH,II,SS,MS);
  Writeln (format('The time is %d:%d:%d.%d',[hh,II,ss,ms]));

 Writeln ('Date : ',Date);
 DeCodeDate (Date,YY,MM,DD);
 Writeln (format ('Date is (DD/MM/YY): %d/%d/%d ',[dd,mm,yy]));

  readln;
End.