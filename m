From: jason.roscoe@gmail.com (Jason Roscoe)
Date: Tue, 21 Mar 2006 20:27:38 +0000
Subject: [lm-sensors] lm85 occasional bad data ticket 2038
Message-Id: <20060321202738.GA18336@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Issue 2038 was put on the backburner for awhile, but I am now looking into it
again.  I have done what Khali suggested as far as running i2cdetect and
i2cdump.  I have some results that may or may not be normal and I was hoping
someone could help me.  The hardware is the same, Radisys LS855 motherboard.  I
have lm_sensors 2.9.2 with libsensors 2.9.2 now.  The linux kernel version is
2.4.31.

The *new* problem, which I assume is related to the previous one mentioned in
ticket 2038 is described here.  Assume the system has just booted.

# lsmod
Module                  Size  Used by    Not tainted
i2c-dev                 3808   0  (unused)
e1000                  67564   0  (unused)
e100                   47832   1
rtc                     6012   0  (autoclean)
eeprom                  3656   0  (unused)
lm85                   17032   0  (unused)
i2c-proc                6020   0  [eeprom lm85]
i2c-i801                4632   0  (unused)
i2c-core               14852   0  [i2c-dev eeprom lm85 i2c-proc i2c-i801]
apm                     9096   1

If I run i2cdetect, I get the following output:

# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
	 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
	 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX
	 30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
	 50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
	 70: XX XX XX XX XX XX XX XX

From what I understand, this means that there are I2C devices at the following
addresses: 

0x08 0x2e 0x30 0x44 0x50 0x69

I seem to be able to run i2cdump for all of these addresses except 0x69, which
from what I gathered from the I2C tools page
(http://netroedge.com/~lm78/i2ctools.html) seems to be a clock chip.

Here is the output I get for this address.
# i2cdump -y 0 0x69 b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
	 00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
	 10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
	 20: 0f 1f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
	 30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
	 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

Basically, the first 4 lines of output are output as normal with a slight delay
between echos, but then there is a short pause, and the rest of the lines are
output immediately with no delay.  Subsequent i2cdump commands generate the
following output immediately (no delay like before for the first 4 lines).

# i2cdump -y 0 0x69 b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
	 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
	 f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

I am assuming that I am hosing some hardware registers each time I try to dump
this clock chip.  Maybe I shouldn't be trying to do that??  I'm not exactly
sure.  The i2cdumps behave the same way until I reboot the system.  I've tried
removing the modules from the kernel and then installing them again, but the
problem? remains.

Furthermore, subsequent i2cdetect commands give the following output:
# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
	 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
	 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX
	 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
	 70: XX XX XX XX XX XX XX XX

Which shows that I don't have the same addresses as before.

Thanks for any suggestions.

-Jason

