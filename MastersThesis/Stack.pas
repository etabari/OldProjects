unit Stack;

interface

uses classes;
const
MAX_STACK_SIZE = 100;
type

  TIntStack = class(TObject)
    private
      Data: array[1..MAX_STACK_SIZE] of integer;
      Top: integer;

    public
      constructor Create;
      destructor Destroy; override;

      procedure Push(value: integer);
      procedure Clear;
      function Pop: integer;


  end;

implementation

{ TIntStack }

procedure TIntStack.Clear;
begin
  Top := 0;
end;

constructor TIntStack.Create;
begin
  Clear;
end;

destructor TIntStack.Destroy;
begin

  inherited;
end;

function TIntStack.Pop: integer;
begin
  if Top>0 then
  begin
    Result := Data[Top];
    Dec(Top);
  end else
    raise EInvalidOperation.Create('Stack is Empty');
end;

procedure TIntStack.Push(value: integer);
begin
  if Top<MAX_STACK_SIZE then
  begin
    Inc(Top);
    Data[Top] := value;
  end else
    raise EInvalidOperation.Create('Stack is Full');
end;

end.
 