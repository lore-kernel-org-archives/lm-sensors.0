From: kilobug@club-internet.fr (Kilobug)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm sensors and A7M266
Message-Id: <3BDF2FA0.3060307@club-internet.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
	I'm using an Asua A7M266 motherboard, and here is the output:
(kilobug@drizzt, 2) ~ $ sensors
via686a-isa-e300
Adapter: ISA adapter
Algorithm: ISA algorithm
CPU core:  +3.03 V  (min =  +1.79 V, max =  +2.18 V)   ALARM
+2.5V:     +3.03 V  (min =  +2.24 V, max =  +2.74 V)   ALARM
I/O:       +3.27 V  (min =  +2.95 V, max =  +3.62 V)
+5V:       +6.28 V  (min =  +3.93 V, max =  +6.30 V)
+12V:     +15.22 V  (min = +11.33 V, max = +15.28 V)
CPU Fan:     0 RPM  (min = 3000 RPM, div = 2)
P/S Fan:     0 RPM  (min = 3000 RPM, div = 2)
SYS Temp:  -68.8?C  (limit =  +60?C, hysteresis =  +50?C)
CPU Temp:  -68.8?C  (limit =  +60?C, hysteresis =  +50?C)
SBr Temp:  +25.1?C  (limit =  +60?C, hysteresis =  +50?C)

The CPU Temp at -68.8?C, I don't believe it...
I know this something in /etc/sensors.conf, but how can I guess the 
magic formulas?

	Else, I think you should update the kernel modules, because lm-sensors is 
GPL and modprobe says:
Warning: loading 
/home/kilobug/download/lm_sensors-2.6.1/kernel/busses/i2c-isa.o will 
taint the kernel: no license

Just adding:
  MODULE_LICENSE("GPL");
at the end of every module should patch it.

Thank you for your work,
-- 
  ** Gael Le Mignot, Ing3 EPITA, Coder of The Kilobug Team **
Home Mail : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM       : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Web       : http://kilobug.freesurf.fr or http://drizzt.dyndns.org

"Software is like sex it's better when it's free.", Linus Torvalds
