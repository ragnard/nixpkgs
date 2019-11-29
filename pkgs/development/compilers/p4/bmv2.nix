{ stdenv
, fetchFromGitHub
, autoreconfHook
, bash
, flex
, bison
, thrift
, nanomsg
, judy
, gmp
, libpcap
, boost
, libevent
, python2
, libpi
}:

stdenv.mkDerivation rec {
  name = "bmv2-1.13.0-master";

  src = fetchFromGitHub {
    owner = "p4lang";
    repo = "behavioral-model";
    rev = "16c699953ee02306731ebf9a9241ea9fe3bbdc8c";
    sha256 = "0y433vfiq3sz9dh9ck316j2cvzpsi5pgpps65hqval5fj0qzk85p";
  };

  preAutoreconf = ''
    for file in $(ls tools/*.sh)
    do
        substituteInPlace $file --replace "#!/bin/bash" "#!${bash}/bin/bash"
    done
  '';

  nativeBuildInputs = [
    autoreconfHook
  ];

  buildInputs = [
    flex
    bison
    thrift
    nanomsg
    judy
    gmp
    libpcap
    boost
    libevent
    python2
    libpi
  ];

  configureFlags = [
    "--without-thrift"
    "--without-nanomsg"
    "--with-pi"
  ];
  
  # installPhase = ''
  #   mkdir -p $out/{bin,lib}
  #   cp $src/targets/simple_switch/.libs/*.so* $out/lib
  #   cp $src/targets/simple_switch/.libs/simple_switch $out/bin
  # '';
  
  meta = with stdenv.lib; {
    homepage = https://p4.org;
    description = "The reference P4 software switch";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ ragge ];
  };

}
