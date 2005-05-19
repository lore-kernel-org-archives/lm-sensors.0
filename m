From: frdurso@yahoo.com.br (=?iso-8859-1?q?Fernando=20Durso?=)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031128123728.81676.qmail@web14712.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, you were right, my lm-sensors was using the 1.6 version of i2c-nforce2.c, so i did what you asked anda now here is my output of sensors:
 
root@athlon:/usr/src/teste/cvs/lm_sensors2# sensors
eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.60 V  (min =  +1.57 V, max =  +1.73 V)
VCore 2:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +3.26 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.01 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +12.05 V  (min = +10.83 V, max = +13.19 V)
-12V:     -11.93 V  (min = -13.16 V, max = -10.90 V)
-5V:       -5.14 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.51 V  (min =  +4.74 V, max =  +5.24 V)
VBat:      +2.98 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 14062 RPM, div = 2)
fan2:     3609 RPM  (min = 112500 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 1687 RPM, div = 4)              ALARM
temp1:       +36?C  (high =   +99?C, hyst =    +1?C)   sensor = thermistor      
temp2:     +41.5?C  (high =  +120?C, hyst =  +115?C)   sensor = thermistor      
temp3:     +32.0?C  (high =  +120?C, hyst =  +115?C)   sensor = thermistor      
vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm disabled

Now it?s "realy" okay :-) isn?t it?
 
Thanks.

Jean Delvare <khali@linux-fr.org> wrote:
> I don't know if you received this...

Now we do, but not before, if that was your question.

> I've downloaded i2c and lm-sensors from CVS patched a new "fresh"
> kernel source, compiled it and installed i2c and sensors, after i've
> ran sensors-detect, then rebooted and typed sensors... it worked!

Great :)

> fernando@athlon:~$ sensors
> eeprom-i2c-0-51
> Adapter: SMBus nForce2 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Unknown EEPROM type (65)

That problem is still there.

Could you please ensure you have the change Mark made, that is supposed
to fix it? In lm_sensors2, type "cvs status
kernel/busses/i2c-nforce2.c". If it says version 1.6, you don't have the
fix. Please do "cvs update", recompile, reinstall and recycle modules
and try again. If it says version 1.7, this means that Mark's fix did
not work.

> root@athlon:~# wich sensors
> -su: wich: command not found
> root@athlon:~# ldd $(wich sensors)
> -su: wich: command not found
> ldd: missing file arguments

This is "which", not "wich" (this is why the commands are failing). But
we don't need that information anymore anyway.

Thanks for your help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/


---------------------------------
Yahoo! Mail - 6MB, anti-spam e antiv?rus gratuito. Crie sua conta agora!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031128/582907a9/attachment.html
