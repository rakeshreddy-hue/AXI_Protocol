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
  

  
                    
