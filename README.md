# Time-based one-time password

This is a simple Delphi library that will generate TOTP tokens. The library fully conforms to RFCs 4226.

## ⚙️ Installation
Installation is done using the [`boss install`](https://github.com/HashLoad/boss) command:
``` sh
boss install https://github.com/CarlosHe/otp
```

## ⚡️ Generate a new secret
```delphi
uses
  OTP;

var
  LSecret: string;
begin
  LSecret := TOTPSecretGenerator.New
    .SetKeyLength(10)
    .Generate;
end.
```

## ⚡️ Generate a new token
```delphi
uses
  OTP;

var
  LToken: UInt32;
begin
  LToken := TOTPCalculator.New
    .SetSecret('MYSECRETBASE32')
    .Calculate;
end.
```

## ⚡️ Validate a token
```delphi
uses
  OTP;

begin
  TOTPValidator.New(
    TOTPCalculator
      .New
      .SetSecret('MYSECRETBASE32')
  )
  .SetToken(102030)
  .Validate;
end.
```