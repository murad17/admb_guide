(TeX-add-style-hook "admb_guide"
 (lambda ()
    (LaTeX-add-bibliographies)
    (LaTeX-add-labels
     "sec:outfiles"
     "sec:restart"
     "sec:diag"
     "sec:startvals"
     "sec:MH"
     "tab:mh_args"
     "fig:simple1"
     "fig:simple2"
     "sec:mcprobe"
     "fig:mcgrope_example"
     "sec:mcrb"
     "fig:mcrb"
     "sec:user.cov"
     "sec:hybrid"
     "eq:motion"
     "fig:hybrid_grid_trace"
     "fig:hybrid_seeds"
     "tab:hy_args"
     "fig:hybrid_grid_acf"
     "fig:logistic_mh"
     "fig:logistic_mh2"
     "fig:logistic_hy"
     "fig:logistic_hy2"
     "fig:logistic_hy3")
    (TeX-run-style-hooks
     "hyperref"
     "float"
     "graphicx"
     "amssymb"
     "amsmath"
     "geometry"
     "margin=1in"
     "latex2e"
     "art10"
     "article"
     "")))
