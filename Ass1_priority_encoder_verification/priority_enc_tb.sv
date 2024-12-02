module four_to_two_priority_enc_tb;
    logic clk, rst;
    logic [3:0] D;
    logic valid;
    logic [1:0] Y;
    integer i;
    integer error_count,correct_count = 0;
    priority_enc a1 (.*);
    initial begin

        clk = 0;
        forever 
            #1 clk =~clk;
    end
    initial begin
        error_count = 0;
        correct_count = 0;
        D = 1;
        check_reset;
        D = 0;
        check_result;
        for (i = 0;i<15 ;i=i+1 ) begin
            
            D=D+1;
            check_result;
        end
        $display("at the end ,my summary is that there is %d errors and %d correct cases",error_count,correct_count);
        $stop;

    end
    task check_reset;
        rst = 1;
        @(negedge clk);
            if ((Y!== 0) || (valid !==0)) begin
                error_count = error_count +1;
                $display("%t : reset error ",$time);
            end
            else
                correct_count=correct_count+1;
            rst =0;
    endtask
    task check_result();
        @(negedge clk) begin
            if (D==0) begin
                if (valid != 0) begin
                    error_count = error_count +1;
                    $display("expected valid was %d and output is %d, this was at time %t",0,valid,$time);                    
                end
            end
            if (D[0]==1) begin
                if (Y != 3) begin
                    error_count = error_count +1;
                    $display("expected was %d and output is %d, this was at time %t",3,Y,$time);                    
                end
                else
                    correct_count=correct_count+1;
            end
            if (D[1]==1 && D[0]==0) begin
                if (Y != 2) begin
                    error_count = error_count +1;
                    $display("expected was %d and output is %d, this was at time %t",2,Y,$time);                    
                end
                else
                    correct_count=correct_count+1;
            end
            if (D[2]==1 && D[0]==0 && D[1] == 0) begin
                if (Y != 1) begin
                    error_count = error_count +1;
                    $display("expected was %d and output is %d, this was at time %t",1,Y,$time);                    
                end
                else
                    correct_count=correct_count+1;
            end
            if (D[3]==1 && D[2]==0 && D[0]==0 && D[1] == 0) begin
                if (Y != 0) begin
                    error_count = error_count +1;
                    $display("expected was %d and output is %d, this was at time %t",0,Y,$time);                    
                end
                else
                    correct_count=correct_count+1;
            end
        end
    endtask

    // property y_0 ; (@(posedge clk) D[3]==1 && D[2:0]==0 |=> Y==0 && valid==1); endproperty
    // property y_1 ; (@(posedge clk) D[2]==1 && D[1:0]==0 |=> Y==1 && valid==1); endproperty
    // property y_2 ; (@(posedge clk) D[1]==1 && D[0]==0 |=> Y==2 && valid==1); endproperty
    // property y_3 ; (@(posedge clk) D[0]==1 |=> Y==3 && valid==1); endproperty

    // y0_p:assert property (y_0);
    // y0_c:cover property (y_0);
    // y1_p:assert property (y_1);
    // y1_c:cover property (y_1);
    // y2_p:assert property (y_2);
    // y2_c:cover property (y_2);
    // y3_p:assert property (y_3);
    // y3_c:cover property (y_3);
endmodule



