From: mirage@kaotik.org (Tiago Sousa)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Ported lm80 to Linux 2.6
Message-Id: <Pine.LNX.4.58.0402121538050.4520@home.darksun.com.pt>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076403383.40289cb779c27@imp.gcu.info>
In-Reply-To: <1076403383.40289cb779c27@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the delay but I've been rather busy, and I'll be out for the
weekend too.

On Tue, 10 Feb 2004, Jean Delvare wrote:
> Oh, I forgot a question: which motherboard do you have?

An MSI K7T Turbo Socket-A KT133A ATX.

> I think I remember that
> the LM80 is a hard to detect chip, so I wouldn't be surprised at all if
> what you have is *not* an LM80 but something else. If you want us to
> take a look, please provide the output of "i2cdetect 1 0x2d" (where 1
> is the bus number and 0x2d the address of the LM80; adapt values to
> your case).

relevant sensors-detect output:

Driver `lm80' (should be inserted):
  Detects correctly:
  * Bus SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver   2c-viapro', I2C address 0x2d
    Chip National Semiconductor LM80' (confidence: 3)

i2cdetect:

darksun:~# i2cdetect 0 0x2d
WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

I'm not too concerned with the LM80 chip because via686a has the info I
really need.

Also, as stated in the 2.6 kernel information on the lm_sensors site, the
via686a and i2c-viapro don't work together, so I've been using
only i2c-isa with via686a, and not i2c-viapro with lm80 too. Just pointed
this out, in case it makes a difference to the detection process
(probably not because LM80 is also detected in kernel 2.4).

Have a nice weekend folks :)
Tiago Sousa
