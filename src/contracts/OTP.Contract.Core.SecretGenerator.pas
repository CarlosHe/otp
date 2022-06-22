unit OTP.Contract.Core.SecretGenerator;

interface

type

  IOTPSecretGenerator = interface
    ['{744F8B5D-4085-469B-821E-B20EB69203CD}']
    function SetKeyLength(ALength: Word): IOTPSecretGenerator;
    function Generate: string;
  end;

implementation

end.
