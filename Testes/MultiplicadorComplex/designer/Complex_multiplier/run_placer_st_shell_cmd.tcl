read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/Complex_multiplier_layout_combinational_loops.xml}
report -type slack {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/Complex_multiplier_place_and_route_constraint_coverage.xml}]
set reportfile {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp