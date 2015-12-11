type PItem = ^Item;
      Item = record
          next : array['-'..'.'] of PItem;
          value : string[3];
      end;

      ParsedLine = record
          letter : string;
          combination : string;
      end;


function CreateItem() : PItem;
begin
    new(CreateItem);
    CreateItem^.value := '';
    CreateItem^.next['.'] := NIL;
    CreateItem^.next['-'] := NIL;
end;


function Decode(rep : PItem; comb : string) : string;
var p : PItem;
     i : integer;
begin
    p := rep;
    for i := 1 to length(comb) do
        begin
            p := p^.next[comb[i]];

            if p = NIL then
                begin
                    Decode := ''; exit;
                end;
        end;

    Decode := p^.value;

    for i := 1 to length(Decode) do
        if Decode[i] in ['A'..'Z'] then Decode[i] := chr(ord(Decode[i]) - ord('A') + ord('a'));
end;


procedure AddToRepresentation(rep : PItem; parsed : ParsedLine);
var i : integer;
     p : PItem;
     prev : PItem;
begin
    p := rep;
    for i := 1 to length(parsed.combination) do
        begin
            if p^.next[parsed.combination[i]] = NIL then
               p^.next[parsed.combination[i]] := CreateItem();

            p := p^.next[parsed.combination[i]];
        end;
    p^.value := parsed.letter;
end;


function ParseLineRepresentation(line : string) : ParsedLine;
var i : integer = 1;
begin
    ParseLineRepresentation.letter := '';
    ParseLineRepresentation.combination := '';

    while line[i] in [' '] do inc(i);
    while line[i] in ['.','-'] do
        begin
            ParseLineRepresentation.combination := ParseLineRepresentation.combination + line[i];
            inc(i);
        end;
    while line[i] in [' '] do inc(i);
    while not (line[i] in [' ']) and (i <= length(line)) do
        begin
            ParseLineRepresentation.letter := ParseLineRepresentation.letter + line[i];
            inc(i);
        end;
    {writeln('Parsed line: ', ParseLineRepresentation.letter, ' for ', ParseLineRepresentation.combination);}
end;


function ParseRepresentation(filename : string) : PItem;
    var f : Text;
         line : String;
         parsed : ParsedLine;
begin
    ParseRepresentation := CreateItem();

    Assign(f, filename);
    Reset(f);

    while not EOF(f) do
        begin
            ReadLn(f, line);
            parsed := ParseLineRepresentation(line);
            AddToRepresentation(ParseRepresentation, parsed);
        end;

    Close(f);
end;


procedure DecodeAndPrint(filename, output : string; representation : PItem);
var f : Text;
     o : Text;
     c : char;
     prev : char;
     token : string;
begin
    Assign(f, filename);
    Reset(f);

    Assign(o, output);
    Rewrite(o);

    token := '';
    prev := '*';
    while not EoF(f) do
        begin
            while not EoLn(f) do
                begin
                    prev := c;
                    Read(f, c);
                    if c in ['.','-'] then token := token + c
                    else { / }
                        begin
                            if length(token) > 0 then
                                begin
                                    Write(o, Decode(representation, token));
                                    token := '';
                                end;

                            if prev in ['/'] then Write(o, ' ');
                        end;
                end;

            Read(f, c); {move to next line}
            WriteLn(o);
        end;

    Close(f);
    Close(o);
end;


begin
    DecodeAndPrint('vstup.txt', 'vystup.txt', ParseRepresentation('morse.txt'));
end.
