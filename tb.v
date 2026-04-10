'timescale 1ns/1ps

module tb_axi4_ram();

  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 10;
   parameter RAM_DEPTH = 1024;
   parameter ID_WIDTH = 4;
   parameter CLK_WIDTH = 10;


  reg aclk;
  reg aresetn;

  reg [ID_WIDTH -1:0]  s_axi_awid;
  reg [ADDR_WIDTH -1:0] s_axi_awaddr;
  reg [7:0] awlen;                                                  //write addr channel//
  reg [2:0] awsize;
  reg [1:0] awburst;
  reg       awvalid;
  wire      awready;

  
  reg [DATA_WIDTH -1:0]  s_axi_wdata;
  reg [ADDR_WIDTH/8 -1:0] s_axi_wstrb;
                                                                      // write data channel//
  reg        wlast;
  reg       wvalid;
  wire      wready;



  // write response channel//

  wire [ID_WIDTH -1:0] s_axi_bid;
  wire [1:0] bresp;
  wire bvalid;
  reg bready;

  // read addr channel//


  reg [ID_WIDTH -1:0]  s_axi_arid;
  reg [ADDR_WIDTH -1:0] s_axi_araddr;
  reg [7:0] arlen;                                            
  reg [2:0] arsize;
  reg [1:0] arburst;
  reg       arvalid;
  wire      arready;



  wire [ID_WIDTH -1:0]  s_axi_rid;
  wire [ADDR_WIDTH -1:0] s_axi_rdata;
                                                                      // read data channel//
  wire [1:0]    rresp;
  wire rlast;
 wire     rvalid;
  reg     rready;



 integer errors = 0;
  integer testnum = 0;
  

