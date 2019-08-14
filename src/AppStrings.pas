unit AppStrings;

interface

  const
    DEFAULT_IP = '192.168.1.101';

    EOM_PATTERN = #13#10 + '.' + #13#10;

    NON_EMPTY_INPUT   = 'bytes still on input buffer.';
    INVALID_LOG_TYPE  = 'Invalid message type passed to OnNewLog.';

    BYE = 'BYE';

    PROT_CONNECTED = '201- connected';
    PROT_OK        = '200- OK';
    PROT_BYE       = '202- bye';
    PROT_MULTILINE = '202- multiline response follows';
    PROT_VIRTUAL  = '202- Valid Virtual Address Ranges Follow';
    PROT_BINARY   = '203- binary response follows';
    PROT_UNKNOWN_CMD = '407- unknown command';

    GETMEM2_FULL = 'GETMEM2 ADDR=0x%.8x LENGTH=0x%.8x';

    REBOOT_WARM_TAG = 'WARM';
    REBOOT_WAIT_TAG = 'WAIT';
    REBOOT_STOP_TAG = 'STOP';
    REBOOT_NODEBUG_TAG = 'NODEBUG';
    REBOOT_DEBUG_TAG  = 'DEBUG';
    REBOOT_HEADER     = 'REBOOT%s';
    REBOOT_MAGICBOOT  = 'magicboot title=%s%s';

    NOTIFYAT      = 'NOTIFYAT PORT=';
    NOTIFYAT_DROP = 'DROP';

    DEBUGGER            = 'DEBUGGER';
    DEBUGGER_CONNECT    = 'CONNECT';
    DEBUGGER_DISCONNECT = 'DISCONNECT';

    VIRTUAL_ADDRESS_BASE = 'base=';
    VIRTUAL_ADDRESS_SIZE = 'size=';
    VIRTUAL_ADDRESS_PROTECT = 'protect=';

implementation

end.
