unit OTP.Core.Validator;

interface

uses
  OTP.Contract.Core.Validator,
  OTP.Contract.Core.Calculator;

type

  TOTPValidator = class(TInterfacedObject, IOTPValidator)
  private
    { private declarations }
    [weak]
    FOTPCalculator: IOTPCalculator;
    FKeyRegeneration: Integer;
    FWindowSize: Word;
    FToken: UInt32;
  protected
    { protected declarations }
    constructor Create(const AOTPCalculator: IOTPCalculator);
    function IsValidToken: Boolean;
  public
    { public declarations }
    function SetKeyRegeneration(const AKeyRegeneration: Integer): IOTPValidator;
    function SetWindowSize(const AWindowSize: Word): IOTPValidator;
    function SetToken(const AToken: UInt32): IOTPValidator;
    procedure Validate;
    class function New(const AOTPCalculator: IOTPCalculator): IOTPValidator;
  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  OTP.Consts,
  OPT.Exception.InvalidToken,
  OTP.Resource.Exception;

{ TOTPValidator }

function TOTPValidator.IsValidToken: Boolean;
var
  LTime: Int64;
  LTestValue: Integer;
begin
  Result := False;
  LTime := DateTimeToUnix(Now, False) div FKeyRegeneration;
  FOTPCalculator.SetKeyRegeneration(FKeyRegeneration).SetCounter(LTime);
  for LTestValue := LTime - FWindowSize to LTime + FWindowSize do
  begin
    if (FOTPCalculator.SetCounter(LTestValue).Calculate = FToken) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

constructor TOTPValidator.Create(const AOTPCalculator: IOTPCalculator);
begin
  FOTPCalculator := AOTPCalculator;
  FKeyRegeneration := KEY_REGENERATION;
  FWindowSize := WINDOW_SIZE;
end;

class function TOTPValidator.New(const AOTPCalculator: IOTPCalculator): IOTPValidator;
begin
  Result := TOTPValidator.Create(AOTPCalculator);
end;

function TOTPValidator.SetKeyRegeneration(const AKeyRegeneration: Integer): IOTPValidator;
begin
  Result := Self;
  FKeyRegeneration := AKeyRegeneration;
end;

function TOTPValidator.SetToken(const AToken: UInt32): IOTPValidator;
begin
  Result := Self;
  FToken := AToken;
end;

function TOTPValidator.SetWindowSize(const AWindowSize: Word): IOTPValidator;
begin
  Result := Self;
  FWindowSize := AWindowSize;
end;

procedure TOTPValidator.Validate;
begin
  if not IsValidToken then
    raise EOTPInvalidToken.Create(sOTPInvalidToken);
end;

end.
