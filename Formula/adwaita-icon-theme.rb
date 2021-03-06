class AdwaitaIconTheme < Formula
  desc "Icons for the GNOME project"
  homepage "https://developer.gnome.org"
  url "https://download.gnome.org/sources/adwaita-icon-theme/3.28/adwaita-icon-theme-3.28.0.tar.xz"
  sha256 "7aae8c1dffd6772fd1a21a3d365a0ea28b7c3988bdbbeafbf8742cda68242150"

  bottle do
    cellar :any_skip_relocation
    sha256 "4186b2c7d5246953762508887af4929a44d7a66c6144c5ba8d6810600e4b8568" => :high_sierra
    sha256 "4186b2c7d5246953762508887af4929a44d7a66c6144c5ba8d6810600e4b8568" => :sierra
    sha256 "4186b2c7d5246953762508887af4929a44d7a66c6144c5ba8d6810600e4b8568" => :el_capitan
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext" => :build
  depends_on "gtk+3" => :build # for gtk3-update-icon-cache
  depends_on "librsvg"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "GTK_UPDATE_ICON_CACHE=#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache"
    system "make", "install"
  end

  test do
    # This checks that a -symbolic png file generated from svg exists
    # and that a file created late in the install process exists.
    # Someone who understands GTK+3 could probably write better tests that
    # check if GTK+3 can find the icons.
    assert_predicate share/"icons/Adwaita/96x96/status/weather-storm-symbolic.symbolic.png", :exist?
    assert_predicate share/"icons/Adwaita/index.theme", :exist?
  end
end
