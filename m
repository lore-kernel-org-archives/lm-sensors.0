From: lea.gris@noiraude.net (Lea Gris)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: [feedback] Asus CUV4X correct settings
Message-Id: <41703183.1040000@noiraude.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here is a feedback regarding proper setting for an Asus CUV4X motherboard.

chip "as99127f-*"

# If you know other boards where they are swapped, let us know and
# we'll update the list.

Here it is :)

# Some working settings for Asus CUV4X VIAPro P3 CPU, kernel 2.6.8.1
# lm_sensors 2.8.7

# Single power plane (A7V133, A7M266)
    label in0 "VCore"
    ignore in1

# However, some A7N8X boards (Deluxe rev.2, -X) have them swapped:
    label temp1 "CPU Temp"
    label temp2 "M/B Temp"

You can add CUV4X in this cathegory of single power line and reversed 
CPI/M/B Temp

as99127f-i2c-1-2d
Adapter: SMBus Via Pro adapter at e800
VCore:     +1.66 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +3.39 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.13 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +12.34 V  (min = +10.82 V, max = +13.19 V)
-12V:     -12.46 V  (min = -13.22 V, max = -10.74 V)
-5V:       -5.06 V  (min =  -5.25 V, max =  -4.74 V)
fan1:     4470 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min =    0 RPM, div = 2)
CPU Temp:    +34?C  (high =  +105?C, hyst =    +0?C)
M/B Temp:  +26.0?C  (high =   +72?C, hyst =   +65?C)
temp3:     -31.5?C  (high =  +122?C, hyst =  +121?C)
vid:      +1.650 V
alarms:
beep_enable:
           Sound alarm enabled

# temp3 is inaccurate because there are no sensors
# connected to this port with the Asus CUV4X

Si I could add
     ignore temp3

# My box specific setting
# No other fans reporting speed in my box (not CUV4X specific)
    label fan1 "CPU Fan"
    ignore temp3
    ignore fan2
    ignore fan3

And finnally here it is :

as99127f-i2c-1-2d
Adapter: SMBus Via Pro adapter at e800
VCore:     +1.66 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +3.39 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.13 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +12.34 V  (min = +10.82 V, max = +13.19 V)
-12V:     -12.46 V  (min = -13.22 V, max = -10.74 V)
-5V:       -5.06 V  (min =  -5.25 V, max =  -4.74 V)
CPU Fan:  4470 RPM  (min =    0 RPM, div = 2)
CPU Temp:    +34?C  (high =  +105?C, hyst =    +0?C)
M/B Temp:  +28.0?C  (high =   +72?C, hyst =   +65?C)
vid:      +1.650 V
alarms:
beep_enable:
           Sound alarm enabled

With room temperature around 22?C it makes me very happy with the 
current setting.

CPU is a Pentiom III (Coppermine) 733EB with 512Mb 133 DDR/SDRAM.


Best regards,

-- 
L?a Gris
