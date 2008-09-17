From: Marco Chiappero <marco@absence.it>
Date: Wed, 17 Sep 2008 20:27:54 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48D1684A.8030902@absence.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070000000409080008040505"
List-Id: <lm-sensors.vger.kernel.org>
References: <48CCB294.907@hhs.nl>
In-Reply-To: <48CCB294.907@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000000409080008040505
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Rudolf Marek ha scritto:
> Hello,

Hi Rudolf, good to read you.

> DHG chip is wired as follows:
>=20
> in0 is Vcore
> in1 is 12V
> in2 not used
> in3 is 3.3V
> in4 is 5V

Ok, maybe Stby +5V too?

> temp1 is MB temp
> fans are
> fan2 is cpu,
> fan5 is not, fan4 is not

Temp2 should be the CPU temp, fans1/fans4/fan5 should be cha1/cha2/cha3=20
headers. I have created a file listing all the things I know and I'm=20
able to manage with the w83627ehf driver. Take a look at:
http://www.absence.it/MIIF/sensors-output
http://www.absence.it/MIIF/w83667hg-report

> It measures:
> Cpu voltage, DDR voltage, SB 1.1V voltage SB 1.5V, CPU PLL voltage, NB=20
> 1.1V Dram VTT volrage, VTT CPU voltage,

Right, these are the voltages show by the external LCD, so it makes=20
sense to have these computed by another chip.

> So we need to find out what chip it is, because it measures a lot too.
>=20
> The NB temperature etc etc is measured by some chip at 0x40 it seems it=20
> also controls some fan temperature???

Don't know, since chassis1/2/3, CPU and Power Fan should be controlled=20
by the w83667hg while the opt1/2/3 should be controlled by another chip,=20
but can't say which one.

> Definitely what is the output of
>=20
> i2cdetect 0
> i2cdump 0 0x40
> i2cdump 0 0x38

Output attached!
You may also read these and previous attachments by brousing=20
http://www.absence.it/MIIF/

I have a question for you: are this probings harmless? Because I'm=20
starting to experience a strange issue, and maybe you guys can help me=20
to figure out why. But let me start from the beginning.
A few days ago, after many hours of uptime, the CPU temp (not the cores=20
one) suddenly jumped to 110=B0C. Obviously it was a false positive, but it =

caused the sensors chip to push all my fans to the maximum speed and I=20
had to reboot the computer to "solve" the problem. The day after exactly=20
the same issue in the same way. Then reboot. The following day a really=20
weird thing happened: suddenly many of the sensors of the board were no=20
more available. Look at this screenshot I caught in that moment:=20
http://www.absence.it/MIIF/errors.jpg
But this time after the OS closed all its stuff nor a reboot neither a=20
reset made the computer boot again, so I had to press the power button.=20
  A few hours later I have found a guy owning the same board and sharing=20
almost the same issue that told me that this happens when running more=20
than one sensors monitoring utility at time. It sounded strange to me=20
but I was indeed running a couple of programs in those days (I've never=20
used to do so before). Infact the day after the pc had no problems at=20
all running just one monitoring tool as usual. However today, after=20
using i2cdump for this attachment, I rebooted the computer to run these=20
dumps on a newer kernel and that's the result:=20
http://www.absence.it/MIIF/wrong-dumps
The same thing again! I rebooted but didn't work and I had to cut the=20
power again. Have you got any idea about why this could happen? Is it an=20
hardware (temporary?) fault or is it a software one? Or is it caused by=20
any software? Above this the board has proven to be rock solid, so I=20
don't know what to think: is the board defective? Is it normal?


Thank you again
Marco


--------------070000000409080008040505
Content-Type: text/plain;
 name="MIIF-i2c-dumps"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIIF-i2c-dumps"

root@etna:/usr/src# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: 30 -- 32 33 -- 35 -- -- 38 -- -- -- -- -- -- -- 
40: 40 -- -- -- 44 -- -- -- -- -- -- -- -- -- -- -- 
50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         
root@etna:/usr/src# i2cdump 0 0x38
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x38, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff 55 a0 55 74 72 55 3f ff ff ff 01 00 ff ff ff    .U?UtrU?...?....
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff 69 43 44 00 56 a1    ..........iCD.V?
90: 36 04 3e 08 64 04 dd 05 f8 05 5e 04 1c 04 5e 04    6?>?d?????^???^?
a0: e9 05 6f 03 ff 02 a5 02 ff ff ff ff 25 ff ff ff    ??o?.???....%...
b0: ff 08 00 07 23 00 00 00 20 ff ff ff ff ff ff ff    .?.?#... .......
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
root@etna:/usr/src# i2cdump 0 0x40
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x40, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff 00 00 00 82 ff ff ff ff ff    ..........?.....
10: ff 50 50 ff 5a 5a 5a ff ff ff ff ff ff ff ff ff    .PP.ZZZ.........
20: ff ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff 50 cc 29 00 56 ec    ..........P?).V?
90: 00 00 df 05 00 00 d3 02 ff ff ff ff ff ff ff ff    ..??..??........
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 24 2b 2c 23 20 1a 20 ff ff ff ff ff ff ff ff 00    $+,# ? .........
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

--------------070000000409080008040505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070000000409080008040505--
