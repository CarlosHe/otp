unit OTP.Contract.Core.Validator;

interface

type

  IOTPValidator = interface
    ['{ACCCF6D2-D019-40D8-BB81-D8F6B786AE63}']
    function SetKeyRegeneration(const AKeyRegeneration: Integer): IOTPValidator;
    function SetWindowSize(const AWindowSize: Word): IOTPValidator;
    function SetToken(const AToken: UInt32): IOTPValidator;
    procedure Validate;
  end;

implementation

end.
