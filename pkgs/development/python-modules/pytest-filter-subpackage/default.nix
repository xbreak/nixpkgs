{ lib
, buildPythonPackage
, fetchFromGitHub
, pytest
, pytest-doctestplus
, setuptools_scm
, toml
, pytestCheckHook
, isPy3k
}:

buildPythonPackage rec {
  pname = "pytest-filter-subpackage";
  version = "0.1.1";
  
  disabled = !isPy3k;

  src = fetchFromGitHub {
    owner = "astropy";
    repo = pname;
    rev = "v${version}";
    sha256 = "0354lab3rl4a311y6zxnfzvm585skxzcn08mzn75fsxy7pj2nnc7";
  };

  preBuild = ''
    export SETUPTOOLS_SCM_PRETEND_VERSION="${version}"
  '';

  nativeBuildInputs = [ setuptools_scm toml pytest-doctestplus ];
  propagatedBuildInputs = [
    pytest
  ];
  checkInputs = [ toml pytest-doctestplus pytestCheckHook ];

  meta = with lib; {
    description = "Pytest plugin for filtering based on sub-packages";
    homepage = "https://github.com/astropy/pytest-filter-subpackage";
    license = licenses.bsd3;
    maintainers = with maintainers; [ xbreak ];
  };
}
