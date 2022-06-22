unit OTP.Helper.ArrayBytes;

interface

type

  TArrayByteHelper = record helper for TArray<Byte>
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function Reverse: TArray<Byte>;
    function FromInt64(AValue: Int64): TArray<Byte>;
  end;

implementation

function TArrayByteHelper.Reverse: TArray<Byte>;
var
  I: Integer;
begin
  SetLength(Result, Length(Self));
  for I := High(Self) downto Low(Self) do
    Result[I] := Self[High(Self) - I];
end;

function TArrayByteHelper.FromInt64(AValue: Int64): TArray<Byte>;
begin
  Result := [];
  SetLength(Result, SizeOf(Int64));
  Move(AValue, Result[0], SizeOf(Int64));
end;

end.
