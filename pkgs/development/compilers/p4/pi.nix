{ stdenv
, fetchFromGitHub
, autoreconfHook
, pkgconfig
, protobuf
, boost
, judy
, grpc
, openssl
, zlib
, c-ares
}:

stdenv.mkDerivation rec {
  name = "pi-1.2.0";

  src = fetchFromGitHub {
    owner = "p4lang";
    repo = "PI";
    rev = "1539ecd8a50c159b011d9c5a9c0eba99f122a845";
    sha256 = "0zhqwfnd5kdqx6x5pl9yv546ldzxrhq2zdi37kwwrwvd6fdm2ygv";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    autoreconfHook
    pkgconfig
  ];
  
  buildInputs = [
    protobuf
    boost
    judy
    grpc
    openssl
    zlib
    c-ares
  ];

  enableParallelBuilds = true;

  configureFlags = [
    "--with-proto"
    "--without-cli"
    "--without-internal-rpc"
    "--with-boost=${boost.dev}"
    "--with-boost-libdir=${boost.out}/lib"
  ];

  meta = with stdenv.lib; {
    homepage = https://p4.org;
    description = "p4c is a reference compiler for the P4 programming language";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ ragge ];
  };

}
