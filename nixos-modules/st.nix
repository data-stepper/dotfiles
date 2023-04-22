{ config, pkgs, ... }:

# let
#   stPatched = pkgs.st.override {
#     patches = [
#       (pkgs.fetchpatch {
#         url = "https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff";
#         sha256 = "10gvwnpbjw49212k25pddji08f4flal0g9rkwpvkay56w8y81r22";
#       })
#       (pkgs.fetchpatch {
#         url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
#         sha256 = "108h30073yb8nm9x04x7p39di8syb8f8k386iyy2mdnfdxh54r04";
#       })
#       (pkgs.fetchpatch {
#         url = "https://st.suckless.org/patches/font2/st-font2-0.8.5.diff";
#         sha256 = "1wd4lxl0fmv78ibnf4yksribxhg3jzpqnjxhp0jyjbkz7a48m89f";
#       })
#     ];
#   };

{
  environment.systemPackages = with pkgs;
    [
      (st.overrideAttrs (oldAttrs: rec {
        patches = [
          # Fetch them directly from `st.suckless.org`
          (fetchpatch {
            url =
              "https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff";
            sha256 = "10gvwnpbjw49212k25pddji08f4flal0g9rkwpvkay56w8y81r22";
          })
          #   (pkgs.fetchpatch {
          #     url =
          #       "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
          #     sha256 = "108h30073yb8nm9x04x7p39di8syb8f8k386iyy2mdnfdxh54r04";
          #   })
          #   (fetchpatch {
          #     url =
          #       "https://st.suckless.org/patches/rightclickpaste/st-rightclickpaste-0.8.2.diff";
          #     sha256 = "1y4fkwn911avwk3nq2cqmgb2rynbqibgcpx7yriir0lf2x2ww1b6";
          #   })
        ];
      }))
    ];

  environment.etc.".config/st/config.h".text = ''
    /* Terminal colors (16 first used in escape sequence) */
    static const char *colorname[] = {
        /* 8 normal colors */
        [0] = "#073642", /* black   */
        [1] = "#dc322f", /* red     */
        [2] = "#859900", /* green   */
        [3] = "#b58900", /* yellow  */
        [4] = "#268bd2", /* blue    */
        [5] = "#d33682", /* magenta */
        [6] = "#2aa198", /* cyan    */
        [7] = "#eee8d5", /* white   */

        /* 8 bright colors */
        [8]  = "#002b36", /* black   */
        [9]  = "#cb4b16", /* red     */
        [10] = "#586e75", /* green   */
        [11] = "#657b83", /* yellow  */
        [12] = "#839496", /* blue    */
        [13] = "#6c71c4", /* magenta */
        [14] = "#93a1a1", /* cyan    */
        [15] = "#fdf6e3", /* white   */

        /* special colors */
        [256] = "#002b36", /* background */
        [257] = "#839496", /* foreground */
        [258] = "#dc322f", /* cursor */
    };

    /*
    * Default colors (colorname index)
    * foreground, background, cursor, reverse cursor
    */
    unsigned int defaultfg = 257;
    unsigned int defaultbg = 256;
    unsigned int defaultcs = 258;
    unsigned int defaultrcs = 257;
  '';

}
