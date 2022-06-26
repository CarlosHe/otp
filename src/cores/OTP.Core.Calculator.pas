unit OTP.Core.Calculator;

interface

uses
  OTP.Contract.Core.Calculator;

type

  TOTPCalculator = class(TInterfacedObject, IOTPCalculator)
  private
    { private declarations }
    FSecret: string;
    FCounter: Int64;
    FKeyRegeneration: Integer;
    FLength: Byte;
  protected
    { protected declarations }
    constructor Create;
  public
    { public declarations }
    function SetKeyRegeneration(const AKeyRegeneration: Integer): IOTPCalculator;
    function SetSecret(const ASecret: string): IOTPCalculator;
    function SetCounter(const ACounter: Int64): IOTPCalculator;
    function SetLength(const ALength: Byte): IOTPCalculator;
    function Calculate: UInt32;
    class function New: IOTPCalculator;
  end;

implementation

uses
  System.DateUtils,
  System.SysUtils,
  System.Hash,
  System.Math,
  OTP.Consts,
  OTP.Helper.ArrayBytes,
  Codec.Base32;

{ TOTPCalculator }

function TOTPCalculator.Calculate: UInt32;
var
  LHash: TArray<Byte>;
  LTimeKey: TArray<Byte>;
  LBinSecret: TArray<Byte>;
  LOffset: UInt8;
  LBinCode: UInt32;
  LTime: Int64;
begin
  LTime := DateTimeToUnix(Now(), False) div FKeyRegeneration;

  if FCounter <> -1 then
    LTime := FCounter;

  LBinSecret := TBase32.Decode(TEncoding.UTF8.GetBytes(FSecret));
  LTimeKey := LTimeKey.FromInt64(Int64(LTime)).Reverse;
  LHash := THashSHA1.GetHMACAsBytes(LTimeKey, LBinSecret);

  LOffset := (LHash[19] AND $0F);

  LBinCode := ((LHash[LOffset] and $7F) shl 24) or ((LHash[LOffset + 1] and $FF) shl 16) or ((LHash[LOffset + 2] and $FF) shl 8) or (LHash[LOffset + 3] and $FF);

  Result := LBinCode mod Trunc(IntPower(10, FLength));
end;

constructor TOTPCalculator.Create;
begin
  FCounter := -1;
  FKeyRegeneration := KEY_REGENERATION;
  FLength := OTP_LENGTH;
end;

class function TOTPCalculator.New: IOTPCalculator;
begin
  Result := TOTPCalculator.Create;
end;

function TOTPCalculator.SetCounter(const ACounter: Int64): IOTPCalculator;
begin
  Result := Self;
  FCounter := ACounter;
end;

function TOTPCalculator.SetKeyRegeneration(const AKeyRegeneration: Integer): IOTPCalculator;
begin
  Result := Self;
  FKeyRegeneration := AKeyRegeneration;
end;

function TOTPCalculator.SetLength(const ALength: Byte): IOTPCalculator;
begin
  Result := Self;
  FLength := ALength;
end;

function TOTPCalculator.SetSecret(const ASecret: string): IOTPCalculator;
begin
  Result := Self;
  FSecret := ASecret;
end;

end.
