From: hedpi@shitbreak.org (Miguel)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: system hang
Message-Id: <20030907083308.53be76d1.hedpi@shitbreak.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030903034244.73f27e9f.miguel.vagos@mail.telepac.pt>
In-Reply-To: <20030903034244.73f27e9f.miguel.vagos@mail.telepac.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hehe i know the ticket is old ;)

I tried it and the system did hang on loading w83781d.

The chip is a w83782d on a Via Apollo Pro chipset, the board is a FIC vb-601-v.

# lspci -n
00:00.0 Class 0600: 1106:0691 (rev 22)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0596 (rev 09)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 02)
00:07.3 Class 0600: 1106:3050
00:0a.0 Class 0200: 10ec:8139 (rev 10)
00:0b.0 Class 0200: 10ec:8029
01:00.0 Class 0300: 10de:0111 (rev b2)

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 34).
      Master Capable.  Latency.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 9).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 6).
      Master Capable.  Latencyd.  
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. USB (rev 2).
      IRQ 11.
      Master Capable.  Latencyd.  
      I/O at 0xde00 [0xde1f].
  Bus  0, device   7, function  3:
    Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 0).
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 16).
      IRQ 12.
      Master Capable.  Latencyd.  Min Gnt2.Max Latd.
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xdfffff00 [0xdfffffff].
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 11.
      I/O at 0xda00 [0xda1f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX DDR] (rev 178).
      IRQ 9.
      Master Capable.  Latencyd.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].

I tried loading the modules in several diferent sequences and got it to crash loading i2c-viapro also, but if i load in this order:

# modprobe i2c-core   ( /var/log/messages: Sep  3 11:45:19 www kernel: i2c-core.o: i2c core module version 2.8.0 (20030714) )
# modprobe i2c-proc   ( /var/log/messages: Sep  3 11:46:35 www kernel: i2c-proc.o version 2.8.0 (20030714) )
# modprobe i2c-dev    ( /var/log/messages: Sep  3 11:47:13 www kernel: i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714) )
# modprobe i2c-viapro ( /var/log/messages: Sep  3 12:06:02 www kernel: i2c-viapro.o version 2.8.0 (20030714) )

# cat /proc/bus/i2c
i2c-0   smbus           SMBus Via Pro adapter at 0400           Non-I2C SMBus adapter

At this point of writing this e-mail i stopped and went to the server opened its case and tried finding a chip, and i did.
The chip is a winbond w83977ee-aw, which i dont find on your supported chips page, maybe thats why w83781d hanged the computer.
I did this because the mb manual said it had a w83782d chip, and as you can see it doesnt.
After this i tried to get some more information for the other possible causes of the hang, so i tried i2cdetect

 # prog/detect/i2cdetect 
Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       smbus           SMBus Via Pro adapter at 0400           Non-I2C SMBus adapter
 # prog/detect/i2cdetect 0    
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
(HANGED HERE)

Then i tried isadump but it gave me nothing interesting:

# prog/dump/isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!

~x     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

This was all i tried today, althoug yesterday i tried several combinations of modprobing which all ended in having the system freeze, i tried 1-core 2-viapro 3-w83781d, tried adding dev and/or proc with several combinations, and it always crashed, and finally i tried loading another one, i tried modprobing lm80 and it also hanged the computer !

I am a bit confused but i think it may be something to do with the bus.

Hope you can help me out ! Thanks for the feedback.

 - Miguel




On Wed, 3 Sep 2003 00:10:44 -0400
"Mark M. Hoffman" <mhoffman@lightlink.com> wrote:

> * Miguel <miguel.vagos@mail.telepac.pt> [2003-09-03 03:42:44 +0000]:
> > http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticketi7
> > 
> > Does this still occur with version 2.8.0 (i2c and lm_sensors) or has the module been modified already ?
> 
> Er, that ticket is almost 2 years old; it mentions version 2.6.1.
> By "the module" you mean w83781d right?  That has been modified
> many, many times in the last 2 years.  The parameter mentioned in
> the ticket is "init=0".  Probably you won't find out if it works
> until you try it and see...
> 
> Regards,
> 
> -- 
> Mark M. Hoffman
> mhoffman@lightlink.com
> 
