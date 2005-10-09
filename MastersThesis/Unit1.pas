{$J+}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, StdCtrls, math, ExtCtrls, Stack;

type
  TIntArray = array[1..100] of integer;
  TForm1 = class(TForm)
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    ListBox1: TListBox;
    Panel1: TPanel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure ShapeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure DrawTree(a: TIntArray);
    function CreateShape(id: integer): TShape;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PARENTS : TIntArray;
  _N,_K: integer;
  Nodes: array[1..100] of TShape;
  thestack: TIntStack;

implementation

{$R *.dfm}


function Combination(a,b: Cardinal): Cardinal;
var p: Cardinal;
    i: integer;
begin
  p:=1;

  if a div 2 > b then
  begin // b is less tha a's half

  for i:=a downto a-b+1 do
    p := p * i;

    for i:=2 to b do
      p := p div i;

  end else
  begin  // b is big enough

    for i:=a downto b+1 do
      p := p * i;

    for i:=2 to a-b do
      p := p div i;
  end;

  Result := p;
end;

function BookCounts: string;
begin
  Result := ',  B1 =' + IntTostr(Combination(_n-1, _k) * Combination(_n-2, _k-2) div (_k-1)) +
            ',  B2 =' +IntTostr(Combination(_n-1, _k) * Combination(_n-1, _k-1) div (_n-1))
end;


{
 K 0 0 0 ... 0 1 1 1 ... 1 0
   |---------| ===========
 First (k-1)     (n-k+1)
}
procedure CreateFirstSeq(var a: TIntArray; Zeros, first: integer);
var i: integer;
begin
  for i:=1 to Zeros -1 do
    a[First+i-1] := 0;

  for i:=1 to (_N-First+1) - (Zeros) do
    a[First + Zeros + i -2 ] := 1;
  a[_n] := 0;
end;

function Successor(var a: TIntArray): Boolean;
var i,z, max : integer;
    ZERO: TIntArray;
    j: integer;
begin
  z := 0;
  for i:= _n downto 1 do
  begin
    ZERO[i] := z;
    if a[i]=0 then Inc(z);
  end;


  Result := false;
  for i:= _n-1 downto 2 do
   if // a[i] conditions
      ( ( (a[i]=0)  and (_n-i >ZERO[i]) ) or
        ( (a[i]<>0) and (a[i]<ZERO[i]) )
      )
   and // a[i-1] condition
      ( (          a[i-1] = 0           ) or
        ( (a[i-1]<>0) and (a[i]<a[i-1]) )
      )
   then
   begin

      if Form1.CheckBox1.Checked and  (a[i]<>0) then // CHECK 3.7 Rule
      begin
        j:= i-1;
        z := 0;
        if a[j]=0 then Inc(z);
        while a[j]<=z do
        begin
          Dec(j);
          if a[j]=0 then Inc(z);
        end;
        max := a[j];
        for j:=j to i do
          if a[j]=0 then
            Dec(max);

        if a[i] = max then
          Continue; // this i should not be increased.
      end;


      if a[i] = 0 then
        Inc(ZERO[i]);
      Inc(a[i]);

      CreateFirstSeq(a, ZERO[i], i+1);
      Result := true;
      exit;
    end;
end;

function Successor2(var a: TIntArray): Boolean;
var i,z: integer;
    ZERO, max, P: TIntArray;
    j: integer;
begin
  // Find ZERO Lisin in O(n)
  z := 0;
  for i:= _n downto 1 do
  begin
    ZERO[i] := z;
    if a[i]=0 then Inc(z);
  end;

  // Find Parent Array in O(n.k) page: 5.4
  thestack.Clear;
  P[1] := -1;
  for j:=1 to a[1] do
    thestack.Push(1);
  for i:=2 to _n do
  begin
    P[i] := thestack.Pop;
    for j:=1 to a[i]-1 do
      thestack.Pop;
    for j:=1 to a[i] do
      thestack.Push(i);
  end;

  // Find Max Array in O(n)
  max[1] := a[1];
  for i:=2 to _n do
    max[i] := a[P[i]] - ( ZERO[P[i]] - ZERO[i] );



  Result := false;
  for i:= _n-1 downto 2 do
   if // a[i] conditions
      ( ( (a[i]=0)  and (_n-i >ZERO[i]) ) or
        ( (a[i]<>0) and (a[i]<ZERO[i])  and (a[i]<max[i]) )
      )
   and // a[i-1] condition
      ( (          a[i-1] = 0           ) or
        ( (a[i-1]<>0) and (a[i]<a[i-1]) )
      )
   then
   begin

      if a[i] = 0 then
        Inc(ZERO[i]);
      Inc(a[i]);

      CreateFirstSeq(a, ZERO[i], i+1);
      Result := true;
      exit;
    end;
