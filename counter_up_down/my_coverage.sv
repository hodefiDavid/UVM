// coverage class
// This class is used to collect coverage data for the testbench

class my_coverage;
    my_transaction my_trans;

    covergroup my_coverage_cg;
        // Coverpoints
        up_down_cp : coverpoint my_trans.up_down {
            bins up = {1};
            bins down = {0};
        }
        load_cp : coverpoint my_trans.load;

        rst_cp : coverpoint my_trans.rst;

        count_cp : coverpoint my_trans.count {
            bins c0 = {0};
            bins c255 = {255};
            bins cMid = {100};
        }

        data_in_cp : coverpoint my_trans.data_in {
            option.auto_bin_max = 4;
        }

    endgroup : my_coverage_cg

    covergroup my_coverage_seq_cg;
        // Coverpoints
        up_down_seq_cp : coverpoint my_trans.up_down {
            bins up = (1 [*2]);
            bins down = (0 [*2]);
        }
        load_seq_cp : coverpoint my_trans.load {
            bins load = (1 [*2]);
            bins no_load = (0 [*2]);
        }
    
    endgroup : my_coverage_seq_cg


    // Function to sample the coverage
    function sample(my_transaction tr);
        my_trans = tr;
        my_coverage_cg.sample();
        my_coverage_seq_cg.sample();
    endfunction

     // Constructor
    function new();
        my_trans = new();
        my_coverage_cg = new();
        my_coverage_seq_cg = new();
    endfunction


endclass