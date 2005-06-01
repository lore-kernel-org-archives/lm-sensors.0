From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Wed, 01 Jun 2005 20:37:48 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4] PCA9539 - new driver
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076BD45@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,

Thank you for your feedback.

<clip>
> > +	/* Detection: not sure how to do that... 
> > +	 * possibility: toggle the value read from invert0 and see if
input0
> > +	 * changes polarity.
> > +	 */
> 
> I can try to help you with this a bit.
> Please can you use i2cdump to dump chip registers?
<clip>

Here's the i2cdump output. 
The device only supports 8 registers (0-7), so the output isn't too
surprising.

AFAIK, this device isn't likely to be on any common motherboard.
Perhaps detection isn't necessary?

Thanks,
Ben 

~ # i2cdump
Error: No i2c-bus specified!
Syntax: i2cdump [-y] I2CBUS ADDRESS [MODE] [BANK [BANKREG]]
        i2cdump -V
  MODE is 'b[yte]', 'w[ord]', 's[mbusblock], 'i[2cblock]',
       or 'c[onsecutive byte address mode]' (default b)
  Append MODE with 'p' for PEC checking
  I2CBUS is an integer
  ADDRESS is an integer 0x00 - 0x7f
  BANK and BANKREG are for byte and word accesses (default bank 0, reg
0x4e)
  BANK is the command for smbusblock accesses (default 0)
  Installed I2C busses:
    i2c-0       unknown         CS5535 SMB0
Algorithm unavailable
~ # ls /sys/devices/platform/i2c-0/0-0074/
bus           config1       driver        input1        invert1
output0
config0       detach_state  input0        invert0       name
output1
~ # i2cdump 0 0x74
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c/0, address 0x74, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 ff ff ff 00 00 ff ff XX XX XX XX XX XX XX XX    ........XXXXXXXX
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
~ #

