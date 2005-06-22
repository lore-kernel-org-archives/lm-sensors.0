From: rhirst@levanta.com (Richard Hirst)
Date: Wed, 22 Jun 2005 23:29:12 +0000
Subject: [lm-sensors] Reading LM96000 on an Intel SE7221BK1 server board
Message-Id: <20050622212816.GD7554@levanta.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(I'm new to lm-sensors stuff, so I might just be doing something stupid)

I'm trying to read the LM96000 device on an Intel SE7221BK1-E Server
Board.  sensors-detect doesn't see it.  From the datasheet it seems I
should find it at i2c address 0x2c, 0x2d, or 0x2e.  The board has an ICH6
SMbus interface.  I'm assuming the LM96000 should appear on the i2c bus
that provides, and that i2cdetect should at least see that there is
something at that address.  It doesn't though:

Modules loaded:  i2c_dev i2c_sensor i2c_i801 i2c_core

[root@localhost lm_sensors-2.9.1]# ./prog/detect/i2cdetect -l
i2c-0   unknown         SMBus I801 adapter at 0400       Algorithm unavailable

[root@localhost lm_sensors-2.9.1]# ./prog/detect/i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX 42 XX 44 XX XX XX XX XX XX XX XX XX XX XX 
50: 50 XX 52 XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: 60 XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX                         
[root@localhost lm_sensors-2.9.1]# 


Should I expect to see a 2c, 2d, or 2e in that output?  As I don't, what
does that mean?  Might it mean the chip is connected to some other i2c
bus I havn't found yet, or I need to do something else to enable it, or
what?  Might I have done something that made the chip invisible?

I assume I'm correct in thinking that as it doesn't show up in i2cdetect
output, there is no chance of the lm85 driver detecting it.

I also don't know what the i2c devices at 08, 42, 44, 60 and 69 are.
50 and 52 get picked up by the eeprom driver.

I'm running an FC3 2.6.10-1.766_FCsmp kernel atm, but I'm guessing
that wouldn't have an impact on i2cdetect output.

Any suggestions on how to access the LM96000 welcome.  The board
has a PC87427 too, and the motherboard doc suggests that has an "i2c
interface to LM96000 sensors", but I'm not sure I believe that;
the PC87427 has a SensorPath interface for talking to LMxx sensors, but
I don't think the LM96000 talks SensorPath.  The PC87427 has an SMbus
slave interface too, and I didn't see anything that looked like that in
the i2cdetect or i2cdump output either.

Thanks,
  Richard

