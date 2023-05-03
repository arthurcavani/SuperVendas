unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, ComCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, inifiles,shellapi;

type
  TfrmSplash = class(TForm)
    Image1: TImage;
    launch: TTimer;
    check: TIdHTTP;
    progress: TProgressBar;
    get: TIdHTTP;
    procedure launchTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure getWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure getWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure getWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.FormActivate(Sender: TObject);
var
dikd,dik,dl:string;
okays:boolean;
vArquivo6,varquivo3:tFileStream;
ver:integer;
arqd,arq:tinifile;
dirt,ach,cnv:string;
last:integer;
begin
okays:=true;
 if fileexists(''+(extractfilepath(application.exename))+'\update.ini') then
deletefile(''+(extractfilepath(application.exename))+'\update.ini');
Application.ProcessMessages;
  vArquivo6 := TFileStream.Create(''+(extractfilepath(application.exename))+'\update.ini',fmCreate);
  Application.ProcessMessages;
  Try
     Try
     Application.ProcessMessages;
check.Get('http://dl.dropbox.com/u/17338228/supervendas/update.ini',vArquivo6);
       Application.ProcessMessages;
     Except
      FreeAndNil(vArquivo6);
       DeleteFile(''+(extractfilepath(application.exename))+'\update.ini');
     Application.ProcessMessages;
       Application.ProcessMessages;
               okays:=false;
                  End;
     Application.ProcessMessages;
  Finally
  Application.ProcessMessages;
     FreeAndNil(vArquivo6);
     Application.ProcessMessages;
  end;
  Application.ProcessMessages;
  check.Free;
  if okays=true then
  begin
  dikd:=''+(extractfilepath(application.exename))+'\';
arqd:=Tinifile.Create(dikd+'update.ini');
ver:=arqd.ReadInteger('update','last',1);
if ver>1 then
begin
progress.Visible:=true;
MessageDlg(('Existe uma nova versão, o download será iniciado'),mtConfirmation,[mbYes],0);
 dik:=extractfilepath(application.exename);
arq:=Tinifile.Create(dik+'update.ini');
dl:=arq.ReadString('update','dl','');
if fileexists('update.exe') then
deletefile('update.exe');
Application.ProcessMessages;
  vArquivo3 := TFileStream.Create(''+(extractfilepath(application.exename))+'\update.exe',fmCreate);
  Application.ProcessMessages;
  Try
     Try
     Application.ProcessMessages;
      get.Get(dl,vArquivo3);
       Application.ProcessMessages;
     Except
      FreeAndNil(vArquivo3);
       DeleteFile(''+(extractfilepath(application.exename))+'\update.exe');
     Application.ProcessMessages;
     MessageDlg(('Impossível conectar ao servidor de atualizações'),mtError,[mbOK],0);
      Application.ProcessMessages;
       Progress.Visible:=false;
abort;
                 End;
     Application.ProcessMessages;
  Finally
  Application.ProcessMessages;
     FreeAndNil(vArquivo3);
     Application.ProcessMessages;
  end;
  Application.ProcessMessages;
  get.Free;
ShellExecute(0,nil,PWIDECHAR(''+(extractfilepath(application.exename))+'\updater.exe'),nil,nil,sw_normal);
end;
end;
launch.enabled:=true;
end;

procedure TfrmSplash.getWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
Application.ProcessMessages;
Progress.Position := AWorkCount;
Application.ProcessMessages;
end;

procedure TfrmSplash.getWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
Progress.Visible:=true;
Application.ProcessMessages;
Progress.Position := 0;
Application.ProcessMessages;
Progress.Max := AWorkCountMax;
Application.ProcessMessages;
end;

procedure TfrmSplash.getWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
Application.ProcessMessages;
Progress.Position := Progress.Max;
Application.ProcessMessages;
end;

procedure TfrmSplash.launchTimer(Sender: TObject);
begin
close;
end;

end.
