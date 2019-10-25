{ stdenv, fetchurl }:

let
  version = "2.0.2";

  sources = let
    base = "https://github.com/containous/traefik/releases/download/v${version}";
  in {
    "x86_64-linux" = fetchurl {
      url = "${base}/traefik_v${version}_linux_amd64.tar.gz";
      sha256 = "f9adf514fc7ae0e90b88680213d44d59df429d8b68978b4a7ed4f9408fb0ad67";
    };
  };
in stdenv.mkDerivation rec {
  pname = "traefik-bin";
  inherit version;

  src = sources."${stdenv.hostPlatform.system}" or (throw "unsupported system: ${stdenv.hostPlatform.system}");

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $bin/bin $out/bin
    mv traefik $bin/bin

    runHook postInstall
  '';

  meta = with stdenv.lib; {
    homepage = https://traefik.io/;
    description = "A modern reverse proxy";
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
    maintainers = with maintainers; [ hamhut1066 vdemeester ];
  };

   outputs = [ "bin" "out" ];
}
