From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Apr 2010 11:20:34 +0000
Subject: Re: [lm-sensors] some quesions from the tools
Message-Id: <20100428132034.29bc1dcf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <x2ifb0149a91004270957x1d302278v8eb017b718833a37@mail.gmail.com>
	<j2pfb0149a91004271029j45f6acf8k5c01039cf16b8fa6@mail.gmail.com>
In-Reply-To: <j2pfb0149a91004271029j45f6acf8k5c01039cf16b8fa6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lei yang <yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Lei,

Please avoid HTML posts to mailing lists.

On Wed, 28 Apr 2010 01:29:27 +0800, lei yang wrote:
> Hi Experts
> 
> 
> I'm new to i2c, I have some questions in the end, can you help me explain
> them to me

Please note that the lm-sensors list is not the most appropriate list
for i2c question. The linux-i2c list would be better, so I'm adding it
to Cc. The lm-sensors list can be dropped from further replies.

> root@mpc8313erdb:/root> sensors
> lm75-i2c-0-48
> Adapter: MPC adapter
> temp1:       +21.0?C  (high = +80.0?C, hyst = +75.0?C)
> root@mpc8313erdb:/root> ./i2cdetect -l
> i2c-0   i2c             MPC adapter                             I2C adapter
> i2c-1   i2c             MPC adapter                             I2C adapter
> root@mpc8313erdb:/root> ./i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- 0c -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> root@mpc8313erdb:/root> ./i2cdetect 1
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> root@mpc8313erdb:/root>
> 
> 
> Q1:use i2cdetect -l, I can see it detects i2c-0 and i2c-0 why "sensors"

I guess you mean "i2c-0 and i2c-1".

> comand just output lm75-i2c-0-48?

Both commands do completely different things and there is no reason for
their outputs to be correlated in any way.

i2cdetect lists I2C bus segments on your system, and then device
address which are found to be responsive or busy on these buses.

sensors lists the detected hardware monitoring devices. These can be
I2C devices, but they do not have to be.

You happen to have one LM75 thermal sensor chip on I2C bus segment
number 0 (i2c-0), so it shows in the output of both commands. But
running the same commands on a different system, you would have
different results.

> Q2:Use ./i2cdetect 0 it detect three adrees :0x48 0x50 0x68, i just know
> 0x48 is a temperature sensorshow do I know 0x50 and 0x68?

0x50 is most often an EEPROM (possibly one from a memory module, known
as SPD EEPROM, or from your screen, known as EDID EEPROM.)

0x68 is frequently used by clock chips.

> and from demsg |grep 68 I got
> 
> root@mpc8313erdb:/root> dmesg |grep 68
> On node 0 totalpages: 32768
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 125268k/131072k available (4072k kernel code, 5656k reserved, 140k
> data, 126k bss, 188k init)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
> rtc-ds1307 0-0068: setting system clock to 2010-04-27 23:41:40 UTC
> (1272411700)
> 
> so 0x68 is rtc device, i can't know 0x50 from demsg,can you show me the way

There is no driver bound to 0x50, so it's expected that you don't see
anything in dmesg. You could dump the contents of the device at address
0x50 with the following command:

i2cdump 0 0x50 b

If this is an SPD or EDID EEPROM, it will be easily recognizable.

> Q3:Why I got to i2c bus? but why it can't detect one address on bus 1 with
> ./i2cdetect 1?

Your system uses a 2-channel I2C controller, but apparently there is no
device connected to the second controller, so you can ignore it.

> Q4:I want to do a full test for the i2c driver of my board, is there some
> points about the test?

"the I2C driver" is vague. If you mean the I2C controller driver, which
would be i2c-mpc on your system, then you can indeed test it using
i2cdetect (which you already did), including the -F option, and
i2cdump/i2cget/i2cset. For an EEPROM, you can check that i2cdump modes
b, c, W and i all print the exact same output. Don't use i2cset on the
EEPROM, you might damage it.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
