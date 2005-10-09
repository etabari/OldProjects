program TreeNk;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Stack in 'Stack.pas';

{$R *.res}


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