end;

procedure PrintArray(a: TIntArray);
var s: string;
    i: integer;
begin
  s := '';
  for i:= 1 to _n do
    s := s + IntToStr(a[i]) + ' ';
  Form1.ListBox1.Items.Add(s);
end;

procedure TForm1.Button1Click(Sender: TObject);
var a: TIntArray;
    Count: integer;
begin
   thestack := TIntStack.Create;
   _n := SpinEdit1.Value;
   _k := SpinEdit2.Value;
   if (_n>_k) and (_k>=1) then
   begin
     ListBox1.Items.Add('=');
     ListBox1.Items.Add('============== Trees for n=' + IntTostr(_n)+ ' , k=' + IntToStr(_k) );
     a[1] := _k;
     CreateFirstSeq(a, _k, 2);
     Count := 1;
     PrintArray(a);
     while Successor2(a) do
     begin
       Inc(Count);
       PrintArray(a);
     end;
     ListBox1.Items.Add('=   M =' + IntTostr(Count) + BookCounts() );
   end;
   thestack.Free;

   for count := 1 to _n do
     if Assigned(Nodes[count]) then
       Nodes[count].Free;

   for count:=1 to _n do
     CreateShape(count);
end;

function TForm1.CreateShape(id: integer): TShape;
var s: TShape;
begin
  s := TShape.Create(Self);
  s.Parent := Panel1;
  s.top := 10+ id * 40;
  s.Left := 100 +  (( (id mod 2 )*2)-1) * 40;
  s.Shape := stCircle;
  s.Width := 16;
  s.Height := 16;
  s.Tag := id;
  s.Hint := IntToStr(id);
  s.ShowHint := true;
  if id=1 then
     s.Brush.Color := clBlue;
  s.OnMouseMove := ShapeMouseMove;
  Result := s;
  Nodes[id] := s;
end;

procedure TForm1.DrawTree(a: TIntArray);
var p,i, j: integer;
    s: string;
begin
  thestack.Clear;
  PARENTS[1] := -1;
  for j:=1 to a[1] do
    thestack.Push(1);
  for i:=2 to _n do
  begin
    PARENTS[i] := thestack.Pop;
    for j:=1 to a[i]-1 do
      thestack.Pop;
    for j:=1 to a[i] do
      thestack.Push(i);
  end;



end;

procedure TForm1.ShapeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
 LX: integer=1;
 LY: integer =1;
begin
  if ssLeft in Shift then
  begin
    (Sender as TShape).Top := (Sender as TShape).Top + Y - LY;
    (Sender as TShape).Left := (Sender as TShape).Left + X - LX;
  end else
  begin
    LX := X;
    LY := Y;
  end;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var i,j: integer;
    s, sp: string;
    a: TIntArray;
begin
  s := ListBox1.Items[ListBox1.ItemIndex];
  j:=1;
  i:=1;
  while j< length(s) do
  begin
    sp := '';
    while (j<Length(s)) and (s[j]<> ' ') do
    begin
      sp := sp + s[j];
      Inc(j);
    end;

    if sp<>'' then
    begin
      a[i] := StrToInt(sp);
      Inc(i);
    end;

    while (j<Length(s)) and (s[j]= ' ') do
      Inc(j);
  end;
  DrawTree(a);
end;

procedure TForm1.Button2Click(Sender: TObject);
var    a: TIntArray;
begin
  a[1] := 4;
  a[2] := 1;
  a[3] := 0;
  a[4] := 3;
  a[5] := 0;
  a[6] := 1;
  a[7] := 0;
  a[8] := 0;
  _n := 8;
  DrawTree(a);

end;

end.
