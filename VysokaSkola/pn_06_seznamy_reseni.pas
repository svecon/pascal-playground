unit pn_06_seznamy_reseni;

interface

uses spojak;

{ nedestruktivni sjednoceni mnozin S1 a S2 }
function union(S1, S2: PItem): PItem;

{ nedestruktivni prunik mnozin S1 a S2 }
function intersection(S1, S2: PItem): PItem;

{ destruktivni sjednoceni mnozin S1 a S2, vstupni seznamy jsou zniceny a 
	promenne S1, S2 jsou nastaveny na nil }
function unionDestruct(var S1, S2: PItem): PItem;

{ destruktivni prunik mnozin S1 a S2, vstupni seznamy jsou zniceny a 
	promenne S1, S2 jsou nastaveny na nil }
function intersectionDestruct(var S1, S2: PItem): PItem;




implementation

procedure addElementToEnd(var element, list, listEnd: PItem);
  var n: PItem;
  begin
    new(n);
    n^.val := element^.val;
    n^.next := nil;
    element := element^.next;
    
    if list = nil then
      begin
        list := n;
        listEnd := list;
      end
    else
      begin
        listEnd^.next := n;
        listEnd := listEnd^.next;
      end;              
  end;

function destruct(var element:PItem):Pitem;
  var pom : PItem;
  begin
    pom := element;
    destruct := element^.next;
    dispose(pom);  
  end;

procedure addElementToEndDestruct(var element, list, listEnd: PItem);
  var pom: PItem;
  begin
    pom := element^.next;
    element^.next := nil;
    
    if list = nil then
      begin
        list := element;
        listEnd := list;
      end
    else
      begin
        listEnd^.next := element;
        listEnd := listEnd^.next;
      end;
      
    element := pom;
  end;

function union(S1, S2: PItem): PItem;
  var cS1, cS2, list, listEnd: PItem;
begin
  cS1 := S1;
  cS2 := S2;
  
	list := nil;
  listEnd := nil;
  
  while (cS1 <> nil) or (cS2 <> nil) do
    begin
      if (cS1 = nil) then
        addElementToEnd(cS2, list, listEnd)
      else if (cS2 = nil) then
        addElementToEnd(cS1, list, listEnd)
      else if (cS1^.val = cS2^.val) then
        begin
          addElementToEnd(cS1, list, listEnd);
          cS2 := cS2^.next;        
        end 
      else if (cS1^.val < cS2^.val) then
        addElementToEnd(cS1, list, listEnd)
      else if (cS1^.val > cS2^.val) then
        addElementToEnd(cS2, list, listEnd)
    end;

    union := list;
end;

function intersection(S1, S2: PItem): PItem;
  var cS1, cS2, list, listEnd: PItem;
  
begin
  cS1 := S1;
  cS2 := S2;
  
	list := nil;
  listEnd := nil;
  
  while (cS1 <> nil) and (cS2 <> nil) do
    begin
      if (cS1^.val = cS2^.val) then
        begin
          addElementToEnd(cS1, list, listEnd);
          cS2 := cS2^.next;        
        end 
      else if (cS1^.val < cS2^.val) then
        cS1 := cS1^.next
      else if (cS1^.val > cS2^.val) then
        cS2 := cS2^.next
    end;

    intersection := list;
end;

function unionDestruct(var S1, S2: PItem): PItem;
  var list, listEnd: PItem;
begin 
	list := nil;
  listEnd := nil;
  
  while (S1 <> nil) or (S2 <> nil) do
    begin
      if (S1 = nil) then
        addElementToEndDestruct(S2, list, listEnd)
      else if (S2 = nil) then
        addElementToEndDestruct(S1, list, listEnd)
      else if (S1^.val = S2^.val) then begin
        addElementToEndDestruct(S1, list, listEnd);
        S2 := destruct(S2); end 
      else if (S1^.val < S2^.val) then
        addElementToEndDestruct(S1, list, listEnd)
      else if (S1^.val > S2^.val) then
        addElementToEndDestruct(S2, list, listEnd)
    end;            
	unionDestruct := list;
end;

function intersectionDestruct(var S1, S2: PItem): PItem;
  var list, listEnd: PItem;
begin
	list := nil;
  listEnd := nil;
  
  while (S1 <> nil) and (S2 <> nil) do
    begin
      if (S1^.val = S2^.val) then begin
        addElementToEndDestruct(S1, list, listEnd);
        S2 := destruct(S2); end
      else if (S1^.val < S2^.val) then
        S1 := destruct(S1)
      else if (S1^.val > S2^.val) then
        S2 := destruct(S2)
    end;
  while s1 <> nil do s1 := destruct(s1);
  while s2 <> nil do s2 := destruct(s2);

	intersectionDestruct := list;
end;

end.