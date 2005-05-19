From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: TP EEPROM corruption in Linux
Message-Id: <20020721164017.F11600@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hey Joe, I found your site and newsgroup postings while doing a little
research on a EEPROM corruption problem we're trying to solve under
Linux with the Lm_sensors project.

What seems to be happening is that users of these Thinkpad models are 
getting CRC errors on boot, or a 'RFID serialization' error:

ThinkPad 770X
ThinkPad 600E
ThinkPad 770Z
ThinkPad 600X
ThinkPad 240
ThinkPad X20
ThinkPad 570E

I've got two questions which I'm trying to answer which you might be 
able to help me with?

- Do all of these Thinkpad models listed above use a common EEPROM 
chip? (e.g. an Atmel 24RF08)

- Does the 24RF08 respond unfavorably to I2C 'quick' commands?  I.e., 
commands which stop after the first I2C byte (the address with r/w 
bit).

Our detection script tries to find all I2C busses and then all devices
on those busses using the I2C 'quick' command.  It then tries to
suggest which drivers to use for the platform.  It seems that after 
detection and at the next reboot, the computer reports the errors I 
mentioned above.  We're trying to figure out a way to avoid the 
possibility of this kind of corruption in the future.

Thanks for any help you can provide!


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
