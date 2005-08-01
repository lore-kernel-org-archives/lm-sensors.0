From: hvw59601@yahoo.com (Hugo Vanwoerkom)
Date: Mon, 01 Aug 2005 21:03:54 +0000
Subject: [lm-sensors] [SOLVED] Patch for support of Winbond W83687THF in
Message-Id: <20050801190304.39511.qmail@web31001.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks Jean! I was so close! Forgot the i2c-isa
module!

So I enclose a patch to lm_sensors-2.9.1 to support
the chip.

This is what "sensors" reports:

w83687thf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.63 V  (min =  +0.00 V, max =  +0.00 V)  
           
VCore 2:   +3.38 V  (min =  +0.00 V, max =  +0.00 V)  
           
+3.3V:     +2.72 V  (min =  +3.14 V, max =  +3.46 V)  
           
+5V:       +5.06 V  (min =  +4.74 V, max =  +5.24 V)  
           
+12V:      +0.00 V  (min = +10.83 V, max = +13.19 V)  
           
V5SB:      +4.92 V  (min =  +4.74 V, max =  +5.24 V)  
           
VBat:      +3.15 V  (min =  +2.40 V, max =  +3.60 V)  
           
fan1:        0 RPM  (min = 2136 RPM, div = 8)         
           
fan2:     3813 RPM  (min = 2824 RPM, div = 2)         
           
fan3:        0 RPM  (min =  718 RPM, div = 8)         
           
temp1:       +29?C  (high =   -78?C, hyst =  +124?C)  
sensor = thermistor   ALARM   
temp2:     +40.0?C  (high =   +76?C, hyst =   +71?C)  
sensor = diode           
temp3:     +30.5?C  (high =   +76?C, hyst =   +71?C)  
sensor = thermistor           
vid:      -1.200 V  (VRM Version 8.2)
alarms:   
beep_enable:
          Sound alarm disabled

Note that some of the limits are wrong. Also the EPOX
EP-8VTAI mobo that uses this chip has some confusion
too, because it uses temp1 but says it is at 22C when
the ambient temp is 25C, so that cannot be.

So I get support in 2.4.31 by installing the 2 2.9.1
tarballs, applying the patch to lm_sensors and Jean's
i2c-patch to the kernel and then make + make install
on the 2.

Note that I change the Makefile of lm_sensors to
install it in /usr instead of /usr/local.

Thanks again!

Hugo


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.9.1.patch
Type: text/x-patch
Size: 6887 bytes
Desc: 1261993164-lm_sensors-2.9.1.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050801/1f07d43d/lm_sensors-2.9.1.bin
