program RadiciMetody;
uses crt, dos;

var H,M,S,S100: word; {time calculations - GetTime();}
var startTime, endTime: real; {time calculations}
var i,j,k : longint; {counters}
var howManyNum, biggestNum: longint; {"constants"}
var arrayToSort, sortedArray: array of integer;
var pushedKey: char; {user interactions}
var showcase: boolean; {showcase?}
var ratio: real;

procedure printArray (a: array of integer; arraySize: longint; writeIndexes:boolean);
  var width:integer;
  begin
    {for i:=0 to howManyNum do if (i=0) OR (p[i]>max) then max:=p[i];}
    if biggestNum mod 1000 <> biggestNum then width:=5
    else if biggestNum mod 100 <> biggestNum then width:=4
    else if biggestNum mod 10 <> biggestNum then width:=3
    else width:=2;

    for i:=0 to arraySize do
      begin
        if writeIndexes then write(i, '(', a[i], 'x', '), ')
        else write(a[i]:width, ', ');
      end;
    writeln();
  end;

procedure pigeonholeSort (var a: array of integer; arraySize, biggestNumber: longint);
  var index:longint;
  var additionalArray: array of integer;
  begin
    index:=0;
    setLength(additionalArray, biggestNumber+1);

    if showcase then printArray(a, arraySize-1, false); {optional}

    for i:=0 to biggestNumber+5 do additionalArray[i]:=0; {prepare additionalArray (values to zero)}
    for i:=0 to arraySize-1 do additionalArray[a[i]]:=additionalArray[a[i]]+1; {browse arrayToSort and inset values to additionalArray}
    for i:=0 to biggestNumber do
      if additionalArray[i]>0 then
        for j:=0 to additionalArray[i]-1 do
          begin
            a[index]:=i;
            index := index +1;
          end;

    if showcase then {optional}
      begin                          
        printArray(additionalArray, biggestNumber, true);
        printArray(a, arraySize-1, false);
      end;
  end;

procedure bubbleSort (a: array of integer; arraySize: longint);
  var pom: integer;
  begin
    for k:=0 to arraySize-1 do
    begin
    if showcase then printArray(a, arraySize, false);
      for j:=0 to arraySize-1 do
        if a[j]>a[j+1] then
          begin
            pom := a[j+1];
            a[j+1]:= a[j];
            a[j]:=pom;
          end;
    end;
    if showcase then printArray(a, arraySize, false);
  end;

procedure bubbleSortAdvanced (a: array of integer; arraySize: longint);
  var maxPozice:longint;
  var pom:integer;
  var sorted:boolean;
  begin
    maxPozice := arraySize-1;
    for k:=0 to arraySize-1 do
      begin
        sorted:=true;
        for j:=0 to maxPozice do
          begin
            if a[j]>a[j+1] then
              begin
                maxPozice:=j;
                pom := a[j+1];
                a[j+1]:= a[j];
                a[j]:=pom;
                sorted:=false;
              end;
          end;
        if sorted then Break;
      end;
  end;
  
procedure selectionSort (a: array of integer; arraySize: longint);
  var pom:integer;
  var min:longint;
  begin
    for k:=0 to arraySize-1 do
      begin
      if showcase then printArray(a, arraySize, false);
        min:=k;
        for j:=k+1 to arraySize do
          if a[j]<a[min] then min:=j;
        
        if a[min]<a[k] then
          begin
            pom:=a[k];
            a[k]:=a[min];
            a[min]:=pom;
          end;    
      end;
    if showcase then printArray(a, arraySize, false);
  end;

procedure insertionSort (a: array of integer; arraySize: longint);
  var pom: integer;
  begin
    for k:=1 to arraySize do {starting on the second number}
      begin
        if showcase then printArray(a, arraySize, false);
        pom:=a[k];
        for j:=k-1 downto 0 do
          if a[j]>a[j+1] then
            begin
              a[j+1]:=a[j];
              a[j]:=pom;
            end;
      end;
    if showcase then printArray(a, arraySize, false);
  end;

