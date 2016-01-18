unit UTray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, Menus, StdCtrls, ImgList, Buttons;

Const
  WM_MYMESSAGE=WM_USER+100;

type
  TTryFrm = class(TForm)
    Popup: TPopupMenu;
    Show1: TMenuItem;
    Exit1: TMenuItem;
    ImageList1: TImageList;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure WMHotkey(Var msg:TWMHotkey);message WM_HOTKEY;
    procedure TrayMessage(var Msg:TMessage);message WM_MYMESSAGE;
    Procedure AddToSysTray(Msg:String;Icon:TIcon);
    procedure Exit1Click(Sender: TObject);
    procedure Show1Click(Sender: TObject);
    procedure ShowHide;
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  end;

var
  TryFrm: TTryFrm;
  IconData : TNotifyIconData;
  AutoHide : Boolean = True;

implementation

uses UMain;

{$R *.dfm}

Procedure TTryFrm.AddToSysTray(Msg:String;Icon:TIcon);
var
  I:byte;
begin
  with IconData do
    begin
      cbSize := SizeOf(IconData);
      Wnd := Handle;
      uID := 1;
      uFlags := NIF_ICON or NIF_TIP or NIF_MESSAGE;
      uCallbackMessage := WM_MYMESSAGE;
      hIcon := Icon.Handle;
      for i := 0 to length(Msg) - 1 do
        szTip[i] := Msg[i+1];
      szTip[length(Msg)] := #0;
      Shell_NotifyIcon(NIM_Modify, @IconData)
    end;
end;

procedure TTryFrm.TrayMessage(var Msg:TMessage);
 var Souris:TPoint;
begin
  case Msg.LParam of
    WM_RBUTTONDOWN:
      begin
        SetForegroundWindow(Handle);
        GetCursorPos(souris);
        Popup.Popup(souris.x,souris.y);
      end;
    WM_LBUTTONDOWN:
      begin
        SetForegroundWindow(Handle);
        ShowHide;
      end;
  end;
end;

procedure CreateFrm;
begin
  MainFrm := TMainFrm.Create(Application);
  MainFrm.Left := Screen.WorkAreaWidth - MainFrm.Width;
  MainFrm.Top := Screen.WorkAreaHeight - MainFrm.Height;
  MainFrm.Show;
end;

procedure TTryFrm.ShowHide;
begin
if TForm(Application.FindComponent('MainFrm'))<> nil then
      begin
        MainFrm.Free;
        show1.Caption := '&Show';
        show1.ImageIndex := 1;
      end
    else
      begin
        CreateFrm;
        show1.Caption := '&Hide';
        show1.ImageIndex := 0;
      end;
end;

procedure TTryFrm.WMHotkey(Var msg:TWMHotkey);
Begin
  if msg.HotKey=1 then
    ShowHide
end;

procedure TTryFrm.FormCreate(Sender: TObject);
var
  msg: string;
  i: byte;
begin
  Msg:=Application.Title;
  with IconData do
    begin
      cbSize:=SizeOf(IconData);
      Wnd:=Handle;uID:=1;
      uFlags:=NIF_ICON or NIF_TIP or NIF_MESSAGE;
      uCallbackMessage:=WM_MYMESSAGE;
      hIcon:=Application.Icon.Handle;
      for i:=0 to length(Msg)-1 do
       szTip[i]:=Msg[i+1];
      szTip[length(Msg)]:=#0;
      Shell_NotifyIcon(NIM_ADD,@IconData)
   end;
  RegisterHotkey(Handle,1,Mod_Control+Mod_Alt,ord(13));
end;

procedure TTryFrm.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE,@IconData);
  UnRegisterHotkey(Handle,1);
end;

procedure TTryFrm.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TTryFrm.Show1Click(Sender: TObject);
begin
  ShowHide;
end;

procedure TTryFrm.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle,Sw_Hide);
end;

procedure TTryFrm.FormPaint(Sender: TObject);
begin
 If AutoHide Then
   begin
    Hide;
    AutoHide:=False;
   end;
end;

end.
