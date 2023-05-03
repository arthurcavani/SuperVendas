unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,shellapi, Menus, ComCtrls, StdCtrls, Grids, DBGrids, DB, ADODB,
  ExtCtrls, DBCtrls, Mask, about, jpeg, inifiles, concluivenda,historico,splash,
  reporestoque;

type
  Tmainform = class(TForm)
    menu1: TMainMenu;
    Utilitrios1: TMenuItem;
    Ajuda1: TMenuItem;
    A1: TMenuItem;
    Removervendedor1: TMenuItem;
    Calculadora1: TMenuItem;
    Relatrios1: TMenuItem;
    Sobre1: TMenuItem;
    controleprincipal: TPageControl;
    Vendas: TTabSheet;
    GerenciarProdutos: TTabSheet;
    GerenciarClientes: TTabSheet;
    GerenciarFornecedor: TTabSheet;
    tabvendas: TDBGrid;
    vendapesquisa: TGroupBox;
    pesquisar: TEdit;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label9: TLabel;
    codprodvenda: TEdit;
    quantprod: TEdit;
    addavenda: TButton;
    Label11: TLabel;
    concluivenda: TButton;
    tabprodutos: TDBGrid;
    tabclientes: TDBGrid;
    tabfornecedores: TDBGrid;
    connectdb: TADOConnection;
    adovendas: TADODataSet;
    sourcevendas: TDataSource;
    tipo: TComboBox;
    Label1: TLabel;
    adoprodutos: TADODataSet;
    sourceprodutos: TDataSource;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    pesquisa2g: TEdit;
    tipo2g: TComboBox;
    bottomdesc: TLabel;
    gerenciaprods: TGroupBox;
    novoprodlabel: TLabel;
    removeprodlabel: TLabel;
    deleteproddb: TDBNavigator;
    dbeddescrip: TDBEdit;
    DBNavigator1: TDBNavigator;
    lbldesc: TLabel;
    dbedpreço: TDBEdit;
    Label3: TLabel;
    Label5: TLabel;
    dbedestoque: TDBEdit;
    addprod: TButton;
    adoclientes: TADODataSet;
    sourceclientes: TDataSource;
    pesquisacliente: TGroupBox;
    Label6: TLabel;
    pesquisa3g: TEdit;
    tipo3g: TComboBox;
    gerenciaclientes: TGroupBox;
    Button1: TButton;
    DBNavigator2: TDBNavigator;
    lblnovoclient: TLabel;
    lblremoveclient: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    dbednome: TDBEdit;
    Label8: TLabel;
    dbedrgcpf: TDBEdit;
    Label10: TLabel;
    dbedend: TDBEdit;
    lbltelefone: TLabel;
    dbedtel: TDBEdit;
    Label12: TLabel;
    dbedemail: TDBEdit;
    DBNavigator3: TDBNavigator;
    Label13: TLabel;
    dbednotes: TDBMemo;
    DBNavigator4: TDBNavigator;
    Label15: TLabel;
    Label16: TLabel;
    adofornecedor: TADODataSet;
    sourcefornecedor: TDataSource;
    pesquisarepresentantebox: TGroupBox;
    Label17: TLabel;
    tipo4g: TComboBox;
    pesquisa4g: TEdit;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    fornew: TButton;
    DBNavigator5: TDBNavigator;
    Panel2: TPanel;
    fornome: TDBEdit;
    foremail: TDBEdit;
    forrepresenta: TDBEdit;
    fortelefone: TDBEdit;
    DBNavigator6: TDBNavigator;
    fornotas: TDBMemo;
    DBNavigator7: TDBNavigator;
    Label24: TLabel;
    listaprod: TDBGrid;
    adolista: TADODataSet;
    sourcelista: TDataSource;
    adolistaDescrição: TWideStringField;
    adolistaQuantidade: TIntegerField;
    loginprompt: TPanel;
    loginback: TImage;
    user: TEdit;
    password: TEdit;
    activeuser: TLabel;
    descurrentitem: TDBEdit;
    precurrentitem: TDBEdit;
    adovaloresvenda: TADODataSet;
    sourcevaloresvenda: TDataSource;
    listatotal: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    DBNavigator8: TDBNavigator;
    adolistaPreço: TWideStringField;
    verificalista: TTimer;
    adoclientesNome: TWideStringField;
    adoclientesRGCPF: TIntegerField;
    adoclientesEndereço: TWideStringField;
    adoclientesTelefone: TIntegerField;
    adoclientesEMail: TWideStringField;
    adoclientesObservações: TWideStringField;
    adoclientesCódigo: TAutoIncField;
    adorelvendas: TADODataSet;
    sourcerelvendas: TDataSource;
    adorelvendasProduto: TWideStringField;
    adorelvendasPreço: TWideStringField;
    adorelvendasDesconto: TWideStringField;
    adorelvendasVendedor: TWideStringField;
    adorelvendasData: TWideStringField;
    adorelvendasCliente: TWideStringField;
    adorelvendasPagamento: TWideStringField;
    adorelvendasQuantidade: TWideStringField;
    estcurrentitem: TDBEdit;
    ReposiodeEstoque1: TMenuItem;
    adoprodutosCódigo: TAutoIncField;
    adoprodutosDescrição: TWideStringField;
    adoprodutosPreço: TBCDField;
    adoprodutosEstoque: TIntegerField;
    atualizaprod: TTimer;
    adolistacompra: TADODataSet;
    sourcelistacompra: TDataSource;
    adorelreposicao: TADODataSet;
    sourcerelreposicao: TDataSource;
    adorelreposicaoProduto: TWideStringField;
    adorelreposicaoQuantidade: TWideStringField;
    adorelreposicaoGasto: TWideStringField;
    adorelreposicaoData: TWideStringField;
    adolistacompraProduto: TWideStringField;
    adolistacompraQuantidade: TIntegerField;
    adolistacompraPreçounidade: TBCDField;
    adolistacompraTotal: TBCDField;
    adorelreposicaoVendedor: TWideStringField;
   procedure Calculadora1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pesquisarChange(Sender: TObject);
    procedure tipoChange(Sender: TObject);
    procedure pesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure codprodvendaKeyPress(Sender: TObject; var Key: Char);
    procedure quantprodKeyPress(Sender: TObject; var Key: Char);
    procedure pesquisa2gChange(Sender: TObject);
    procedure tipo2gChange(Sender: TObject);
    procedure dbeddescripKeyPress(Sender: TObject; var Key: Char);
    procedure VendasEnter(Sender: TObject);
    procedure GerenciarProdutosEnter(Sender: TObject);
    procedure dbedpreçoKeyPress(Sender: TObject; var Key: Char);
    procedure dbedestoqueKeyPress(Sender: TObject; var Key: Char);
    procedure addprodClick(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure pesquisa3gChange(Sender: TObject);
    procedure tipo3gChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dbednomeKeyPress(Sender: TObject; var Key: Char);
    procedure dbedrgcpfKeyPress(Sender: TObject; var Key: Char);
    procedure dbedendKeyPress(Sender: TObject; var Key: Char);
    procedure dbedtelKeyPress(Sender: TObject; var Key: Char);
    procedure dbedemailKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tipo4gChange(Sender: TObject);
    procedure pesquisa4gChange(Sender: TObject);
    procedure fornewClick(Sender: TObject);
    procedure fornomeKeyPress(Sender: TObject; var Key: Char);
    procedure foremailKeyPress(Sender: TObject; var Key: Char);
    procedure forrepresentaKeyPress(Sender: TObject; var Key: Char);
    procedure fortelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure addavendaClick(Sender: TObject);
    procedure passwordEnter(Sender: TObject);
    procedure passwordExit(Sender: TObject);
    procedure userKeyPress(Sender: TObject; var Key: Char);
    procedure passwordKeyPress(Sender: TObject; var Key: Char);
    procedure A1Click(Sender: TObject);
    procedure Removervendedor1Click(Sender: TObject);
    procedure codprodvendaChange(Sender: TObject);
    procedure concluivendaClick(Sender: TObject);
    procedure verificalistaTimer(Sender: TObject);
    procedure Relatrios1Click(Sender: TObject);
    procedure atualizaprodTimer(Sender: TObject);
    procedure ReposiodeEstoque1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainform: Tmainform;

implementation
procedure EnDecryptFile(INFName, OutFName : String; Chave : Word);
var
InMS, OutMS : TMemoryStream;
I : Integer;
C : byte;
begin
  InMS := TMemoryStream.Create;
  OutMS := TMemoryStream.Create;
  try
  InMS.LoadFromFile(INFName);
  InMS.Position := 0;
  for I := 0 to InMS.Size - 1 do
  begin
    InMS.Read(C, 1);
    C := (C xor not(ord(chave shr I)));
    OutMS.Write(C,1);
  end;
  OutMS.SaveToFile(OutFName);
  finally
  InMS.Free;
  OutMS.Free;
end;
end;

{$R *.dfm}

procedure Tmainform.A1Click(Sender: TObject);
var
erro:word;
begin
Erro := WinExec('newuser.exe xcv23edwrty67y233jn23323nnas@#$%d', SW_SHOW);
if Erro <= 31 then
ShowMessage('Erro desconhecido ao executar o setup de criação de usuários - ERRO 0X087')
end;

procedure Tmainform.addavendaClick(Sender: TObject);
var
qnt,pre,fn,pr:real;
finalpre:string;
begin
if codprodvenda.text='' then
abort;
if quantprod.text='' then
abort;
if descurrentitem.Text='' then
begin
  showmessage('Não foi encontrado nenhum item com este código.');
  abort;
end;
if strtoint(quantprod.Text)>strtoint(estcurrentitem.text) then
begin
showmessage('Quantidade é maior que o estoque do produto.');
  abort;
end;
if quantprod.Text='0' then
abort;
qnt:=strtofloat(quantprod.text);
pre:=strtofloat(precurrentitem.text);
fn:=qnt*pre;
finalpre:=floattostr(fn);
adolista.Append;
adolistadescrição.AsString:=descurrentitem.text;
adolistapreço.AsString:=finalpre;
adolistaquantidade.AsString:=quantprod.Text;
adolista.Post;
adolista.Refresh;
//Calcula preço
pr:=0;
with adolista do
begin
disablecontrols;
first;
  While not Eof do
  begin
  pr:=pr+strtofloat(FieldByname('Preço').Text);
  Next;
end;
enablecontrols;
end;
if Frac(pr) = 0.00 then
begin
listatotal.Caption:=floattostr(pr)+',00';
codprodvenda.SetFocus;
abort;
end;
if Frac(pr*10) = 0.00 then
begin
listatotal.Caption:=floattostr(pr)+'0';
codprodvenda.SetFocus;
abort;
end;
listatotal.Caption:=floattostr(pr);
end;

procedure Tmainform.addprodClick(Sender: TObject);
begin
adoprodutos.Append;
dbeddescrip.SetFocus;
end;

procedure Tmainform.atualizaprodTimer(Sender: TObject);
                         begin
adovaloresvenda.Close;
adovaloresvenda.CommandText:='Select * from produtos where Código LIKE :busca2';
adovaloresvenda.Parameters.ParamByName('busca2').Value:='%'+codprodvenda.Text+'%';
adovaloresvenda.Open;
adovaloresvenda.Active:=True;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
 adoclientes.Append;
dbednome.SetFocus;
end;

procedure Tmainform.Calculadora1Click(Sender: TObject);
begin
ShellExecute(0,nil,'Calc',nil,nil,sw_show);
end;

procedure Tmainform.codprodvendaChange(Sender: TObject);
begin
adovaloresvenda.Close;
adovaloresvenda.CommandText:='Select * from produtos where Código LIKE :busca2';
adovaloresvenda.Parameters.ParamByName('busca2').Value:='%'+codprodvenda.Text+'%';
adovaloresvenda.Open;
adovaloresvenda.Active:=True;
end;

procedure Tmainform.codprodvendaKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
quantprod.SetFocus;
end;

procedure Tmainform.concluivendaClick(Sender: TObject);
var
P:tvendaconclui;
begin
P:=Tvendaconclui.Create(nil);
P.ShowModal;
FreeAndNil(P);
end;


procedure Tmainform.dbeddescripKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbedpreço.SetFocus;
end;

procedure Tmainform.dbedemailKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbednotes.SetFocus;
end;

procedure Tmainform.dbedendKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbedtel.SetFocus;
end;

procedure Tmainform.dbedestoqueKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbeddescrip.SetFocus;
end;

procedure Tmainform.dbednomeKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbedrgcpf.SetFocus;
end;

procedure Tmainform.dbedpreçoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbedestoque.SetFocus;
end;


procedure Tmainform.dbedrgcpfKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbedend.SetFocus;
end;

procedure Tmainform.dbedtelKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
dbedemail.SetFocus;
end;

procedure Tmainform.foremailKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
forrepresenta.SetFocus;
end;

procedure Tmainform.pesquisa3gChange(Sender: TObject);
begin
 if tipo3g.Text='' then
begin
  showmessage('Selecione um tipo de pesquisa');
  abort;
end;
 adoclientes.Close;
adoclientes.CommandText:='Select * from clientes where '+tipo3g.text+' LIKE :busca';
adoclientes.Parameters.ParamByName('busca').Value:='%'+pesquisa3g.Text+'%';
adoclientes.Open;
adoclientes.Active:=True;
end;

procedure Tmainform.pesquisa4gChange(Sender: TObject);
begin
 if tipo4g.Text='' then
 begin
   showmessage('Selecione um tipo de pesquisa');
   abort;
 end;
adofornecedor.Close;
adofornecedor.CommandText:='Select * from fornecedores where '+tipo4g.text+' LIKE :busca';
adofornecedor.Parameters.ParamByName('busca').Value:='%'+pesquisa4g.Text+'%';
adofornecedor.Open;
adofornecedor.Active:=True;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
J:Tfrmsplash;
begin
connectdb.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+extractfilepath(application.ExeName)+'db.dat;Persist Security Info=False;';
connectdb.connected:=true;
adovendas.Active:=true;
adoprodutos.Active:=true;
adoclientes.Active:=true;
adofornecedor.Active:=true;
adolista.Active:=true;
adovaloresvenda.Active:=true;
adorelvendas.Active:=true;
adorelreposicao.Active:=true;
adolistacompra.Active:=true;
J:=Tfrmsplash.Create(nil);
  J.ShowModal;
      FreeAndNil(J);
if adolista.RecordCount>0 then
With Adolista do
 While RecordCount > 0 do
Delete;
if adolistacompra.RecordCount>0 then
With Adolistacompra do
 While RecordCount > 0 do
Delete;
end;

procedure Tmainform.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  pr:real;
  begin
if (key = vk_F5) then
begin
if adoclientes.State=dsbrowse then
else
dbnavigator4.BtnClick(nbpost);
if adofornecedor.State=dsbrowse then
else
dbnavigator7.BtnClick(nbpost);
 if adoprodutos.State=dsbrowse then
else
dbnavigator1.BtnClick(nbpost);
end;
if (key = vk_F6) then
begin
if adolista.RecordCount>0 then
concluivenda.Click;
end;
if (key = vk_F7) then
begin
dbnavigator8.BtnClick(nbDelete);
 pr:=0;
with adolista do
begin
disablecontrols;
first;
  While not Eof do
  begin
  pr:=pr+strtofloat(FieldByname('Preço').Text);
  Next;
end;
enablecontrols;
end;
listatotal.Caption:=floattostr(pr);
end;
if (key = vk_F10) then
begin
  loginprompt.Visible:=true;
  user.clear;
  password.Clear;
  activeuser.Caption:='';
  a1.Enabled:=false;
  removervendedor1.Enabled:=false;
  password.Font.Name:='Arial';
password.Font.Charset:=ANSI_CHARSET;
relatrios1.Enabled:=false;
reposiodeestoque1.Enabled:=false;
end;
end;

procedure Tmainform.fornewClick(Sender: TObject);
begin
 adofornecedor.Append;
fornome.SetFocus;
end;

procedure Tmainform.fornomeKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
foremail.SetFocus;
end;

procedure Tmainform.forrepresentaKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
fortelefone.SetFocus;
end;

procedure Tmainform.fortelefoneKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
fornotas.SetFocus;
end;

procedure Tmainform.GerenciarProdutosEnter(Sender: TObject);
begin
adoprodutos.Refresh;
end;

procedure Tmainform.passwordEnter(Sender: TObject);
begin
password.Font.Name:='Wingdings';
password.Font.Charset:=SYMBOL_CHARSET;
end;

procedure Tmainform.passwordExit(Sender: TObject);
begin
if password.Text<>'' then
else
begin
password.Font.Name:='Arial';
password.Font.Charset:=ANSI_CHARSET;
end;
end;

procedure Tmainform.passwordKeyPress(Sender: TObject; var Key: Char);
var
arq:tinifile;
dir,pass:string;
fzrVendas,
grnClientes,
vzrClientes,
grnProdutos,
vzrProdutos,
grnEstoque,
vzrEstoque,
grnHistoricos,
vzrHistoricos,
cdrUsuarios,rprEstoque:string;
begin
if key=#13 then
begin
 dir:=extractfilepath(application.exename);
if fileexists('vend.shp') then
 EnDecryptFile('vend.shp','tempdata.shp',43)
 else
 showmessage('Não foi possível fazer login por falta de arquivo de definições.');
arq:=tinifile.Create(''+(dir)+'\tempdata.shp');
pass:=arq.ReadString(user.Text,'p','internalerror09xx23223x0552$%%$$$$##$##4');
fzrVendas:=arq.ReadString(user.Text,'fzrVendas','n');
grnClientes:=arq.ReadString(user.Text,'grnClientes','n');
vzrClientes:=arq.ReadString(user.Text,'vzrClientes','n');
grnProdutos:=arq.ReadString(user.Text,'grnProdutos','n');
vzrProdutos:=arq.ReadString(user.Text,'vzrProdutos','n');
grnEstoque:=arq.ReadString(user.Text,'grnEstoque','n');
vzrEstoque:=arq.ReadString(user.Text,'vzrEstoque','n');
grnHistoricos:=arq.ReadString(user.Text,'grnHistoricos','n');
vzrHistoricos:=arq.ReadString(user.Text,'vzrHistoricos','n');
cdrUsuarios:=arq.ReadString(user.Text,'cdrUsuarios','n');
rprEstoque:=arq.ReadString(user.Text,'rprEstoque','n');
deletefile('tempdata.shp');
if pass=password.text then
begin
activeuser.Caption:=user.Text;
if fzrVendas='s' then
concluivenda.Enabled:=true
else
concluivenda.Enabled:=false;
if grnClientes='s' then
begin
  gerenciaclientes.Enabled:=true;
  tabclientes.ReadOnly:=false;
end
else
begin
 gerenciaclientes.Enabled:=false;
  tabclientes.ReadOnly:=true;
end;
if vzrClientes='s' then
adoclientes.active:=true
else
adoclientes.active:=false;
if grnProdutos='s' then
begin
  gerenciaprods.Enabled:=true;
  tabprodutos.ReadOnly:=false;
  dbedpreço.Enabled:=false;
  dbedestoque.Enabled:=false;
end
else
begin
    gerenciaprods.Enabled:=false;
  tabprodutos.ReadOnly:=true;
    dbedpreço.Enabled:=false;
  dbedestoque.Enabled:=false;
end;
if vzrProdutos='s' then
adoprodutos.active:=true
else
adoprodutos.active:=false;
if vzrHistoricos='s' then
relatrios1.Enabled:=true
else
relatrios1.Enabled:=false;
if grnEstoque='s' then
begin
dbedpreço.Enabled:=true;
dbedestoque.Enabled:=true;
tabprodutos.ReadOnly:=false;
end
else
begin
tabprodutos.ReadOnly:=true;
    dbedpreço.Enabled:=false;
  dbedestoque.Enabled:=false;
end;
if rprEstoque='s' then
reposiodeestoque1.Enabled:=true
else
reposiodeestoque1.Enabled:=false;
if cdrUsuarios='s' then
begin
  a1.Enabled:=true;
  removervendedor1.Enabled:=true;
end
else
begin
  a1.Enabled:=false;
  removervendedor1.Enabled:=false;
end;
loginprompt.Visible:=false
end
else
showmessage('Desculpe '+(user.text)+', não foi possível logar no sistema.');
end;
end;


procedure Tmainform.pesquisa2gChange(Sender: TObject);
begin
 if tipo2g.Text='' then
begin
  showmessage('Selecione um tipo de pesquisa');
  abort;
end;
if tipo2g.Text<>'Em Estoque' then
begin
pesquisa2g.Enabled:=true;
adoprodutos.Close;
adoprodutos.CommandText:='Select * from produtos where '+tipo2g.text+' LIKE :busca';
adoprodutos.Parameters.ParamByName('busca').Value:='%'+pesquisa2g.Text+'%';
adoprodutos.Open;
adoprodutos.Active:=True;
end
else
begin
pesquisa2g.Enabled:=false;
 adoprodutos.Close;
adoprodutos.CommandText:='Select * from produtos where Estoque=''Sim''';
adoprodutos.Open;
adoprodutos.Active:=True;
end;
end;

procedure Tmainform.pesquisarChange(Sender: TObject);
begin
if tipo.Text='' then
begin
  showmessage('Selecione um tipo de pesquisa');
  abort;
end;
if tipo.Text<>'Em Estoque' then
begin
pesquisar.Enabled:=true;
adovendas.Close;
adovendas.CommandText:='Select * from produtos where '+tipo.text+' LIKE :busca';
adovendas.Parameters.ParamByName('busca').Value:='%'+pesquisar.Text+'%';
adovendas.Open;
adovendas.Active:=True;
end
else
begin
pesquisar.Enabled:=false;
 adovendas.Close;
adovendas.CommandText:='Select * from produtos where Estoque=''Sim''';
adovendas.Open;
adovendas.Active:=True;
end;
end;

procedure Tmainform.pesquisarKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
codprodvenda.SetFocus;
end;

procedure Tmainform.quantprodKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
addavenda.SetFocus;
end;

procedure Tmainform.Relatrios1Click(Sender: TObject);
var
P:tfrmHistorico;
begin
P:=TfrmHistorico.Create(nil);
P.ShowModal;
FreeAndNil(P);
end;

procedure Tmainform.Removervendedor1Click(Sender: TObject);
var
erro:word;
begin
Erro := WinExec('deluser.exe xcv23edwrty67y233jn23323nnas@#$%7', SW_SHOW);
  if Erro <= 31 then
    ShowMessage('Erro desconhecido - ERRO 0X093')
end;

procedure Tmainform.ReposiodeEstoque1Click(Sender: TObject);
var
P:Trestoque;
begin
P:=TrEstoque.Create(nil);
P.ShowModal;
FreeAndNil(P);
end;

procedure Tmainform.Sobre1Click(Sender: TObject);
var
Y:Tsobre;
begin
Y:=TSOBRE.Create(nil);
Y.ShowModal;
FreeAndNil(Y);
end;

procedure Tmainform.tipo2gChange(Sender: TObject);
begin
 if tipo2g.Text<>'Em Estoque' then
begin
pesquisa2g.Enabled:=true;
adoprodutos.Close;
adoprodutos.CommandText:='Select * from produtos where '+tipo2g.text+' LIKE :busca';
adoprodutos.Parameters.ParamByName('busca').Value:='%'+pesquisa2g.Text+'%';
adoprodutos.Open;
adoprodutos.Active:=True;
end
else
begin
pesquisa2g.Enabled:=false;
 adoprodutos.Close;
adoprodutos.CommandText:='Select * from produtos where Estoque>0';
adoprodutos.Open;
adoprodutos.Active:=True;
end;
end;

procedure Tmainform.tipo3gChange(Sender: TObject);
begin
 adoclientes.Close;
adoclientes.CommandText:='Select * from clientes where '+tipo3g.text+' LIKE :busca';
adoclientes.Parameters.ParamByName('busca').Value:='%'+pesquisa3g.Text+'%';
adoclientes.Open;
adoclientes.Active:=True;
end;

procedure Tmainform.tipo4gChange(Sender: TObject);
begin
adofornecedor.Close;
adofornecedor.CommandText:='Select * from fornecedores where '+tipo4g.text+' LIKE :busca';
adofornecedor.Parameters.ParamByName('busca').Value:='%'+pesquisa4g.Text+'%';
adofornecedor.Open;
adofornecedor.Active:=True;
end;

procedure Tmainform.tipoChange(Sender: TObject);
begin
if tipo.Text<>'Em Estoque' then
begin
pesquisar.Enabled:=true;
adovendas.Close;
adovendas.CommandText:='Select * from produtos where '+tipo.text+' LIKE :busca';
adovendas.Parameters.ParamByName('busca').Value:='%'+pesquisar.Text+'%';
adovendas.Open;
adovendas.Active:=True;
end
else
begin
pesquisar.Enabled:=false;
 adovendas.Close;
adovendas.CommandText:='Select * from produtos where Estoque>0';
adovendas.Open;
adovendas.Active:=True;
end;
end;

procedure Tmainform.userKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
password.SetFocus;
end;

procedure Tmainform.VendasEnter(Sender: TObject);
begin
adovendas.Active:=false;
adovendas.Active:=true;
end;

procedure Tmainform.verificalistaTimer(Sender: TObject);
begin
if adolista.RecordCount>0 then
concluivenda.Enabled:=true
else
concluivenda.Enabled:=false;

end;

end.
