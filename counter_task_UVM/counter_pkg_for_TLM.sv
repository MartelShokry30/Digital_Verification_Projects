package counter_pkg;
parameter WIDTH = 4;
class counter_trans;
    rand bit rst,load_n,up_down,ce;
    rand bit [WIDTH-1:0] data_load,count_out;
    
    logic clk;
    constraint counter_c {
        load_n dist {1:=70, 0:=30};
        rst dist {0:=90, 1:=10}; //deactivated all the time
        ce dist {1:=70,0:=30};
    }
    covergroup g1 @(posedge clk);
        Data_load_COV:coverpoint data_load iff (!load_n);
        cnt_out_cov_up:coverpoint count_out iff(!rst && ce && up_down);
        cnt_out_cov_trans_max:coverpoint count_out {
            bins max_t_zero = ( {WIDTH{1'b1}} => 0 );
        }
        cnt_out_cov_down:coverpoint count_out iff(!rst && ce && !up_down);
        cnt_out_cov_trans_min:coverpoint count_out {
            bins max_t_zero = (0 => {WIDTH{1'b1}} );
        }
        
    endgroup

    function  new();
        g1 = new();  
    endfunction
endclass
    
endpackage