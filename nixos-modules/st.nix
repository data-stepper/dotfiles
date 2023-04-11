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
    /* Some custom config.h file here */
    static const float alpha[] = {0.7, 1};

    unsigned int defaultfg = 12; // Solarized foreground color
    unsigned int defaultbg = 0;  // Solarized background color
  '';

}
