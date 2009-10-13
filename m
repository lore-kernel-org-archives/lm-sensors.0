From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Oct 2009 07:20:53 +0000
Subject: Re: [lm-sensors] "Dummy" sensor driver?
Message-Id: <20091013092053.1f53eb82@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/6mWum7H8CX/A0U30EyGaGBb"
List-Id: <lm-sensors.vger.kernel.org>
References: <hb011f$2p0$1@ger.gmane.org>
In-Reply-To: <hb011f$2p0$1@ger.gmane.org>
To: lm-sensors@vger.kernel.org

--MP_/6mWum7H8CX/A0U30EyGaGBb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good morning Ian,

On Mon, 12 Oct 2009 16:43:25 -0500, Ian Pilcher wrote:
> On 10/12/2009 03:52 PM, Jean Delvare wrote:
> > For example this works very well with the lm90 driver. If you want
> > dumps from lm90-compatible chips, just let me know and I'll send them
> > to you. This should also works reasonably well with most National
> > Semiconductor and Analog Device chips. Just Winbond chips don't work
> > well because they use banks and i2c-stub doesn't have support for that.
> 
> Please do send them.  My desktop system has a Winbond chip, so a dump
> from it presumably wouldn't do any good.

Please find attached:
* A dump of an ADM1025 chip, to be used with the adm1025 hwmon driver.
  Emulate at I2C address 0x2c, 0x2d or 0x2e.
* A dump of an ADM1032 chip, to be used with the lm90 hwmon driver.
  Emulate at I2C address 0x4c.
* A dump of an EMC6D102 chip, to be used with the lm85 hwmon driver.
  Emulate at I2C address 0x2c, 0x2d or 0x2e.

I have dumps of many other chips if you need to test a specific case.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

--MP_/6mWum7H8CX/A0U30EyGaGBb
Content-Type: text/plain; name=adm1025.dump
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=adm1025.dump

After modprobe i2c-dev

No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
10: 5b 5b 5b 5b 5b 00 5b 5b 5b 5b 5b 5b 5b 5b 5b 00    [[[[[.[[[[[[[[[.
20: c0 7d c6 c1 c2 c6 23 21 5b 5b 5b d3 ad 84 78 d3    ?}????#![[[???x?
30: ad d3 ad d3 ad d3 ad 3c 0a 2d 0a 5b 5b 5b 41 29    ???????<?-?[[[A)
40: 09 00 00 5b 5b 5b 5b 0c 5b 80 5b 5b 5b 5b 5b 5b    ?..[[[[?[?[[[[[[
50: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
60: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
70: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
80: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
90: 5b 5b 5b 5b 5b 00 5b 5b 5b 5b 5b 5b 5b 5b 5b 00    [[[[[.[[[[[[[[[.
a0: c0 7d c6 c1 c2 c6 23 21 5b 5b 5b d3 ad 84 78 d3    ?}????#![[[???x?
b0: ad d3 ad d3 ad d3 ad 3c 0a 2d 0a 5b 5b 5b 41 29    ???????<?-?[[[A)
c0: 09 00 00 5b 5b 5b 5b 0c 5b 80 5b 5b 5b 5b 5b 5b    ?..[[[[?[?[[[[[[
d0: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
e0: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
f0: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[


---------------------------------------------
Output from sensors command line
(using changed sensors.conf)

adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0
+2.5V:     +2.50 V  (min =  +2.25 V, max =  +2.75 V)   
VCore:     +1.48 V  (min =  +1.41 V, max =  +1.55 V)   
+3.3V:     +3.40 V  (min =  +2.97 V, max =  +3.63 V)   
+5V:       +5.03 V  (min =  +4.50 V, max =  +5.50 V)   
+12V:     +12.19 V  (min = +10.81 V, max = +13.19 V)   
VCC:       +3.40 V  (min =  +2.97 V, max =  +3.63 V)   
CPU Temp:  +39.0 C  (low  =   +10 C, high =   +60 C)   
M/B Temp:  +38.0 C  (low  =   +10 C, high =   +45 C)   
vid:      +1.475 V

--MP_/6mWum7H8CX/A0U30EyGaGBb
Content-Type: text/plain; name=adm1032.dump
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=adm1032.dump

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 18 19 80 00 08 55 00 55 00 00 08 55 00 55 00 00    ???.?U.U..?U.U..
10: 00 00 00 00 00 80 80 00 00 55 00 00 00 00 00 00    .....??..U......
20: 55 0a 01 00 00 00 00 00 00 e3 00 00 00 00 00 00    U??......?......
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41 42    ..............AB

--MP_/6mWum7H8CX/A0U30EyGaGBb
Content-Type: text/plain; name=emc6d102.dump
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=emc6d102.dump

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 71 80 c4 c4 c2 1b 19 1c a4 07 ff ff 1b 09 ab 07    q?????????..????
30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 65    ..............\e
40: 05 00 00 0d 6d 79 7c 89 b6 ca b6 ca b6 ca 0a 37    ?..?my|????????7
50: 0a 2d 0a 2d 8c 0a ff ff ff ff ff ff 62 62 62 c0    ?-?-??......bbb?
60: 70 70 20 00 80 80 4d 1f 23 23 3f 2d 2d 44 40 00    pp .??M?##?--D@.
70: ff ff ff 09 09 09 09 09 09 00 30 00 40 00 ec 18    ...??????.0.@.??
80: 1e a4 0e 00 00 3b 50 44 58 00 4d 4d 09 09 0a 00    ???..;PDX.MM???.
90: 04 04 04 04 0c 0c 0c 5a f1 00 00 00 00 00 00 00    ???????Z?.......
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12    ...............?

--MP_/6mWum7H8CX/A0U30EyGaGBb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/6mWum7H8CX/A0U30EyGaGBb--
