From: paul.aviles@palei.com (Paul Aviles)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: question
Message-Id: <000301c4ea5a$705e4900$3224050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020214113146.O24643@Stimpy.netroedge.com>
In-Reply-To: <20020214113146.O24643@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Thanks to all for your answers and support. I was finally able to figure out 
my problems with the .spec file and I am now creating the rpms.

One question I have is that I have two indentical systems from the same 
manufacturer, Tyan. One has a Celeron CPU and the other has a P4 with HT, 
but the motherboards are the same. On one unit I must use a lm85-* in 
sensors.conf and the the other with a adt7463-* for the chips section or the 
values don't make sense.

Could the different CPU's be causing lmsensors to get confused? I even ran 
the detect routines and came with the same results. What else could I do to 
check this?

Thanks so much!!

Paul

Sample report.

lm85-i2c-0-2e
Adapter: SMBus I801 adapter at 1480
+2.6V:      +2.62 V  (min =  +2.47 V, max =  +2.73 V)
CPU Volt: +1.31 V  (min =  +1.25 V, max =  +1.40 V)
+3.3V:      +3.35 V  (min =  +3.13 V, max =  +3.47 V)
+5V:       +5.05 V  (min =  +4.74 V, max =  +5.26 V)
Fan2:      8424 RPM  (min = 4800 RPM)
Fan1:      6136 RPM  (min = 4800 RPM)
Fan3:      9294 RPM  (min = 2200 RPM)
CPU Temp:    +47?C  (low  =    +5?C, high =   +68?C)
Loc Temp:     +36?C  (low  =    +5?C, high =   +40?C)
Sys Temp:      +38?C  (low  =    +5?C, high =   +50?C)
vid:      +1.325 V  (VRM Version 9.1)

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 1480
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 1480
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512




-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
