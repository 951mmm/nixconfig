{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
}:
stdenv.mkDerivation rec {
  name = "Huawei-WMI-${version}-${kernel.modDirVersion}";
  version = "4.0";

  src = fetchFromGitHub {
    owner = "aymanbagabas";
    repo = "Huawei-WMI";
    tag = "v${version}";
    sha256 = "sha256-b4NxaUNAaV5bBUt/E8maLmuaMONH7wrSdXnFLq+N59A";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  hardeningDisable = [
    "pic"
    "format"
  ];
  patches = [ ./Huawei-WMI-NixOS.patch ];

  makeFlags = [
    "KERN_SRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  installTargets = [ "install" ];

  meta = with lib; {
    description = "huawei-wmi ${version}";
    homepage = "https://github.com/aymanbagabas/Huawei-WMI";
    license = licenses.gpl2;
    maintainer = [ ];
    platforms = platforms.linux;
  };
}
