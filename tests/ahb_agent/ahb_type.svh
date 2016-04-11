`ifndef AHB_TYPE_SVH_
`define AHB_TYPE_SVH_

`define  AHB_ADDR_WIDTH     32
`define  AHB_DATA_WIDTH     32
`define  AHB_TYPE_WIDTH     2
`define  AHB_BURST_WIDTH    3
`define  AHB_SIZE_WIDTH     3
`define  AHB_PROT_WIDTH     4

typedef enum {
    READ,
    WRITE
}ahb_direction_e ;

typedef enum {
    BYTE,
    HWORD,
    WORD,
    DWORD,
    SIZE128,
    SIZE256,
    SIZE512,
    SIZE1024
}ahb_size_e ;

typedef enum {
    IDLE,
    BUSY,
    NONSEQ,
    SEQ
}ahb_transfer_type_e ;

typedef enum {
    SINGLE,
    INCR,
    WRAP4,
    INCR4,
    WRAP8,
    INCR8,
    WRAP16,
    INCR16
}ahb_burst_e ;

`endif
