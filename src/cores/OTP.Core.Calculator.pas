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
    FLength: Word;
  protected
    { protected declarations }
    constructor Create;
  public
    { public declarations }
    function SetKeyRegeneration(const AKeyRegeneration: Integer): IOTPCalculator;
    function SetSecret(const ASecret: string): IOTPCalculator;
    function SetCounter(const ACounter: Int64): IOTPCalculator;
    function SetLength(const ALength: Word): IOTPCalculator;
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
  LOffset: UInt8;
  LPart1: UInt8;
  LPart2: UInt8;
  LPart3: UInt8;
  LPart4: UInt8;
  LKey: UInt32;
  LTime: Int64;
  LTimeKey: TArray<Byte>;
  LBinSecret: TArray<Byte>;
begin
  LTime := DateTimeToUnix(Now(), False) div FKeyRegeneration;

  if FCounter <> -1 then
    LTime := FCounter;

  LBinSecret := TBase32.Decode(TEncoding.UTF8.GetBytes(FSecret));
  LTimeKey :=  LTimeKey.FromInt64(Int64(LTime)).Reverse;
  LHash := THashSHA1.GetHMACAsBytes(LTimeKey, LBinSecret);

  LOffset := (LHash[19] AND $0F);
  LPart1 := (LHash[LOffset+0] AND $7F);
  LPart2 := (LHash[LOffset+1] AND $FF);
  LPart3 := (LHash[LOffset+2] AND $FF);
  LPart4 := (LHash[LOffset+3] AND $FF);

  LKey := (LPart1 shl 24) OR (LPart2 shl 16) OR (LPart3 shl 8) OR (LPart4);

  Result := LKey mod Trunc(IntPower(10, FLength));
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

function TOTPCalculator.SetLength(const ALength: Word): IOTPCalculator;
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
