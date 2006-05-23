From: rod@morison.biz (Rod Morison)
Date: Tue, 23 May 2006 13:25:08 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <44730D34.4080802@morison.biz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am stuck with what it certainly a config problem. I've got lm_sensors 
2.10.0 running fine on a SuperMicro PDSMA mobo under 2.6.16 kernel. 
However, under 2.4.19 (required for the embedded project I'm on), I'm 
missing sensors for one of the chips. I'm using the same sensors.conf 
and modules.conf/modprobe.conf settings.

In the 2.4 kernel case I get some eeprom/ram listings off the I801 bus, 
instead of the w83792d chip I'm expecting.

Can anyone point me in the right direction to reconcile the difference...

2.6 kernel driver list and sensors output:

sm1:~ # lsmod
Module                  Size  Used by
joydev                 27520  0
st                     55332  0
sr_mod                 33060  0
xt_pkttype             18560  3
ipt_LOG                23168  9
xt_limit               19328  9
w83627hf               45328  0
eeprom                 24464  0
w83792d                46872  0
w83781d                53156  0
hwmon_vid              19200  2 w83627hf,w83781d
hwmon                  19848  3 w83627hf,w83792d,w83781d
i2c_isa                22272  2 w83627hf,w83781d
af_packet              55820  2
edd                    26760  0
button                 24224  0
battery                27272  0
ac                     22152  0
ip6t_REJECT            22272  3
xt_tcpudp              19968  5
ipt_REJECT             22272  3
xt_state               18816  12
iptable_mangle         19584  0
iptable_nat            25220  0
ip_nat                 35884  1 iptable_nat
iptable_filter         19712  1
ip6table_mangle        19072  0
ip_conntrack           75164  3 xt_state,iptable_nat,ip_nat
nfnetlink              23496  2 ip_nat,ip_conntrack
ip_tables              30792  3 iptable_mangle,iptable_nat,iptable_filter
ip6table_filter        19584  1
ip6_tables             32328  2 ip6table_mangle,ip6table_filter
x_tables               31368  10 
xt_pkttype,ipt_LOG,xt_limit,ip6t_REJECT,xt_tcpudp,ipt_REJECT,xt_state,iptable_nat,ip_tables,ip6_tables
ipv6                  328736  19 ip6t_REJECT
apparmor               72352  0
aamatch_pcre           30720  1 apparmor
loop                   32528  0
dm_mod                 77616  0
i2c_i801               25876  0
shpchp                 62368  0
e1000                 130744  0
uhci_hcd               48544  0
ehci_hcd               47624  0
ide_cd                 57248  0
cdrom                  52392  2 sr_mod,ide_cd
i2c_core               40192  6 
w83627hf,eeprom,w83792d,w83781d,i2c_isa,i2c_i801
pci_hotplug            45056  1 shpchp
i8xx_tco               24616  0
usbcore               150312  3 uhci_hcd,ehci_hcd
floppy                 82984  0
parport_pc             56680  1
lp                     29768  0
parport                56716  2 parport_pc,lp
reiserfs              241280  2
fan                    21896  0
thermal                32272  0
sg                     52264  0
processor              50280  1 thermal
3w_9xxx                50180  3
piix                   27652  0 [permanent]
sd_mod                 34176  4
scsi_mod              163888  5 st,sr_mod,sg,3w_9xxx,sd_mod
ide_disk               32896  0
ide_core              165764  3 ide_cd,piix,ide_disk
sm1:~ # sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.14 V  (min =  +1.38 V, max =  +1.54 V)       ALARM 
VCore 2:   +0.14 V  (min =  +1.38 V, max =  +1.54 V)       ALARM 
+3.3V:     +0.14 V  (min =  +3.14 V, max =  +3.46 V)       ALARM 
+5V:       +5.19 V  (min =  +4.73 V, max =  +5.24 V)             
+12V:      +0.55 V  (min = +10.82 V, max = +13.19 V)       ALARM 
-12V:     -14.17 V  (min = -13.18 V, max = -10.88 V)       ALARM 
-5V:       -7.26 V  (min =  -5.25 V, max =  -4.75 V)       ALARM 
V5SB:      +5.54 V  (min =  +4.73 V, max =  +5.24 V)       ALARM 
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)       ALARM 
fan1:        0 RPM  (min = 2848 RPM, div = 2)              ALARM 
fan2:        0 RPM  (min = 2848 RPM, div = 2)              ALARM 
fan3:        0 RPM  (min = 1328 RPM, div = 8)              ALARM 
temp1:      +124?C  (high =    -5?C, hyst =    -3?C)   sensor = 
thermistor   ALARM  
temp2:    +124.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor   ALARM  
temp3:    +124.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor   ALARM  
vid:      +1.462 V  (VRM Version 10.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 1100

VCoreA:    +1.33 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VCoreB:    +1.53 V  (min =  +1.40 V, max =  +1.60 V)      
VIN0:      +3.29 V  (min =  +3.20 V, max =  +3.39 V)      
VIN1:      +3.01 V  (min =  +3.09 V, max =  +3.30 V)       ALARM
VIN2:      +0.52 V  (min =  +1.39 V, max =  +1.49 V)       ALARM
VIN3:      +3.12 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
5VCC:      +5.02 V  (min =  +4.73 V, max =  +5.23 V)      
5VSB:      +4.88 V  (min =  +4.73 V, max =  +5.23 V)      
VBAT:      +3.20 V  (min =  +2.85 V, max =  +3.14 V)       ALARM
Fan1:        0 RPM  (min =  712 RPM, div = 8)              ALARM
Fan2:        0 RPM  (min =  712 RPM, div = 8)              ALARM
Fan3:     7336 RPM  (min =  712 RPM, div = 8)             
Fan4:        0 RPM  (min =  712 RPM, div = 8)              ALARM
Fan5:        0 RPM  (min =  712 RPM, div = 8)              ALARM
Fan6:     5625 RPM  (min =  712 RPM, div = 8)             
ERROR: Can't get FAN7 data!
Temp1:     +34.0?C  (high = +50.0?C, hyst =  +0.0?C)  
Temp2:     +41.0?C  (high = +80.0?C, hyst = +75.0?C)  
Temp3:     +28.5?C  (high = +80.0?C, hyst = +75.0?C)  
chassis:  Chassis intrusion detection                  ALARM

sm1:~ #

--------------------------------------------------------------------------------------


2.4 kernel driver list and sensors output

2.4.19# lsmod
Module                  Size  Used by    Tainted: P 
w83627hf               14104   0  (unused)
smbus-arp               4816   0  (unused)
i2c-isa                  804   0  (unused)
i2c-i801                4828   0  (unused)
eeprom                  3500   0  (unused)
w83781d                19196   0  (unused)
i2c-proc                5988   0  [w83627hf smbus-arp eeprom w83781d]
i2c-core               14276   0  [w83627hf smbus-arp i2c-isa i2c-i801 
eeprom w83781d i2c-proc]
e1000                  98896   1
2.4.19# sensors
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1100
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 1100
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       512

w83627hf-isa-0290
Adapter: ISA adapter
in0:       +0.00 V  (min =  +3.28 V, max =  +3.68 V)             
in1:       +0.00 V  (min =  +3.28 V, max =  +3.68 V)             
in2:       +0.00 V  (min =  +2.82 V, max =  +3.79 V)             
in3:       +3.09 V  (min =  +4.08 V, max =  +4.08 V)             
in4:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)             
in5:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)             
in6:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)             
in7:       +3.31 V  (min =  +4.08 V, max =  +4.08 V)             
in8:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)             
fan1:        0 RPM  (min = 2848 RPM, div = 2)                    
fan2:        0 RPM  (min = 2848 RPM, div = 2)                    
fan3:        0 RPM  (min =    0 RPM, div = 8)                    
temp1:      +127 C  (high =    -1 C, hyst =    -1 C)   sensor = 
thermistor          
temp2:    +127.0 C  (high =   +80 C, hyst =   +75 C)   sensor = 
thermistor   ALARM  
temp3:    +127.0 C  (high =   +80 C, hyst =   +75 C)   sensor = 
thermistor   ALARM  
vid:      +3.500 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

arp-i2c-0-61
Adapter: SMBus I801 adapter at 1100





