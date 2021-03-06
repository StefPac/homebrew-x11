class I3status < Formula
  desc "Status bar for i3"
  homepage "http://i3wm.org/i3status"
  revision 1
  head "https://github.com/i3/i3status.git"

  stable do
    url "http://i3wm.org/i3status/i3status-2.9.tar.bz2"
    sha256 "42eb09500c625fcac9a7125a29e7bf532ca4b8540942418ee3253aa15e5e9de3"

    # NOTE: Remove on the patches on the next release, since they have been reported and merged upstream
    # Add A2X_FLAGS
    patch do
      url "https://github.com/i3/i3status/commit/fcabfc889a80232288b0c78eaa25fca92e98248f.patch"
      sha256 "a248ea9813304f1de689d5d8aa4e7afd4fd7a67bf06904b103239e9e689a33cd"
    end

    # Fix undeclared identifier thermal_zone error
    patch do
      url "https://github.com/i3/i3status/commit/d1cec2632dab678d6eb55c319756e98faf95a7f0.patch"
      sha256 "8dea51c8d775ed0a10c5809a6faacfc787c2370193e4688c0662b94a7f3320ad"
    end

    # Add ifdef to compile print_disk_info on Mac
    patch do
      url "https://github.com/i3/i3status/commit/80e7b83d541044c698d6e9e40cc122e0cf287858.patch"
      sha256 "06b3cb69b8bcc6bc12c6fbe322e3bf28985761976cdd2c30ddfe3d282d06b3ee"
    end

    # Fix build on FreeBSD
    patch do
      url "https://github.com/i3/i3status/commit/e9fc4c1c0640cf21a85d4798aac20323100eac68.patch"
      sha256 "c98b845246a9bd2890cab8bdbd70ab19315bb1835960c347c7321133a22ae40c"
    end
  end

  bottle do
    cellar :any
    sha256 "f66062c00d55bc3d5491ef4792c631e34554cc261a1f6c4c0752ff45a0186769" => :el_capitan
    sha256 "b18aa5eb40b6a1c68d193477abf77e0af5330a465c85ce0114a0e35347b39738" => :yosemite
    sha256 "c5e07787042afd24d4a6d289362519751faca07153870a5f38a3560305701d6c" => :mavericks
  end

  depends_on :x11
  depends_on "yajl"
  depends_on "confuse"
  depends_on "pulseaudio"
  depends_on "asciidoc" => :build
  depends_on "i3" => :recommended

  def install
    system "make", "A2X_FLAGS=--no-xmllint"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    result = shell_output("#{bin}/i3status -v")
    result.force_encoding("UTF-8") if result.respond_to?(:force_encoding)
    assert_match version.to_s, result
  end
end
