From: mirage@kaotik.org (Tiago Sousa)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Ported lm80 to Linux 2.6
Message-Id: <Pine.LNX.4.58.0402171513280.3973@home.darksun.com.pt>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076403383.40289cb779c27@imp.gcu.info>
In-Reply-To: <1076403383.40289cb779c27@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, I've just installed lm_sensors2 from CVS. Here are the results:

On Thu, 12 Feb 2004, Jean Delvare wrote:
> Oh sorry I told you wrong. I really meant i2cdump, not i2cdetect. And
> unloading lm80 before dumping is suggested.

darksun:~# i2cdump 0 0x2d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 13 16 00 00 00 00 50 ad 45 00 40 00 00 00 00    ???....P?E.@....
10: 00 00 00 c5 0d ff 6d 87 00 00 00 00 00 ce c7 80    ...??.m?.....???
20: cf 95 91 15 cf c2 c5 7f 7f 9e 00 d2 a8 e7 bd e4    ??????????.?????
30: ba de b5 dc b4 ff ff ff ff ae a4 e1 e1 c7 c0 a2    ?????....???????
40: 01 00 00 00 00 00 00 50 ad 45 00 40 00 00 00 00    ?......P?E.@....
50: 00 00 00 80 7e ff e4 80 00 00 00 00 00 ce c7 80    ...?~.??.....???
60: cf 95 91 15 cf c2 c5 7f 7f 9e 00 d2 a8 e7 bd e4    ??????????.?????
70: ba de b5 dc b4 ff ff ff ff ae a4 e1 e1 c7 c0 a2    ?????....???????
80: 01 00 00 00 00 00 00 50 ad 45 00 40 00 00 00 00    ?......P?E.@....
90: 00 00 00 30 46 ff 59 81 00 00 00 00 00 ce c7 80    ...0F.Y?.....???
a0: cf 95 91 15 cf c2 c5 7f 7f 9e 00 d2 a8 e7 bd e4    ??????????.?????
b0: ba de b5 dc b4 ff ff ff ff ae a4 e1 e1 c7 c0 a2    ?????....???????
c0: 01 00 00 00 00 00 00 50 ad 45 00 40 00 00 00 00    ?......P?E.@....
d0: 00 00 00 80 7e ff ce 80 00 00 00 00 00 ce c7 80    ...?~.??.....???
e0: cf 95 91 15 cf c2 c5 7f 7f 9e 00 d2 a8 e7 bd e4    ??????????.?????
f0: ba de b5 dc b4 ff ff ff ff ae a4 e1 e1 c7 c0 a2    ?????....???????

> I have commited an update to sensors-detect to our CVS repository. I'd
> be interested in you trying it. It is supposed to refine the LM80
> detection procedure. I hope that it won't detect whatever-your-chip-is
> as an LM80 anymore.

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `via686a' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `VIA Technologies VT82C686 Integrated Sensors' (confidence: 9)

Indeed, it no longer detects LM80 nor any other in its place.
Does this mean that I have a non-identified sensor chip, or that it
doesn't exist at all? In any case, if you require further tests, I'll be
glad to help.

--
Tiago Sousa
