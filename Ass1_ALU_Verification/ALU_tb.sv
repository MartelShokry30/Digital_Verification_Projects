module ALU_tb;
    logic clk,reset;
    logic signed [3:0] A,B;
    logic signed [4:0] C;
    logic [1:0] Opcode;
    integer error_count=0,correct_count = 0;
    localparam  MaxPos=7 , Zero = 0 ,MinNeg = -8;
    int arr[3] = '{7,0,-8};
    int arr2[4] = '{7,0,-8,-1};
    localparam add= 2'b00, sub=2'b01 , bit_notA=2'b10 , reduction_orB= 2'b11;
    ALU_4_bit a1(.*);
    initial begin
        clk =0;
        forever
            #1 clk=~clk;
    end
    initial begin
    A=1;B=1;
    check_reset;

    Opcode=add;
    for (int j = 0;j<3 ;j=j+1 ) begin
        for (int k = 0;k<3 ;k=k+1 ) begin 
            A=arr[k];B=arr[j];
            check_result_add(A,B);
        end
    end
    
    Opcode=sub;
    for (int j = 0;j<3 ;j=j+1 ) begin
        for (int k = 0;k<3 ;k=k+1 ) begin
            A=arr[k];B=arr[j];
            check_result_sub(A,B);
        end
    end

    Opcode=bit_notA;   
    for (int k = 0;k<4 ;k=k+1 ) begin
        A=arr2[k];
        check_result_not(A);
    end
    
    Opcode=reduction_orB;   
    for (int k = 0;k<4 ;k=k+1 ) begin
        B=arr2[k];
        check_result_reduction_or(B);
    end    

    $display("at the end ,my summary is that there is %d errors and %d correct cases",error_count,correct_count);
    $stop;

    end
    task check_reset;
        reset = 1;
        @(negedge clk);
            if (C!==0) begin
                error_count=error_count+1;
                $display("reset fails");
            end
            else
                correct_count=correct_count+1;
                
            reset=0;
    endtask
    task check_result_add(input signed [3:0] A,input signed [3:0] B);
        @(negedge clk);
            if (C!==A+B) begin
                error_count=error_count+1;
                $display("A is %d, B is %d, expected result was result %d but output was %d and this was at time %t",A,B,A-B,C,$time);
            end  
            else
                correct_count=correct_count+1;
    endtask
    task check_result_sub(input signed [3:0] A,input signed [3:0] B);
        @(negedge clk);
            if (C!==A-B) begin
                error_count=error_count+1;
                $display("A is %d, B is %d,expected result was result %d but output was %d and this was at time %t",A,B,A-B,C,$time);
            end  
            else
                correct_count=correct_count+1;
    endtask
    task check_result_not(input signed [3:0] A);
        @(negedge clk);
            if (C!==~A) begin
                error_count=error_count+1;
                $display("A is %d,expected result was result %d but output was %d and this was at time %t",A,~A,C,$time);
            end  
            else
                correct_count=correct_count+1;
    endtask
    task check_result_reduction_or(input signed [3:0] B);
        @(negedge clk);
            if (C!==|B) begin
                error_count=error_count+1;
                $display("B is %d,expected result was result %d but output was %d and this was at time %t",B,|B,C,$time);
            end  
            else
                correct_count=correct_count+1;
    endtask


    
endmodule

//     always @(negedge clk)
//     begin
//         case (Opcode)
        
//             add : begin
        
//                 add_res:assert (C==A+B) begin correct_count=correct_count+1; end 
//                 else begin error_count=error_count+1; $error("error at %b expected was %b and output was %b",Opcode,A+B,C); end
        
//             end
        
//             sub : begin
        
//                 sub_res:assert (C==A-B) begin correct_count=correct_count+1; end
//                 else begin error_count=error_count+1;$error("error at %b expected was %b and output was %b",Opcode,A-B,C) ;end
            
        
//             end
//             bit_notA : begin
            
//                 not_res:assert (C==~A) begin correct_count=correct_count+1; end
//                 else begin error_count=error_count+1;$error("error at %b expected was %b and output was %b",Opcode,~A,C); end 
            
            
//             end
//             reduction_orB : begin
        
//                 or_res:assert (C==|B) begin correct_count=correct_count+1; end
//                 else begin error_count=error_count+1;$error("error at %b expected was %b and output was %b",Opcode,|B,C); end
            
        
//             end
//             default : begin
        
//                 $display("entered default");            
        
//             end
        
//         endcase
//         end