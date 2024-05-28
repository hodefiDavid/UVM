class my_coverage;

my_transaction trans_cov;

covergroup dut_cov_points;

    reset : coverpoint trans_cov.reset{
        bins r0={0};
        bins r1={1};
    }
    enable : coverpoint trans_cov.enable{
        bins e0={0};
        bins e1={1};
    }
    addr : coverpoint trans_cov.addr{
        bins a0={0};
        bins a1={1};
        bins a2={2};
        bins a3={3};
    }

    data : coverpoint trans_cov.wr_data {
        bins d0={0};
        bins d1={1};
        bins d2={2};
        bins d3={3};
        bins d4={4};
        bins d5={5};
        bins d6={6};
        bins d7={7};
    }

    read_write : coverpoint trans_cov.rd_wr {
        bins rw0={0};
        bins rw1={1};
    }


    en_rd_rw : cross enable, read_write {
        bins en0_rw0 = binsof(enable.e0) && binsof(read_write.rw0);
        bins en0_rw1 = binsof(enable.e0) && binsof(read_write.rw1);
        bins en1_rw0 = binsof(enable.e1) && binsof(read_write.rw0);
        bins en1_rw1 = binsof(enable.e1) && binsof(read_write.rw1);
    }



    execute : cross addr, enable, read_write, data {
        bins execute_on = binsof(addr) intersect {3} &&
                          binsof(enable) intersect {1} &&
                          binsof(read_write) intersect {0} &&
                          binsof(data.d0) intersect {1};
    }

endgroup:dut_cov_points


function coverage_sample(my_transaction tr);
    this.trans_cov = tr;
    dut_cov_points.sample();
endfunction


function new();
    dut_cov_points=new();
    this.trans_cov = new();
endfunction

endclass