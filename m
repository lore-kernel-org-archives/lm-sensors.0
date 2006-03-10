From: raphael@clifford.net (Raphael Clifford)
Date: Fri, 10 Mar 2006 22:37:53 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware monitoring support
Message-Id: <4411FFC1.2060508@clifford.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603042101570.3972@Laila>
In-Reply-To: <Pine.LNX.4.63.0603042101570.3972@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tested the new smsc47m192 driver on my msi rs480m2 system using
2.6.16-rc5 and here are my results.

To get it working I applied the kernel patch from

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015476.html

and the ATI SMBus patch from

http://assembler.cz/download/ati2_patch

I also applied the user space patch from

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015477.html


After this I ran sensors-detect (which still claims not to know what to
do) and then sensors.

I get

smsc47m1-isa-0800
Adapter: ISA adapter
fan1:     1861 RPM  (min =  640 RPM, div = 8)         
fan2:     1107 RPM  (min =  640 RPM, div = 8)         

smsc47m192-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 0400

in0:       +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
in1:       +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
in2:       +0.00 V  (min =  +0.00 V, max =  +4.38 V)   ALARM
in3:       +0.00 V  (min =  +0.00 V, max =  +6.64 V)   ALARM
in5:       +3.33 V  (min =  +0.00 V, max =  +4.38 V)  
in6:       +0.00 V  (min =  +0.00 V, max =  +1.99 V)   ALARM
in7:       +0.00 V  (min =  +0.00 V, max =  +2.39 V)   ALARM
temp1:     +35.0 C  (low  =  -128 C, high =  +127 C) 
temp2:     +55.0 C  (low  =  -128 C, high =   +60 C) 
temp3:    +116.0 C  (low  =  -128 C, high =  +127 C) 
vid:      +1.550 V  (VRM Version 2.4)


which is fantastic!

temp2 is my CPU temp I am 99% sure.  The low and high figures appear to
be meaningless and change depending on what the cpu is doing.  For example

temp2:     +57.0 C  (low  =   +55 C, high =   +65 C)

under light load.


The rest of the measurements are a mystery to me and the 6 ALARMS seem
slightly... alarming :)

Thanks very much for the patches!

Raphael



