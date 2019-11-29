{ stdenv
, fetchFromGitHub
, cmake
, llvm
, python3
, flex
, bison
, protobuf
, boost
, boehmgc
, gmp
, bmv2
}:

stdenv.mkDerivation rec {
  name = "p4c-1.2.0";

  src = fetchFromGitHub {
    owner = "p4lang";
    repo = "p4c";
    rev = "7029f1d61d413b9b5036f50d3add0ced13498ec2";
    sha256 = "1zkpscz7395g0vgxwshnx9b5966mpgdp63grbmh5mjvgq23m8i1m";
    fetchSubmodules = true;
  };

  buildInputs = [
    llvm
    cmake
    python3
    flex
    bison
    protobuf
    boost
    boehmgc
    gmp
  ];

  meta = with stdenv.lib; {
    homepage = https://p4.org;
    description = "p4c is a reference compiler for the P4 programming language";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ ragge ];
  };

}
