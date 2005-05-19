From: crusher9@fullnet.com (crusher9)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Question on how to update i2c with kernel 2.4.21 or greater
Message-Id: <1060904999.1154.23.camel@lcomp18.tanccrusher.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, I am confused on how to get lm_sensors updated with kernel 2.4.21 or
greater. I have seen http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
page, but I am misunderstanding what happens.

This is what I have done so far. I have kernel 2.4.21 and have applied
patch-2.4.22-rc2 to it. Needed to go to this point to get USB 2.0 mass
storage devices to work. So from here what command do I issue to update
i2c to patch into the kernel?

I have tried this.
patch -p1 -E < linux-2.4.21-i2c-2.8.0.patch

and got these results.

patching file drivers/acorn/char/i2c.c
Hunk #1 succeeded at 303 (offset 100 lines).
patching file drivers/acorn/char/pcf8583.c
patching file drivers/i2c/Config.in
patching file drivers/i2c/Makefile
patching file Documentation/i2c/dev-interface
patching file Documentation/i2c/i2c-pport
patching file Documentation/i2c/i2c-protocol
patching file Documentation/i2c/i2c-velleman
patching file Documentation/i2c/smbus-protocol
patching file Documentation/i2c/summary
patching file Documentation/i2c/writing-clients
patching file drivers/i2c/i2c-adap-ibm_ocp.c
patching file drivers/i2c/i2c-algo-8xx.c
patching file include/linux/i2c-algo-8xx.h
patching file drivers/i2c/i2c-algo-bit.c
Hunk #28 FAILED at 557.
1 out of 29 hunks FAILED -- saving rejects to file
drivers/i2c/i2c-algo-bit.c.rej
patching file include/linux/i2c-algo-bit.h
patching file drivers/i2c/i2c-algo-ibm_ocp.c
patching file include/linux/i2c-algo-ibm_ocp.h
patching file drivers/i2c/i2c-algo-pcf.c
patching file include/linux/i2c-algo-pcf.h
patching file drivers/i2c/i2c-core.c
Hunk #55 FAILED at 1396.
1 out of 57 hunks FAILED -- saving rejects to file
drivers/i2c/i2c-core.c.rej
patching file drivers/i2c/i2c-dev.c
Hunk #8 succeeded at 177 (offset 1 line).
Hunk #10 succeeded at 218 (offset 1 line).
Hunk #11 succeeded at 302 (offset 8 lines).
Hunk #12 succeeded at 308 (offset 1 line).
Hunk #13 succeeded at 335 (offset 8 lines).
Hunk #14 succeeded at 339 (offset 1 line).
Hunk #15 succeeded at 359 (offset 8 lines).
Hunk #16 succeeded at 367 (offset 1 line).
Hunk #17 succeeded at 390 (offset 8 lines).
Hunk #18 succeeded at 399 (offset 1 line).
Hunk #19 succeeded at 428 (offset 8 lines).
Hunk #20 succeeded at 436 (offset 1 line).
Hunk #21 succeeded at 453 (offset 8 lines).
Hunk #22 succeeded at 468 (offset 1 line).
Hunk #23 succeeded at 482 (offset 8 lines).
Hunk #24 succeeded at 482 (offset 1 line).
patching file include/linux/i2c-dev.h
patching file drivers/i2c/i2c-elektor.c
patching file include/linux/i2c-elektor.h
patching file drivers/i2c/i2c-elv.c
patching file drivers/i2c/i2c-frodo.c
patching file include/linux/i2c-id.h
patching file drivers/i2c/i2c-pcf-epp.c
patching file include/linux/i2c-pcf8584.h
patching file drivers/i2c/i2c-philips-par.c
patching file drivers/i2c/i2c-pport.c
patching file drivers/i2c/i2c-proc.c
patching file include/linux/i2c-proc.h
patching file drivers/i2c/i2c-rpx.c
patching file drivers/i2c/i2c-velleman.c
patching file include/linux/i2c.h
patching file Documentation/Configure.help
Hunk #1 succeeded at 17995 (offset 244 lines).
Hunk #3 succeeded at 18094 (offset 244 lines).
patching file drivers/i2c/i2c-adap-ite.c
patching file drivers/i2c/i2c-keywest.c
patching file drivers/i2c/scx200_acb.c
patching file drivers/i2c/scx200_i2c.c
patching file drivers/ieee1394/pcilynx.c
Hunk #1 succeeded at 139 (offset 1 line).
patching file drivers/media/video/Makefile
patching file drivers/media/video/bt832.c
patching file drivers/media/video/bttv-if.c
Hunk #1 succeeded at 190 with fuzz 1 (offset -4 lines).
Hunk #2 FAILED at 238.
1 out of 2 hunks FAILED -- saving rejects to file
drivers/media/video/bttv-if.c.rej
patching file drivers/media/video/i2c-old.c
patching file drivers/media/video/msp3400.c
Hunk #1 succeeded at 1243 (offset -12 lines).
patching file drivers/media/video/saa5249.c
patching file drivers/media/video/saa7146.h
patching file drivers/media/video/tda7432.c
patching file drivers/media/video/tda9875.c
Hunk #1 succeeded at 386 (offset -1 lines).
patching file drivers/media/video/tda9887.c
Hunk #1 succeeded at 438 (offset -10 lines).
patching file drivers/media/video/tuner-3036.c
patching file drivers/media/video/tuner.c
Hunk #1 succeeded at 963 (offset 2 lines).
patching file drivers/media/video/tvaudio.c
Hunk #1 succeeded at 1644 (offset 96 lines).
patching file drivers/media/video/tvmixer.c
Hunk #1 succeeded at 192 (offset -3 lines).
patching file drivers/pcmcia/sa1100_stork.c
patching file drivers/sound/dmasound/dac3550a.c
patching file drivers/sound/dmasound/tas3001c.c
patching file drivers/video/matrox/i2c-matroxfb.c
patching file drivers/video/matrox/matroxfb_maven.c

