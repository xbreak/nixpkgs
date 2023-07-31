{ rustPlatform
, fetchFromGitHub
, lib
, pkg-config
, gtk3
}:

rustPlatform.buildRustPackage {
  pname = "pop-shell-shortcuts";
  version = "unstable-2021-10-01";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell-shortcuts";
    rev = "52cc83fb0b0e77c1ffa8de9f0c22dc372f32bb02";
    sha256 = "sha256-I6uaAmV+oqK0xNn5sozVtk+r9UwPn18XCNAuTH9jeIs=";
  };

  cargoSha256 = "sha256-x/zSSp+qcSin6UADMYkUPmoZbHMSkWbLFj1RsMDrY5g=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ gtk3 ];

  meta = with lib; {
    description = " Application for displaying and demoing Pop Shell shortcuts";
    homepage = "https://github.com/pop-os/shell-shortcuts";
    platforms = platforms.linux;
    license = licenses.gpl3;
    maintainers = with maintainers; [ xbreak ];
  };
}
