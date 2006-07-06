From: lists@localguru.de (Marcus Sobchak)
Date: Thu, 06 Jul 2006 07:43:24 +0000
Subject: [lm-sensors] Tyan S2720 Revsion 2.01 again
Message-Id: <1152171804.5078.26.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

tested sensors.conf (see attachment) for Tyan S2720 from Tyan's ftp
server, but just get the follwing strange output. Any ideas, what's
going wrong here? 

System: Linux 2.6.15-25-server #1 SMP  (Ubuntu dapper)

Thanks,
Marcus

---------
adm1021-i2c-0-19
Adapter: SMBus I801 adapter at ec80
CPU 2 temp:
              -1?C  (low  =    -1?C, high =    -1?C)  ALARM
(N/A,LOW,HIGH)
ERROR: Can't get die-code data!

adm1021-i2c-0-18
Adapter: SMBus I801 adapter at ec80
CPU 1 temp:
              -1?C  (low  =    -1?C, high =    -1?C)  ALARM
(N/A,LOW,HIGH)
ERROR: Can't get die-code data!

w83627hf-isa-0290
Adapter: ISA adapter
Fan4:        0 RPM  (min = 168750 RPM, div = 2)
Fan5:        0 RPM  (min = 225000 RPM, div = 2)
Fan6:        0 RPM  (min = 337500 RPM, div = 2)
alarms:
beep_enable:
          Sound alarm disabled

w83627hf-i2c-0-2a
Adapter: SMBus I801 adapter at ec80
Fan4:        0 RPM  (min =    0 RPM, div = 128)
Fan5:        0 RPM  (min =    0 RPM, div = 128)
Fan6:        0 RPM  (min =    0 RPM, div = 128)
(beep)
alarms:
beep_enable:
          Sound alarm enabled

w83782d-i2c-0-29
Adapter: SMBus I801 adapter at ec80
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +12.04 V  (min = +10.82 V, max = +13.19 V)
VBat:      +2.10 V  (min =  +2.40 V, max =  +3.60 V)
CPU1 Fan: 9642 RPM  (min = 84375 RPM, div = 2)
CPU2 Fan: 9642 RPM  (min = 84375 RPM, div = 2)
Fan3:        0 RPM  (min = 84375 RPM, div = 2)
VRM Temp:    +45?C  (high =  +100?C, hyst =   +90?C)   sensor transistor
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled
---------

---------
0000:00:00.0 Host bridge: Intel Corporation E7500 Memory Controller Hub
(rev 03)
0000:00:02.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface B
PCI-to-PCI Bridge (rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1)
(rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface
Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage
Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev
02)
0000:01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:01:03.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet
Pro 100] (rev 0c)
0000:02:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 03)
0000:02:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
(rev 03)
0000:02:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 03)
0000:02:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
(rev 03)
0000:03:01.0 SCSI storage controller: ICP Vortex Computersysteme GmbH
GDT 8x23RZ
0000:04:01.0 Ethernet controller: Intel Corporation 82544EI Gigabit
Ethernet Controller (Copper) (rev 02)
---------

