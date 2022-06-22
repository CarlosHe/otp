unit OTP;

interface

uses
  OTP.Contract.Core.SecretGenerator,
  OTP.Contract.Core.Calculator,
  OTP.Contract.Core.Validator,
  OTP.Core.SecretGenerator,
  OTP.Core.Calculator,
  OTP.Core.Validator,
  OPT.Exception.InvalidToken;

type
  IOTPSecretGenerator = OTP.Contract.Core.SecretGenerator.IOTPSecretGenerator;
  IOTPCalculator = OTP.Contract.Core.Calculator.IOTPCalculator;
  IOTPValidator = OTP.Contract.Core.Validator.IOTPValidator;
  TOTPSecretGenerator = OTP.Core.SecretGenerator.TOTPSecretGenerator;
  TOTPCalculator = OTP.Core.Calculator.TOTPCalculator;
  TOTPValidator = OTP.Core.Validator.TOTPValidator;
  EOTPInvalidToken = OPT.Exception.InvalidToken.EOTPInvalidToken;

implementation

end.
