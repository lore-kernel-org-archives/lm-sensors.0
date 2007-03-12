From: Lakshmi.Venkataram@smithsdetection.com (Venkataram, Lakshmi (DEWN))
Date: Mon, 12 Mar 2007 20:15:47 +0000
Subject: [lm-sensors] Sensors reports out of range values
Message-Id: <B75E0279E6507E44A9C27B96D66D68A202B8F4F0@cossmgmbx06.EMAIL.CORP.TLD>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I have a system with Quad-Core Intel Xeon Processor X5355 processor running Linux 2.6.19. 

The sensors-detect listed the following in /etc/sysconfig/lm_sensors file:
MODULE_0=i2c-i801
MODULE_1=w83781d
MODULE_2=w83793
MODULE_3=w83627hf

Running the sensors executable produced the following listing. The reported values as well as the min and max ranges seem to be incorrect . In some instances, the min is greater than the max.

w83627hf-i2c-0-2d
Adapter: SMBus I801 adapter at 1100
VCore 1:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
VCore 2:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
+3.3V:     +4.08 V  (min =  +2.82 V, max =  +3.79 V)       ALARM  
+5V:       +5.03 V  (min =  +5.78 V, max =  +0.24 V)       ALARM  
+12V:     +11.61 V  (min =  +8.03 V, max =  +6.63 V)       ALARM  
-12V:      +1.04 V  (min = -12.85 V, max = -11.37 V)       ALARM  
-5V:       +1.84 V  (min =  +0.08 V, max =  -0.17 V)       ALARM  
V5SB:      +5.62 V  (min =  +3.04 V, max =  +1.77 V)       ALARM  
VBat:      +3.17 V  (min =  +3.20 V, max =  +2.88 V)       ALARM  
fan1:        0 RPM  (min = 48214 RPM, div = 2)              ALARM  
fan2:        0 RPM  (min = 2812 RPM, div = 2)              ALARM  
fan3:        0 RPM  (min = 56250 RPM, div = 2)              ALARM  
temp1:       -48?C  (high =   +88?C, hyst =  -116?C)   sensor = thermistor           
temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
vid:      +1.419 V  (VRM Version 11.0)
alarms:   
beep_enable:
          Sound alarm enabled

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
VCore 2:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
+3.3V:     +4.08 V  (min =  +2.82 V, max =  +3.79 V)       ALARM  
+5V:       +5.08 V  (min =  +5.78 V, max =  +0.24 V)       ALARM  
+12V:     +11.86 V  (min =  +8.03 V, max =  +6.63 V)       ALARM  
-12V:      +1.04 V  (min = -12.85 V, max = -11.37 V)       ALARM  
-5V:       +1.89 V  (min =  +0.08 V, max =  -0.17 V)       ALARM  
V5SB:      +5.62 V  (min =  +3.04 V, max =  +1.77 V)       ALARM  
VBat:      +3.17 V  (min =  +3.20 V, max =  +2.88 V)       ALARM  
fan1:        0 RPM  (min = 48214 RPM, div = 2)              ALARM  
fan2:        0 RPM  (min = 2812 RPM, div = 2)              ALARM  
fan3:        0 RPM  (min = 56250 RPM, div = 2)              ALARM  
temp1:       -48?C  (high =   +88?C, hyst =  -116?C)   sensor = thermistor           
temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
vid:      +1.419 V  (VRM Version 11.0)
alarms:   
beep_enable:
          Sound alarm enabled


Should I manually set the min/max limits in the /etc/sensors.conf file? Is the reported VRM version correct? Do I need an updated lm_sensors package? I am a new user of lm_sensors and would appreciate your assistance.

Thanks,

Lakshmi Venkataram
Smiths Detection
2202 Lakeside Blvd.
Edgewood, MD 21040






</table> </Pre>
<HTML>
<br>
<br>
************************************************<br>
The information contained in, or attached to, this e-mail, may contain confidential information and is intended solely for the use of the individual or entity to whom they are addressed and may be subject to legal privilege.  If you have received this e-mail in error you should notify the sender immediately by reply e-mail, delete the message from your system and notify your system manager.  Please do not copy it for any purpose, or disclose its contents to any other person.  The views or opinions presented in this e-mail are solely those of the author and do not necessarily represent those of the company.  The recipient should check this e-mail and any attachments for the presence of viruses.  The company accepts no liability for any damage caused, directly or indirectly, by any virus transmitted in this email.<br>
************************************************<br>
</HTML>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070312/a3a513dc/attachment.html 