procedure createArray (method: char; var a: array of integer; howManyNum, biggestNum: longint);
  begin
    if method='1' then
      for k:=0 to howManyNum-1 do a[k]:=round(k*ratio)
    else if method='2' then
      for k:=0 to howManyNum-1 do a[k]:=round(biggestNum-(k*ratio))
    else
      for k:=0 to howManyNum-1 do a[k]:=random(biggestNum);

    if showcase then printArray(a, howManyNum-1, false); {optional}
  end;

procedure calcTime(time:real);
  const
    cas=0.00000000712055555556;
    milisecond=0.001;
    second=1;
    minute=60;
    hour=3600;
    day=86400;
    year=31557600;
  begin
    if time=0 then time := 3*howManyNum*cas;
  
         if time / year > 1     then write(time/year:12:2, ' years      ')
    else if time / day > 1      then write(time/day:12:2, ' days       ')
    else if time / hour > 1     then write(time/hour:12:2, ' hours      ')
    else if time / minute > 1   then write(time/minute:12:2, ' minutes    ')
    else if time / second > 1   then write(time/second:12:2, ' seconds    ')
    else write(time/milisecond:12:2, ' miliseconds');
  end;

procedure timer (method:integer; title:string);
  var methodRychlost: array[0..10] of real;
  const cas=0.00000000712055555556;
    begin
      methodRychlost[0]:=0;
        if showCase then begin
            writeln; writeln(title, ':');
        end;

        if (howManyNum < 50000) OR (method=1) OR (method=6) then
          begin
            GetTime(H, M, S, S100); startTime := (M*60) + S + (S100/100);
    
            if      method=1 then createArray(pushedKey, arraytoSort, howManyNum, biggestNum)
            else if method=2 then bubbleSort(arraytoSort, howManyNum-1)
            else if method=3 then bubbleSortAdvanced(arraytoSort, howManyNum-1)
            else if method=4 then selectionSort(arraytoSort, howManyNum-1)
            else if method=5 then insertionSort(arraytoSort, howManyNum-1)
            else if method=6 then pigeonholeSort(arraytoSort, howManyNum, biggestNum);
    
            GetTime(H, M, S, S100); endTime := (M*60) + S + (S100/100);
    
            if showCase=false then begin
                writeln(); calcTime(endTime-startTime); writeln(': ', title);
                //writeln(endTime-startTime:12:2, ' seconds: ', title);
            end;
          end
        else if showCase=false then
          begin
            if methodRychlost[0]=0 then
              begin
                methodRychlost[2]:=cas*howManyNum*howManyNum;
                methodRychlost[3]:=methodRychlost[2]/1.55;
                methodRychlost[4]:=methodRychlost[2]/3.75;
                methodRychlost[5]:=methodRychlost[2]/1.95;
                //methodRychlost[6]:=methodRychlost[2]/1.5;
                
              end;
            methodRychlost[0]:=1;
            writeln(); calcTime(methodRychlost[method]); writeln(': ', title);
          end;
    end;

begin
clrscr;

writeln('Showcase? ( 0 / 1 ) ');
pushedKey := readkey;
writeln();

if pushedKey='1' then
    begin
        howManyNum:=10;
        biggestNum:=99;
        showcase:=true;
    end
else
    begin
        write('How many numbers to calculate with? '); readln(howManyNum); writeln;
        //howManyNum := 500000;
        biggestNum := 30000;
        showcase:=false;
    end;

randomize;
setLength(arrayToSort, howManyNum);
setLength(sortedArray, howManyNum);

writeln('What type of sequence do you want?');
writeln('1 - Upword sequence');
writeln('2 - Downward sequence');
writeln('3 - Random sequence');
pushedKey := readkey;

clrscr;

ratio := biggestNum/howManyNum;

timer(1, 'Creating array');
timer(2, 'Bubble sort (basic)');
  if showcase=false then
timer(3, 'Bubble sort (advanced)');
timer(4, 'Selection sort (minimum)');
timer(5, 'Insertion sort (minimum)');
timer(6, 'Moje metoda (Counting sort)');
{  if ukazka=0 then
    casomira(2, 'Bublinov  metoda (vylep�en )');

}
readkey;
end.
