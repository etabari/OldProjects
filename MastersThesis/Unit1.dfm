object Form1: TForm1
  Left = 452
  Top = 293
  Width = 688
  Height = 511
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    680
    484)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 240
    Top = 444
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 32
    Top = 444
    Width = 65
    Height = 22
    Anchors = [akLeft, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 5
  end
  object SpinEdit2: TSpinEdit
    Left = 128
    Top = 444
    Width = 65
    Height = 22
    Anchors = [akLeft, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 2
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 313
    Height = 405
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 3
    OnClick = ListBox1Click
  end
  object Panel1: TPanel
    Left = 328
    Top = 8
    Width = 342
    Height = 466
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    DesignSize = (
      342
      466)
    object PaintBox1: TPaintBox
      Left = 1
      Top = 1
      Width = 340
      Height = 464
      Align = alClient
    end
    object Label1: TLabel
      Left = 8
      Top = 445
      Width = 32
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Label1'
    end
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 5
    Width = 97
    Height = 17
    Caption = 'Updated Version '
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
end
