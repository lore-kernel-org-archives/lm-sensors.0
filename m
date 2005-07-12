From: david-b@pacbell.net (David Brownell)
Date: Tue, 12 Jul 2005 02:38:00 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <200507111737.11097.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I ran into one too many board with an I2C EEPROM that Linux handled poorly,
and got a hack attack.  Here's the result ... tested on at24c04 but it
should work on most other chips in the at24c series without much effort.
(Including on the at24c1024, 1 MBit of EEPROM... more than enough to
hold say "u-Boot", along with product config data.)

If someone wants to pick this up and do things with this, feel free; there's
an obvious gap in how it initializes, since these chips can't very usefully
be probed.  I have no current plans to submit this, but feel free to fling
patches my way.

This is modeled more or less after "eeprom" but of course it handles not
only read/write access, but also chips with more than 2 Kbits of storage.
So there's the notion that on some systems it might replace "eeprom".

- Dave

 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: at24c.patch
Type: text/x-diff
Size: 14851 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050711/10f5b0bc/at24c.bin
