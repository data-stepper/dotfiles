{ config, pkgs, ... }:

let
  stPatched = pkgs.st.override {
    patches = [
      (pkgs.fetchpatch {
        url = "https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff";
        sha256 = "10gvwnpbjw49212k25pddji08f4flal0g9rkwpvkay56w8y81r22";
      })
      (pkgs.fetchpatch {
        url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
        sha256 = "108h30073yb8nm9x04x7p39di8syb8f8k386iyy2mdnfdxh54r04";
      })
      (pkgs.fetchpatch {
        url = "https://st.suckless.org/patches/font2/st-font2-0.8.5.diff";
        sha256 = "1wd4lxl0fmv78ibnf4yksribxhg3jzpqnjxhp0jyjbkz7a48m89f";
      })
    ];
  };

in {

  home.packages = [ stPatched ];
  xsession.windowManager.command = "${stPatched}/bin/st";

  home.file.".config/st/config.h".text = ''
    /* See the LICENSE file for the license governing this code. */

    static char *font = "Monospace:pixelsize=14:antialias=true:autohint=true";
    static char *font2[] = { "Noto Color Emoji:pixelsize=14:antialias=true:autohint=true" };

    /* Terminal colors (16 first used in escape sequence) */
    static const char *colorname[] = {
      /* 8 normal colors */
      "black", "red3", "green3", "yellow3",
      "blue2", "magenta3", "cyan3", "gray90",

      /* 8 bright colors */
      "gray50", "red", "green", "yellow",
      "#5c5cff", "magenta", "cyan", "white",

      [255] = 0,
      "#282c34", /* background */
      "#abb2bf", /* foreground */
    };

    unsigned int defaultfg = 257;
    unsigned int defaultbg = 256;
    static unsigned int defaultcs = 257;
    static unsigned int defaultrcs = 0;

    static float alpha = 0.9;

    /* Characters that are considered part of a word while deleting words. */
    static const char worddelimiters[] = " ";

    /* Size of the window in pixels */
    static unsigned int cols = 80;
    static unsigned int rows = 24;

    /* Box drawing characters */
    static uint16_t boxdraw[58] = {
      [0] = 0x2500, [1] = 0x2501, [2] = 0x2502, [3] = 0x2503,
      /* ... fill the rest of the box drawing characters here */
    };
  '';

}
