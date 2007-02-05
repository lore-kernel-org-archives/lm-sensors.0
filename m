From: mailinglist@welzien.se (Peter Welzien)
Date: Mon, 05 Feb 2007 19:39:24 +0000
Subject: [lm-sensors] sensors-detect hangs while scaning PIIX4
Message-Id: <61402.85.231.160.112.1170704364.squirrel@oden.welzien.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
In-Reply-To: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>> Since my last message doesn't seem to have reached the list, I send
>>> another one.
>
>> Yeah, that's what happens when you reply to me only ;)
>
> I'm sorry about that. I didn't notice that the reply-to wasn't set to the
> list.
>
>>> I didn't pass any parameters to the module. When it loads the only
>>> message in the log is a line saying that the module is loaded and an
>>> address. I don't have access to the computer right now, but I can get
>>> the exact message tonight if you need it.
>
>> It might help, yes. Please make sure there is no complaint about an
>> "illegal interrupt configuration". Please also provide a dump of the
>> PCI config registers of the device. You can obtain such a dump using
>> "lspci -xxx".
>
> dmesg says:
> piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
>
> lspci -xxx:
> 00:00.0 Host bridge: Broadcom CNB20LE Host Bridge (rev 06)
> 00: 66 11 09 00 06 01 00 62 06 00 00 06 08 40 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 04 06 80 14 00 eb 00 00 00 4b
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 80 2a 00 af c0 0f ff 1f 01 1e 81 00 44 44 44 44
> 80: 00 20 00 00 20 40 00 00 40 60 00 00 60 80 00 00
> 90: 55 0a 29 10 0d 4f fe 44 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: fb e6 dc 6f fe ac 1b be b8 7d fb ff ff fd f3 ff
> c0: 20 fc af fe 00 fc 0f fc 00 04 00 00 0d 07 00 48
> d0: 00 b0 fc df 00 10 00 00 00 00 00 00 01 80 10 93
> e0: 04 00 00 2b 00 00 00 00 b2 00 00 00 00 00 00 00
> f0: 00 00 00 40 00 00 00 00 00 00 00 00 60 01 00 00
>
> 00:00.1 Host bridge: Broadcom CNB20LE Host Bridge (rev 06)
> 00: 66 11 09 00 07 00 00 02 06 00 00 06 08 10 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 01 01 04 00 00 00 00 0b 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: b0 fe bf fe 10 fc 1f fc 00 00 00 00 0d 07 00 00
> d0: 00 e0 fc ef 00 00 00 00 00 00 00 00 01 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 08 00 00 00 00 00 00 00 00 61 01 00 00
>
> 00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 50)
> 00: 66 11 00 02 07 00 00 02 50 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 00 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: f0 33 00 00 00 00 00 00 07 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 01 00 00 00 0f c1 20 00 00 00 00 00 00 00 00 00
> 70: 01 40 08 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 81 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> (I've deleted the NICs, graphics card, IDE and USB-bus)
>
>> Then we need to figure out what exactly is locking your system. As I
>> asked before, please try i2cdetect on the SMBus (typically "i2cdetect
>> 0") and see if it locks too. You may additionally try "i2cdetect -r 0"
>> and "i2cdetect -q 0". If these commands lock your system, note how much
>> is written on your screen each time before the system locks.
>
> i2cdetect 0:
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c/0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> [locks up]
>
> i2cdetect -r 0:
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c/0 using read byte commands.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> [locks up]
>
> i2cdetect -q 0:
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c/0 using quick write commands.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> [locks up]
>
> I did also try i2cdetect -l with following result:
> i2c-0   smbus           SMBus PIIX4 adapter at 0580             Non-I2C
> SMBus adapter
>
> --
> /Peter Welzien
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

Does anybody have a clue what might be wrong? Or anything else that I can
try?

-- 
/Peter Welzien

