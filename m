From: albert@axcom.nl (Albert Kaan)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: lm_sensors
Message-Id: <200303071052.h27AqUq24538@axcomweb.axcom.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm trying to get lm_sensors version 2.7.0 up and running with a Gigabyte GA-8LD533 board.

This board is equiped with a Intel PCH4 chip which is a ITE8712F-A connected to the Intel PCH4 (according to the manual) however it's not found by sensors-detect. Any clues?

This is the output from sensors-detect:

Next adapter: SMBus I801 adapter at 5000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x30
Client found at address 0x44
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x69

A isadump report this
[root@localhost root]# isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 13 10 00 00 37 ff 00 37 ff 07 0d 5b 5b 4c ff ff
10: ff ff ff 50 00 00 00 00 00 00 00 00 00 00 00 00
20: 5d 5b d0 c0 af 62 b3 b7 ff 19 c9 12 12 12 12 12
30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
40: 7f 7f 7f 7f 3c 7f ff ff 2d ff ff ff ff ff ff ff
50: ff 1c 7f 7f 3c ff ff ff 90 5c fb 12 55 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff
80: 13 10 00 00 37 ff 00 37 ff 07 0d 5b 5b 4c ff ff
90: ff ff ff 50 00 00 00 00 00 00 00 00 00 00 00 00
a0: 5d 5b d0 c0 af 62 b3 b7 ff 19 c9 12 12 12 12 12
b0: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
c0: 7f 7f 7f 7f 3c 7f ff ff 2d ff ff ff ff ff ff ff
d0: ff 1c 7f 7f 3c ff ff ff 90 5c fb 12 55 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff
[root@localhost root]#

Thanks for your help.

Best regards,

Albert Kaan
