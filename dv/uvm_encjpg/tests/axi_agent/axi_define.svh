`ifndef AXI_DEFINE_SVH
`define AXI_DEFINE_SVH


typedef enum {
    BYTE,
    HWORD,
    WORD,
    DWORD,
    SIZE128,
    SIZE256,
    SIZE512,
    SIZE1024
}axi_size_e ;

typedef enum {
    FIXED,
    INCR,
    WRAP
}axi_burst_type_e ;

`endif
