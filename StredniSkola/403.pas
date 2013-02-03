program StrList;
uses Classes; 
var
  Str: TStringList;
begin
  Str := TStringList.Create; // This is needed when using this class(or most classes)
  Str.Add('Some String!');
  Readln;
end.