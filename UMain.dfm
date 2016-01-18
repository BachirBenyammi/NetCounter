object MainFrm: TMainFrm
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  ClientHeight = 54
  ClientWidth = 169
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 169
    Height = 54
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 26
      Height = 13
      Caption = '&Time:'
    end
    object Label2: TLabel
      Left = 8
      Top = 34
      Width = 40
      Height = 13
      Caption = 'Connet.:'
      FocusControl = RBC
    end
    object btnAdd: TBitBtn
      Left = 96
      Top = 8
      Width = 63
      Height = 25
      Caption = '&Add'
      Default = True
      TabOrder = 1
      OnClick = btnAddClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object Edit_Time: TMaskEdit
      Left = 40
      Top = 8
      Width = 49
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 0
      Text = '00:00'
      OnKeyPress = Edit_TimeKeyPress
    end
    object RBC: TRadioButton
      Left = 56
      Top = 34
      Width = 49
      Height = 17
      Caption = '&Cerist'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object RBD: TRadioButton
      Left = 104
      Top = 34
      Width = 57
      Height = 17
      Caption = '&Djaweb'
      TabOrder = 3
    end
  end
  object adoTable: TADOTable
    TableName = 'tbTemps'
    Left = 8
  end
end
