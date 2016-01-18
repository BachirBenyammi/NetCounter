unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, StdCtrls, Mask, Menus, ExtCtrls;

type
  TMainFrm = class(TForm)
    Panel1: TPanel;
    btnAdd: TBitBtn;
    Edit_Time: TMaskEdit;
    adoTable: TADOTable;
    Label1: TLabel;
    Label2: TLabel;
    RBC: TRadioButton;
    RBD: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure Edit_TimeKeyPress(Sender: TObject; var Key: Char);
  end;

var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}

procedure TMainFrm.FormCreate(Sender: TObject);
var
  path: string;
begin
  path := Application.ExeName;
  path := ExtractFilePath(path);
  if path[length(path)]<> '\' then
    path := path + '\';
  path := path + 'connexion.mdb';
  adoTable.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0; Persist Security Info=False; Data Source=' + path;
  adoTable.Active := true;
end;

procedure TMainFrm.btnAddClick(Sender: TObject);
var
  value: string;
  i: byte;
begin
  value := Edit_Time.Text;
  for i:= 1 to length(value) do
    if (value[i] = ' ') or (value[i] = '') then
      value[i] := '0';
  Edit_Time.Text := value;
  if (StrToInt(copy (value,1,2)) < 12 ) and
    (StrToInt(copy (value,4,2)) < 60 ) then
      begin
        adoTable.Insert;
        adoTable.FieldByName('temps').Value := StrToTime(Edit_Time.Text);
        adoTable.FieldByName('time').Value := Now;
        adoTable.FieldByName('type').Value := RBC.Checked; 
        adoTable.Post;
        Free;
    end
  else
    begin
      ShowMessage('Invalid time');
      Edit_Time.Text := '00:00';
    end;
end;

procedure TMainFrm.Edit_TimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnAddClick(Sender);
end;

end.
