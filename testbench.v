module ram_design #(parameter addr_width = 4,
                    parameter data_width = 32,
                    parameter depth = 16) (
  input clk,rst,wr_enable,
  input [addr_width -1:0]=addr,
  input [data_width -1:0]=wdata,
  output reg [data_width -1:0=rdata);

              reg {data_width -1:0] mem[0:depth -1];

              always@(posedge clk)begin
                if(!rst)
                  begin
                  rdata<=0;
                  end

                if(wr_enable)begin
                  mem[addr]<=wdata;
                end
                else begin
                  rdata<=mem[addr];
              end
              end
                   endmodule
                
                
                
  
