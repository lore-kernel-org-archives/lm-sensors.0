From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Date: Thu, 14 Oct 2010 06:44:15 +0000
Subject: Re: [lm-sensors] Detection of W83L771AWG/ASG in lm90
Message-Id: <201010140844.15452.alexander.stein@informatik.tu-chemnitz.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
In-Reply-To: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

On Wednesday 13 October 2010, 17:43:50 Jean Delvare wrote:
> On Wed, 13 Oct 2010 17:02:17 +0200, Alexander Stein wrote:
> > > Probing for `Winbond W83L771W/G'...                         Success!
> > > 
> > >     (confidence 6, driver `to-be-written')
> > > 
> > > Probing for `Winbond W83L771AWG/ASG'...                     No
> 
> Oh, I get it now. What the lm90 driver currently supports is the recent
> W83L771AWG/ASG. It doesn't have detection for the old W83L771W/G. In
> all honesty I wasn't sure if that one had ever been used in a public
> product, and its detection is somewhat weak, which is why I didn't add
> support (if I remember correctly, at least.)

It is from my motherboard, it's a ASRock ALiveNF6G-DVI.

> First thing to do is ensure this isn't a misdetection. Please send a
> dump of the chip:
> 
> # (install i2c-tools)
> # modprobe i2c-dev
> # i2cdump 0 0x4c b

Here is the output:
> # i2cdump 0 0x4c b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x4c, mode byte
> Continue? [Y/n] 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 21 1f 80 01 06 46 00 46 00 ff ff ff ff ff ff ff    !????F.F........
> 10: 20 00 00 00 00 ff ff ff ff 6e ff ff ff ff ff ff     ........n......
> 20: 55 0a ff ff ff ff ff ff ff ff ff ff ff ff ff ff    U?..............
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 06    ...............?
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: bb c0 82 bb c0 1f 21 24 82 ff ff 4b 06 ff ff ff    ??????!$?..K?...
> f0: ff 20 00 10 80 00 ff 00 00 02 00 50 4a 16 5c 01    . .??....?.PJ?\?

> If you really have that old chip then I'll add support to the lm90
> driver. Meanwhile you can force the lm90 driver to attach to it by
> using the following command:
> 
> # echo w83L771 0x4c > /sys/devices/i2c-0/new_device
> 
> (I hope the path is right for kernel 2.6.34 already.)

Nope, one possible path is /sys/bus/i2c/devices/i2c-0/new_device, but with the 
lower case name, as Guenter pointed out, it seems to work. Even with kernel 
module autoloading.

Thanks a lot you two so far. If you want some testing on chip detection, drop 
me a line.

Best regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
