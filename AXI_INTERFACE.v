module axi_top_ram#(parameter data_width = 32,
                    parameter addr_width = 4,
                    parameter depth = 16)(
  input aclk,
  input aresetn,

  //write address channel
  input [addr_width - 1 : 0] s_axi_awaddr,
  input s_axi_awvalid,
  output reg s_axi_awready,

  //write data channel
  input [addr_width -1 : 0] s_axi_wdata,
  input s_axi_wvalid,
  output reg s_axi_wready,

  //write response channel
  output reg bresp,
  output reg bvalid,
  input bready,

  //read data channel

  output reg [addr_width -1 : 0] s_axi_rdata,
  output reg [1:0]rresp,
  output reg s_axi_rvalid,
  input rready,

  //read address channel

  input [addr_width -1 : 0] s_axi_araddr,
  input s_axi_arvalid,
  output reg s_axi_arready);

  localparam resp_okay = 2'b00:
  localparam resp_slv_err = 2'b01;

  //state machine parameters

  localparam idle = 2'b00;
  localparam write = 2'b01;
  localparam read = 2'b10;
  localparam resp = 2'b11;

  //internal signals

  reg [1:0] write_state, read_state;
  reg [addr_width -1:0] ram_addr;
  reg [addr_width -1:0] ram_write_data;
  wire  [addr_width -1:0] ram_rdata;

  //instantiate ram design 

  ram_design dut(aclk,aresetn,ram_write_enable,ram_addr, ram_write_enable, ram_rdata);

  //write_address_channel
  always@(posedge clk)
    begin
      if(!aresetn)
        begin
          s_axi_awready<=1'b0;
          write_addr_reg <= {addr_width{1'b0}};
          write_state <= idle;
        end
      else
        case(write_state)

          idle : begin
            s_axi_awready<=1'b1;
            (s_axi_awvalid && a_axi_awready) begin
             write_addr_reg <= s_axi_awaddr;
              s_axi_awready <= 0;

              write_state <= write;

            end
          end

          write : begin
            if(s_axi_wvalid && s_axi_wready) begin
              write_state <= resp;
            end

            resp : begin
              if(s_axi_bvalid && s_axi_bready) begin
                write_state <= idle;
              end

              default : write_stae <= idle;
            end
          end

          // write data channel 

          always@(posedge clk)
            if(!aresetn)
              begin
                s_axi_wready <= 1'b0;
                ram_write_enable <= 1'b0;
                ram_write_data <= {addr_width{1'b0}};
              end
          else
            if(write_state == write)begin
              s_axi_wready <= 1'b1;
              ram_addr <= write_addr_reg;
              ram_write_data <= s_axi_wdata;
              s_axi_wready <= 1'b0;
            end
          else
               s_axi_wready <= 1'b0;
          end
          
    
    // write response channel 

          always@(posedge clk)
            if(!aresetn)
              begin
                s_axi_bvalid <= 1'b0;
                s_axi_bresp <= resp_okay;
              end
          else
            if(write_state == resp)begin
              s_axi_bvalid <= 1'b1;
            

              else if(s_axi_bvalid && s_axi_bready)begin
                s_axi_bvalid <= 1'b0;
            end
         
          end

          //read address channel 

          always@(posedge clk) begin
            if(!aresetn)
              begin
                s_axi_arready<=1'b0;
                read_addr_reg <= {addr_width{1'b0}};
                read_state <= idle;
              end
            else
              begin
                case(read_state)
                  idle : begin
                    s_axi_arready <= 1'b0;
                    if(s_axi_arready && s_axi_arvalid)begin
                      read_addr_reg <= s_axi_araddr;
                      s_axi_arready <= 1'b0;
                      read_state <= read;
                    end
                  end
                  read : begin
                    read_state <= resp;
                  end
                  resp : begin
                    if(s_axi_rready && s_axi_rvalid)
                    read_state <= idle;
                  end
                  default : read_state <= idle;
               
                
                endcase
              end
          end
                      

  
                    
