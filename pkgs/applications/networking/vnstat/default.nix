{ stdenv, fetchurl, gd, ncurses, sqlite }:

stdenv.mkDerivation rec {
  name = "vnstat-${version}";
  version = "2.2";

  src = fetchurl {
    sha256 = "0b7020rlc568pz6vkiy28kl8493z88wzrn18wv9b0iq2bv1pn2n6";
    url = "https://humdi.net/vnstat/${name}.tar.gz";
  };

  buildInputs = [ gd ncurses sqlite ];

  postPatch = ''
    substituteInPlace src/cfg.c --replace /usr/local $out
  '';

  meta = with stdenv.lib; {
    description = "Console-based network statistics utility for Linux";
    longDescription = ''
      vnStat is a console-based network traffic monitor for Linux and BSD that
      keeps a log of network traffic for the selected interface(s). It uses the
      network interface statistics provided by the kernel as information source.
      This means that vnStat won't actually be sniffing any traffic and also
      ensures light use of system resources.
    '';
    homepage = https://humdi.net/vnstat/;
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
