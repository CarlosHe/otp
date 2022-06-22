unit OTP.Contract.Core.Calculator;

interface

type

  IOTPCalculator = interface
    ['{E359F5C2-69DB-4A25-A6FA-9026F3D3F180}']
    function SetKeyRegeneration(const AKeyRegeneration: Integer): IOTPCalculator;
    function SetSecret(const ASecret: string): IOTPCalculator;
    function SetCounter(const ACounter: Int64): IOTPCalculator;
    function SetLength(const ALength: Word): IOTPCalculator;
    function Calculate: UInt32;
  end;

implementation

end.
