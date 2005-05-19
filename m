From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Thermal fan on PIIIDME
Message-Id: <20020619175209.U1893@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
In-Reply-To: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Incidently, the lm87 can be configured (hardware-wise) in a variety of
ways.  Look at the defines at the top of lm87.c.  If how it is wired
is different from what the driver is expecting, the values go nutty.
Some conditions flag a FAULT warning, which is obvious, but other
mis-configurations aren't so obvious.


Phil

On Thu, Jun 20, 2002 at 01:36:47AM +0100, Chris Rankin wrote:
> Yes, that's done it. I can still hear my thermal fan
> whirring away although the sensor output looks a
> little strange now:
> 
> lm87-i2c-0-2d
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> 2.5V:      +2.51 V  (min =  +2.36 V, max =  +2.63 V)  
> 
> Vccp1:     +1.63 V  (min =  +1.53 V, max =  +1.72 V)  
> 
> 3.3V:      +3.21 V  (min =  +3.12 V, max =  +3.47 V)  
> 
> 5V:        +4.79 V  (min =  +4.73 V, max =  +5.26 V)  
> 
> 12V:      +12.00 V  (min = +11.37 V, max = +12.62 V)  
> 
> Vccp2:     +3.27 V  (min =  +1.56 V, max =  +1.72 V)  
> ALARM
> Internal:    +52?C  (min =  +10?C, max =  +60?C) 
> CPU_Temp:    +41?C  (min =  +10?C, max =  +60?C) 
> vid:       +1.65 V
> 
> lm87-i2c-0-2e
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> Vccp1:     +1.65 V  (min =  +1.53 V, max =  +1.72 V)  
> 
> 3.3V:      +3.23 V  (min =  +3.12 V, max =  +3.47 V)  
> 
> 5V:        +5.05 V  (min =  +4.73 V, max =  +5.26 V)  
> 
> 12V:      +11.87 V  (min = +11.37 V, max = +12.62 V)  
> 
> fan1:     4891 RPM  (min = 1500 RPM, div = 4)         
> 
> fan2:     4821 RPM  (min = 1500 RPM, div = 4)         
> 
> Internal:    +35?C  (min =  +45?C, max =  +50?C) ALARM
> CPU_Temp:    +42?C  (min =  +45?C, max =  +50?C) ALARM
> vid:       +1.65 V
> 
> My CPU is just "too cool", it would seem ;-).
> 
> Fixed now using sensors.conf:
> 
> Internal:    +35?C  (min =  +25?C, max =  +50?C) 
> CPU_Temp:    +44?C  (min =  +25?C, max =  +50?C) 
> 
> However, I can now tell that the BIOS is turning the
> fan on *before* the temperature reaches 50 degrees C.
> Odd...
> 
> Chris
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Everything you'll ever need on one web page
> from News and Sport to Email and Music Charts
> http://uk.my.yahoo.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
