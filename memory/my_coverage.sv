// coverage class
// This class is used to collect coverage data for the testbench
class my_coverage;
    my_transaction my_trans;

    covergroup my_coverage_cg;
        // Coverpoints
        wr_en_cp : coverpoint my_trans.wr_en {
            bins write_en = {1};
            bins write_ds = {0};
        }

        rd_en_cp : coverpoint my_trans.rd_en{
            bins read_en = {1};
            bins read_ds = {0};
        }

        rst_cp : coverpoint my_trans.rst {
            // bins rst = {1};
            bins no_rst = {0};
        }

        rd_data_cp : coverpoint my_trans.rd_data {
            option.auto_bin_max = 4;
        }
        wr_data_cp : coverpoint my_trans.wr_data {
            option.auto_bin_max = 4;
        }

        addr_cp : coverpoint my_trans.addr {
            option.auto_bin_max = 4;
        }

        // Cross
         wr_en_rd_en: cross wr_en_cp, rd_en_cp;
    endgroup : my_coverage_cg

    covergroup my_coverage_seq_cg;
        // Coverpoints
        wr_en_seq_cp : coverpoint my_trans.wr_en {
            bins wr1_twice = (1 [*2]);
            bins wr0_twice = (0 [*2]);
        }
        rd_en_seq_cp : coverpoint my_trans.rd_en {
            bins rd1_twice = (1 [*2]);
            bins rd0_twice = (0 [*2]);
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