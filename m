From: tomcw@adelphia.net (Tom Weichmann)
Date: Sun, 18 Mar 2007 14:39:39 +0000
Subject: [lm-sensors] No Fan output
Message-Id: <200703181039.39818.tomcw@adelphia.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have just switched over to a new board, an MSI K8MM-V 
(http://www.msicomputer.com/product/p_spec.asp?model=K8MM-V&class=mb).  I 
setup lm_sensors on a fresh install of SuSE 10.2, but I don't get any output 
from my fans.  I do, however get the correct temps for the mobo, and CPU.

Here is my ln_sensors versions:

tom at linux:/mnt/disk3> sudo sensors-detect --version
root's password:
# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

tom at linux:/mnt/disk3> sensors --version
sensors version 2.10.1 with libsensors version 2.10.1


Here is the output form sensors:

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.42 V  (min =  +0.00 V, max =  +3.84 V)
+12V:     +12.28 V  (min =  +9.67 V, max =  +9.00 V)       ALARM
+3.3V:     +3.18 V  (min =  +0.38 V, max =  +3.49 V)
+5V:       +4.91 V  (min =  +4.27 V, max =  +3.76 V)       ALARM
-12V:     -11.95 V  (min = -14.42 V, max = -12.94 V)       ALARM
V5SB:      +4.84 V  (min =  +0.30 V, max =  +2.42 V)       ALARM
VBat:      +3.42 V  (min =  +0.88 V, max =  +2.38 V)       ALARM
fan1:        0 RPM  (min = 11440 RPM, div = 2)              ALARM
CPU Fan:     0 RPM  (min = 3515 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 112500 RPM, div = 2)              ALARM
M/B Temp:    +41?C  (high =   -18?C, hyst =    +9?C)   sensor = thermistor   
ALA                               RM
CPU Temp:  +35.5?C  (high =   +70?C, hyst =   +65?C)   sensor = thermistor                                     
temp3:     +66.0?C  (high =   +70?C, hyst =   +65?C)   sensor = thermistor                                     
vid:      +0.000 V  (VRM Version 2.4)
alarms:
beep_enable:
          Sound alarm enabled


You can see that all three fans are listed at 0 RPM.  When I did 
sensors-detect I suggested four modules: 

i2c-viapro
eeprom
k8temp
w83627hf

K8temp is not on my system so I did not load that, as I already have the temp 
output I need.  If I build this, will it provide me with my fan output?

Thanks,

Tom Weichmann