As you can see I have a few errors above. Is this the correct way to get
this to work? If not what is the correct procedure?





Thanks for all your help.
Brian Schoenfelder



Sensors were working fine on Gkrellm and kernel 2.4.20-19.9 then I
updated to kernel 2.4.21 with patch 2.4.22.rc2.

I am running Redhat 9 with kernel 2.4.22-rc2 with smp support.
lm_sensors 2.6.5-5

The following setup is provided by Tyan for my S2462UGN board

added this to my rc.local file.
modprobe i2c-amd756                                                #
modprobe w83781d                                                   #
modprobe eeprom                                                    #
sensors -s                                  

senosrs.conf file is
##########################################################################
#    Sensors configuration file used by 'libsensors' for Tyan S2462     
#
#                                                                       
#
#  To your /etc/modules.conf file, add the lines:                       
#
# alias char-major-89 i2c-dev                                           
#
# options w83781d force_w83782d=0,0x2d force_subclients=0,0x2d,0x48,0x49
force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b
init=0                  #
#                                                                       
#
#  To your /etc/rc.xxx files, add the lines:                            
#
#     modprobe i2c-amd756                                               
#
#     modprobe w83781d                                                  
#
#     modprobe eeprom                                                   
#
#     sensors -s                                                        
#
#                                                                       
#
#  Then copy this file to /etc/sensors.conf                             
#
#                                                                       
#
# Edited by: kevin schlichter <kevins@tyan.com> 05.16.03                
#
#   UPDATE: 06.18.03 => monitor fan3 on 627hf, set vrm 9.0, renamed some
#
#   fan labels, add compute lines for fans, initialize fan_div since the
#
#   BIOS doesn't.  You may also want to check tickets 861 & 867 on the  
#
#   lm_sensors website for code to initialize the 672hf on the i2c      
#
#   correctly.  I haven't checked it, so if you die from running it,    
#
#   don't blame me.  You can also enter the BIOS, view the hardware     
#
#   monitoring, and exit WITHOUT changes to accomplish the same goal.   
#
#      Thanks to Steffen Grunewald for the suggestions.                 
#
#                                                                       
#
##########################################################################

chip "w83782d-*"

    ignore in0
    ignore in1
    ignore in5
    ignore in7
    ignore vid

    label in2 "AGP V"
    label in3 " +5 V"
    label in4 "DDR V"
    label in6 "3 VSB"
    label in8 "Bat V"

    label fan1 "CPU1 Fan"
    label fan2 "CPU2 Fan"
    label fan3 "chs1 Fan"

    label temp1 "VRM2 Temp"
    label temp2 "CPU1 Temp"
    label temp3 "CPU2 Temp"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in6_max 3.0 * 1.05
    set in6_min 3.0 * 0.95
    set in8_min 3.3 * 0.80
    set in8_max 3.3 * 1.20

# thermal sensor types (do not adjust)
    set sensor1 2
    set sensor2 2
    set sensor3 2

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 60	
#    set temp2_over 70
#    set temp2_hyst 80	
#    set temp3_over 70
#    set temp3_hyst 80	

    set beep_enable 0

# CPU VRM Spec.
    set vrm 9.0

# Fan divisors.  Some fans (.18A) may need this to be set to 4
    set fan1_div 2
    set fan2_div 2
    set fan3_div 2

chip "w83627hf-*"

    ignore in3
    ignore in6
    ignore in7
    ignore in8
    ignore vid

    label in0 "VCore1"
    label in1 "VCore2"
    label in2 "+3.3 V"
    label in4 " +12 V"
    label in5 " -12 V"

    label temp1 "VRM1 Temp"
    label temp2 "AGP Temp"
    label temp3 "DDR Temp"

    label fan1 "chs2 Fan"
    label fan2 "chs5 Fan"
    label fan3 "chs6 Fan"

    compute in4 ((3.8/1)+1)*@ , @/((3.8/1)+1)
    compute in5 (5.14*@)-14.91 , (@+14.91)/5.14
    compute fan1 @*2 , @/2
    compute fan2 @*2 , @/2
    compute fan3 @*2 , @/2

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in2_min 3.3*0.95
    set in2_max 3.3*1.05
    set in4_max 12 * 0.90
    set in4_min 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10

# thermal sensor types (do not adjust)
    set sensor1 2
    set sensor2 2
    set sensor3 2

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 37
#    set temp2_over 52
#    set temp2_hyst 47
#    set temp3_over 52
#    set temp3_hyst 47

    set beep_enable 0

# CPU VRM Spec.
    set vrm 9.0

# Fan divisors.  Some fans (.18A) may need this to be set to 4
    set fan1_div 2
    set fan2_div 2
    set fan3_div 2






Thanks for all your help.
Brian Schoenfelder
 
