unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tsobre = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  sobre: Tsobre;

implementation

{$R *.dfm}

procedure Tsobre.Button1Click(Sender: TObject);
begin
close;
end;

procedure Tsobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
sobre.free;
end;

end.
