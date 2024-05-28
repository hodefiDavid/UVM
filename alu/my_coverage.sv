class my_coverage;

    bit write_en;
    bit read_en;
    bit [3:0] data_in;
    bit full;
    bit empty;
    bit [3:0] data_out;
    bit rst;


covergroup fifo_cov;
	write_en:coverpoint  write_en;
    coverpoint  read_en;
    coverpoint  data_in;
    coverpoint  full;
    coverpoint  empty;
    coverpoint  data_out;
    coverpoint  rst;
endgroup:fifo_cov

covergroup empty_full_cov;
empty_cov:coverpoint empty{
    bins e1={0};
    bins e2={1};
}

full_cov:coverpoint full{
    bins f1={0};
    bins f2={1};
}

cross full_cov,empty_cov{
    illegal_bins ef1= binsof(empty_cov.e2) && binsof(full_cov.f2);
}
endgroup

function coverage_sample(my_transaction tr);

    write_en=tr.write_en;
    read_en=tr.read_en;
    data_in=tr.data_in;
    full=tr.full;
    empty=tr.empty;
    data_out=tr.data_out;
    rst=tr.rst;

    fifo_cov.sample();
    empty_full_cov.sample();

endfunction


function new(string name="my_coverage");
    fifo_cov=new();
    empty_full_cov=new();
endfunction

endclass