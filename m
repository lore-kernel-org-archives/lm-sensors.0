From: s.cramatte@wanadoo.fr (=?ISO-8859-1?Q?S=E9bastien_CRAMATTE?=)
Date: Tue, 13 Mar 2007 13:44:37 +0000
Subject: [lm-sensors] lm-sensors and 2.6.18 kernel under debian sarge
Message-Id: <45F6AAC5.5050307@wanadoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I've got a p8sci supermicro motherboard.
I've compiled and loaded successfully  i2c and hardware monitoring modules.

I've tried to disable beep and alarm but  unfortunately doesn't work
Moreover values are very strange ... and for example   "set beep_enable
0" is ignored ...

I've patched the kernel with IPMI  too but I don't know how to use it :(
# ls /boot/modules/2.6.18.3-router.5/kernel/drivers/char/ipmi/*
ipmi_devintf.ko  ipmi_msghandler.ko  ipmi_poweroff.ko  ipmi_si.ko 
ipmi_watchdog.ko

#uname -a
Linux gestor1 2.6.18.3-router.5 #24 SMP Fri Mar 9 13:52:54 UTC 2007 i686
GNU/Linux

#dpkg -l sensord
sensord                           2.9.1-1sarge3

#lsmod
...
w83627hf               15760  0
hwmon_vid               2944  1 w83627hf
hwmon                   2052  1 w83627hf
eeprom                  3984  0
i2c_isa                 2816  1 w83627hf
i2c_i801                6156  0
i2c_core               11520  4 w83627hf,eeprom,i2c_isa,i2c_i801
...

#cat /etc/sensors.conf
...
chip "w83627thf-*" "w83637hf-*"

    set beep_enable 0

    ...

# sensors
eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

w83627thf-isa-0290
Adapter: ISA adapter
in0:       +1.94 V  (min =  +1.94 V, max =  +1.94 V)       ALARM  (beep)
in1:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
in2:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
in3:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
in4:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
in7:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
in8:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
fan1:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
fan2:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
fan3:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
temp1:        -1 C  (high =    -1 C, hyst =    -1 C)   sensor = diode  
ALARM   (beep)
temp2:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode  
ALARM   (beep)
temp3:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode  
ALARM   (beep)
vid:      +0.000 V  (VRM Version 10.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled



Any help is welcome
Regards



