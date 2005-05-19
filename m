From: cedric.perriot@laposte.net (cedric)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: changing pwm does not change fan speed
Message-Id: <40756AB1.60005@laposte.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I am using i2c-2.8.4 and lm_sensors-2.8.6 on an Asus A7V133-C
Install ran fine and the detection as well.
I came up with the lines :
    # I2C adapter drivers
    i2c-viapro
    i2c-isa
    # I2C chip drivers
    w83781d
     via686a
for my /etc/modules file.

I can use the sensors command and get the following
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
VCore 1:   +1.86 V  (min =  +1.86 V, max =  +2.05 V)       ALARM 
VCore 2:   +0.10 V  (min =  +1.86 V, max =  +2.05 V)       ALARM 
+3.3V:     +3.63 V  (min =  +3.14 V, max =  +3.46 V)       ALARM 
+5V:       +5.01 V  (min =  +4.74 V, max =  +5.24 V)             
+12V:     +12.24 V  (min = +10.83 V, max = +13.19 V)             
-12V:     -11.96 V  (min = -13.23 V, max = -10.73 V)             
-5V:       -5.13 V  (min =  -5.25 V, max =  -4.74 V)             
fan1:        0 RPM  (min =    0 RPM, div = 2)                    
fan2:     4927 RPM  (min = 2836 RPM, div = 2)                     (beep)
fan3:        0 RPM  (min =    0 RPM, div = 2)                    
temp1:       -45?C  (high =  +105?C, hyst =    +0?C)         
temp2:    +217.4?C  (high =   +95?C, hyst =   +80?C)          (beep)
temp3:    +211.4?C  (high =  +122?C, hyst =  +121?C)         
vid:      +1.950 V
alarms:  
beep_enable:
          Sound alarm enabled

via686a-isa-e200
Adapter: ISA adapter
CPU core:  +3.03 V  (min =  +1.98 V, max =  +2.49 V)  
+2.5V:     +1.51 V  (min =  +2.24 V, max =  +3.03 V)  
I/O:       +3.03 V  (min =  +3.03 V, max =  +4.05 V)  
+5V:       +3.14 V  (min =  +6.20 V, max =  +6.30 V)  
+12V:     +15.28 V  (min =  +7.61 V, max =  +7.61 V)  
CPU Fan:  5314 RPM  (min = 3139 RPM, div = 2)         
P/S Fan:     0 RPM  (min = 3534 RPM, div = 2)         
SYS Temp:  +23.2?C  (high =   +45?C, hyst =   +40?C)  
CPU Temp:  +23.2?C  (high =   +60?C, hyst =   +55?C)  
SBr Temp:  -50.3?C  (high =   +65?C, hyst =   +60?C)  
 

But if I can't change the speed of the fan. I tried 'echo 10 > 
/proc/sys/dev/sensors/as99127f-i2c-0-2d/pwm[12]' and It does not change 
the speed.
 I found in an old ticket (2001 or 2002) something about a bit that has 
to be changed to activate the pwm control but is it still true ?


Then another minor problem is I tried to use a script 
(http://www.lula.org/pipermail/lula/2004-January/002290.html) but after 
launching it the values of the sensors command are stable and wrong and 
I couldn't figure why.

thank you for your help


