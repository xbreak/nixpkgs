{ lib
, buildPythonPackage
, fetchPypi
, hypothesis
, pytest
, pytest-astropy-header
, pytestcov
, pytest-doctestplus
, pytest-remotedata
, pytest-openfiles
, pytest-arraydiff
, pytest-filter-subpackage
, setuptools_scm
}:

buildPythonPackage rec {
  pname = "pytest-astropy";
  version = "0.8.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "18j6z6y2fvykmcs5z0mldhhaxxn6wzpnhlm2ps7m8r5z5kmh1631";
  };

  nativeBuildInputs = [ setuptools_scm ];
  propagatedBuildInputs = [
    hypothesis
    pytest
    pytestcov
    pytest-astropy-header
    pytest-doctestplus
    pytest-remotedata
    pytest-openfiles
    pytest-arraydiff
    pytest-filter-subpackage
  ];

  # pytest-astropy is a meta package and has no tests
  doCheck = false;

  meta = with lib; {
    description = "Meta-package containing dependencies for testing";
    homepage = "https://astropy.org";
    license = licenses.bsd3;
    maintainers = [ maintainers.costrouc ];
  };
}
