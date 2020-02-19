{ lib
, buildPythonPackage
, fetchFromGitHub
, astropy
, pytestCheckHook
, pytest
, isPy3k
}:

buildPythonPackage rec {
  pname = "pytest-astropy-header";
  version = "0.1.2";

  disabled = !isPy3k;

  src = fetchFromGitHub {
    owner = "astropy";
    repo = pname;
    rev = "v${version}";
    sha256 = "08ly4cqxyj409cf2a8asdby1c4vdkqv4r38l0hlx4qxjkg7wfm5q";
  };

  checkInputs = [ pytestCheckHook astropy ];
  propagatedBuildInputs = [ pytest ];

  meta = with lib; {
    description = "pytest plugin to add diagnostic information to the header of the test output";
    homepage = "https://github.com/astropy/pytest-astropy-header";
    license = licenses.bsd3;
    maintainers = with maintainers; [ xbreak ];
  };
}