---------
Module                  Size  Used by
dm_mod                 63512  1
md_mod                 76756  0
ipv6                  287584  24
adm1021                14640  0
w83781d                35620  0
hwmon_vid               3712  1 w83781d
i2c_dev                11136  0
i2c_isa                 6016  1 w83781d
i2c_i801               10124  0
i2c_core               23296  5 adm1021,w83781d,i2c_dev,i2c_isa,i2c_i801
lp                     13220  0
e100                   43012  0
mii                     7040  1 e100
e1000                 125624  0
parport_pc             38724  1
parport                39624  2 lp,parport_pc
pcspkr                  3204  0
psmouse                40708  0
floppy                 65252  0
serio_raw               8580  0
shpchp                 50144  0
pci_hotplug            30652  1 shpchp
sg                     40992  0
evdev                  11136  0
ext3                  147848  1
jbd                    62996  1 ext3
ide_generic             2432  0
uhci_hcd               35984  0
usbcore               139012  2 uhci_hcd
piix                   12420  1
generic                 5892  0
sd_mod                 21248  3
gdth                   86436  4
scsi_mod              146184  3 sg,sd_mod,gdth
thermal                14728  0
processor              27080  1 thermal
fan                     5764  0
capability              5896  0
commoncap               8192  1 capability
vga16fb                14856  1
vgastate               11136  1 vga16fb
fbcon                  44448  70
tileblit                3712  1 fbcon
font                    9216  1 fbcon
bitblit                 7424  1 fbcon
softcursor              3200  1 bitblit
---------
-------------- next part --------------
##########################################################################
#    Sensors configuration file used by 'libsensors' for Tyan S2720      #
#                                                                        #
#  To your /etc/modules.conf file, add the lines:                        #
#     alias char-major-89 i2c-dev                                        #
#     options w83781d force_w83782d=0,0x29 force_subclients=0,0x29,0x48,0x49 force_w83627hf=0,0x2a force_subclients=0,0x2a,0x4a,0x4b init=0              #
#     options adm1021 force_adm1021=0,0x18,0,0x19                        #
#                                                                        #
#  To your /etc/rc.xxx files, add the lines:                             #
#     modprobe i2c-i801                                                  #
#     #modprobe i2c-isa                                                  #
#     modprobe w83781d                                                   #
#     modprobe adm1021                                                   #
#     sensors -s                                                         #
#                                                                        #
#  Then copy this file to /etc/sensors.conf                              #
#                                                                        #
#  Notes: BIOS 1.02 and lower must add the i2c-isa module to             #
#      the /etc/sysconfig/lm_sensors and /etc/rc.xxx files. Beta BIOS    #
#      dated 0219a initializes the 627hf to the i2c bus properly, and    #
#      therefore does not require the i2c-isa module.  Currently, the    #
#      BIOS also has a problem with the CPU temps.  If they read -1,     #
#      or 255, check the Tyan website for an updated BIOS.               #
#                                                                        #
# Edited by: kevin schlichter <kevins at tyan.com>  03/12/03                #
#                                                                        #
# Update: 06.18.03  Added settings for fan_div since I've noticed        #
#      problems with Intel .18A fans. Also, I added to the notes.        #
#                                                                        #
##########################################################################

chip "w83782d-*"

    ignore in0 
    ignore in1 
    ignore in5
    ignore in6
    ignore in7
    ignore vid
    ignore temp2 #these work only for 533MHz FSB CPUs, which aren't 
    ignore temp3 #supported on this board (see 2723/2721-533/2720-533).

    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in8 "VBat"
    
    label fan1 "CPU1 Fan"
    label fan2 "CPU2 Fan"
    label fan3 "Fan3"

    label temp1 "VRM Temp"

# These voltages are reduced by external resistor circuits.  
# These lines will adjust for that.
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20
    
    set beep_enable 0

# thermal sensor types (do not adjust)
    set sensor1 2

# temperature limits
    set temp1_over 100
    set temp1_hyst 90

# Fan settings.  .18A fans may need this changed to 4.
    set fan1_div 2
    set fan2_div 2
    set fan3_div 2

chip "w83627hf-*"

    label fan1 "Fan4"
    label fan2 "Fan5"
    label fan3 "Fan6"

    ignore in0
    ignore in1
    ignore in2
    ignore in3
    ignore in4
    ignore in5
    ignore in6
    ignore in7
    ignore in8
    ignore temp1
    ignore temp2
    ignore temp3
    ignore vid

    set beep_enable 0

# Fan settings.  .18A fans may need this changed to 4.
    set fan1_div 2
    set fan2_div 2
    set fan3_div 2

chip "adm1021-i2c-*-18"
    ignore temp
    ignore die_code

    label remote_temp "CPU 1 temp"

chip "adm1021-i2c-*-19"
    ignore temp
    ignore die_code

    label remote_temp "CPU 2 temp"
