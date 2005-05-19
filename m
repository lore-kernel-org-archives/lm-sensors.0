From: donj@asaca.com (Don Jessup)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <20031126213410.26364.qmail@web14526.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


  Thanks Jean,
 
   Using both latest cvs i2c and lm_sensors2.  I was able to get it to work.

  
  I do however have another problem.  I using a dual xeon cpu Super X5DL8-GG 
  motherboard and according to the "sensors"  program one of the CPUs is 
  reporting
  back some invalid numbers as when compared to the BIOS.  For instance, when
  looking at the chip ( sensor information is below )  lm87-i2c-0-2d the fan1
is 
  reporting back 0 RPMs but looking at the
  motherboard I can see that it is clearly spinning.  When viewing the BIOS
  fan RPM info two values are reported, one for each CPU.  How do I get the
  lm87-i2c-0-2d report identical information as lm87-i2c-0-2e chip.  


  I also notice that several of the voltage values for lm87-i2c-0-2d chip
  is different then lm87-i2c-0-2e.  The BIOS only reports only one set of
  voltage values for both CPUs( is this typical of a dual motherboard system?)
  The voltage values that are reported by the BIOS are almost identicle to the
  values reported by lm87-i2c-0-2e.  Can I safely assume that voltage values
  reported by lm87-i2c-0-2d can be ignored?  


   After reading the documentation for both chips it is still not clear to
   me what is the difference between the chips adm1021* and lm87* CPU
   temperatures. Any ideas?
  

   

  The i2c and lm_sensors2 I'm using is out of CVS as of Nov 25.  I'm running
  2.4.22 kernel with 2.8.1 patch.   


  1.  lsmod output.  I have loaded the adm1021 module with
      force_adm1021=0,0x18,0,0x29

  2.  output from sensors.  

  3.  I'm using the default sensors.conf

 1.  lsmod info 
###############################################################################
[root@Hercules sensors]# lsmod
Module                  Size  Used by    Not tainted
lm87                    7328   0  (unused)
adm1021                 6996   0  (unused)
i2c-proc                8084   1  [lm87 adm1021]
i2c-piix4               4584   0
dmi_scan                2148   0  [i2c-piix4]
i2c-core               20324   0  [lm87 adm1021 i2c-proc i2c-piix4]
autofs                 12756   0  (autoclean) (unused)
tg3                    48552   0  (unused)
e1000                  68768   1
ipt_REJECT              4024   6  (autoclean)
iptable_filter          2316   1  (autoclean)
ip_tables              15840   2  [ipt_REJECT iptable_filter]
microcode               5056   0  (autoclean)
ide-scsi               11408   0
scsi_mod              107412   1  [ide-scsi]
ide-cd                 33728   0
cdrom                  31424   0  [ide-cd]
keybdev                 2688   0  (unused)
mousedev                5400   1
hid                    23236   0  (unused)
input                   5984   0  [keybdev mousedev hid]
usb-ohci               21288   0  (unused)
usbcore                76352   1  [hid usb-ohci]
ext3                   67940   6
jbd                    52880   6  [ext3]
raid1                  15724   6

2  sensors info
##############################################################################
[root@Hercules sensors]# sensors
adm1021-i2c-0-18
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Board:       +31?C  (low  =   -55?C, high =  +127?C)
CPU:         +33?C  (low  =    +0?C, high =   +85?C)
die_code:  255

adm1021-i2c-0-29
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Board:       +31?C  (low  =   -55?C, high =  +127?C)
CPU:         +34?C  (low  =    +0?C, high =   +85?C)
die_code:  255

lm87-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
2.5V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
Vccp1:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
3.3V:      +3.26 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
5V:        +2.99 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
12V:      +12.12 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
Vccp2:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
fan1:        0 RPM  (min = 2848 RPM, div = 2)          ALARM
fan2:        0 RPM  (min = 2848 RPM, div = 2)          ALARM
temp1:       +39?C  (low  =    +0?C, high =   +65?C)
CPU_Temp:   +128?C  (low  =    +0?C, high =    +0?C)    FAULT
vid:       +2.05 V

lm87-i2c-0-2e
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
2.5V:      +2.52 V  (min =  +2.12 V, max =  +2.87 V)
Vccp1:     +1.47 V  (min =  +0.98 V, max =  +1.99 V)
3.3V:      +3.26 V  (min =  +2.80 V, max =  +3.78 V)
5V:        +4.94 V  (min =  +4.24 V, max =  +5.75 V)
12V:      +12.00 V  (min = +10.18 V, max = +13.81 V)
Vccp2:     +1.50 V  (min =  +1.26 V, max =  +1.71 V)
fan1:     5400 RPM  (min = 2848 RPM, div = 2)
fan2:     5487 RPM  (min = 2848 RPM, div = 2)
temp1:       +37?C  (low  =    +0?C, high =   +65?C)
CPU_Temp:   +128?C  (low  =   +80?C, high =   +85?C)    FAULT
vid:       +1.35 V




--- Jean Delvare <khali@linux-fr.org> wrote:
> 
> >   When doing a sensors-detect the system just ends up hanging.
> > (...)
> >   6. Sensors Version: 2.8.1
> 
> Probably caused by a bad wordaround introduced in the i2c-piix4 module.
> I commited a fix to our CVS repository a few years ago. Please check
> lm_sensors2 out (see
> http://secure.netroedge.com/~lm78/download.html#cvs) and give it a try
> (don't forget to unload old modules before trying to load them anew).
> 
> You do not need to change anything to i2c, updating lm_sensors2 is
> enough.
> 
> If it still doesn't work, let us know.
> 
> And if it does work, let us know too, please :)
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 
> 
> 


==Don Jessup
Asaca/Shibasoku Corp. of America
400 Corporate Circle, Unit G
Golden, CO  80401
303-278-1111 X232
donj@asaca.com
http://www.asaca.com
