From: =?ISO-8859-1?Q?Rune_Kj=E6r_Svendsen?= <runesvend@gmail.com>
Date: Fri, 07 Feb 2014 15:16:29 +0000
Subject: Re: [lm-sensors] Missing fan speed readout for ASUS M5A97 EVO R2.0 motherboard
Message-Id: <CAH2=CKzVA4FtLrLDve8fZf4r6vqFL9hO-xTLvq79Bbp8dJ4Oxw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
In-Reply-To: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean

Sorry about the formatting :) I've enabled plain text mode in Gmail
now (I hope that's sufficient).

I actually just updated the BIOS a couple of days ago, so everything
is up-to-date BIOS-wise.

Enabling fan5 gives the following values, unfortunately:

rune@rune-desktop:~$ cat /sys/class/hwmon/hwmon1/device/fan5_alarm
1
rune@rune-desktop:~$ cat /sys/class/hwmon/hwmon1/device/fan5_input
0
rune@rune-desktop:~$ cat /sys/class/hwmon/hwmon1/device/fan5_min
-1

Here's a register dump after setting the registers to enable fan5:

root@rune-desktop:~# isadump -y 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 19 40 b7 02 00 00 00 00 00 80 58 0f 27 3e 0d e5
10: 0c 6a 09 77 c7 00 00 00 04 03 03 fa 3d c3 c3 c3
20: e5 e7 72 86 39 cd 10 19 8a 2a 23 80 80 c3 ad ad
30: af 65 69 da 32 ee 92 6d 87 be 4a 1a 6f 00 0a 57
40: 6f f8 e7 68 63 85 5f 40 ad 6a d4 00 ff ff ff ff
50: 2f 18 7f 7f 7f 40 00 00 90 00 38 12 60 00 00 00
60: 80 00 7f 00 00 41 00 ff 7f 7f 7f 80 00 00 00 ff
70: 80 00 7f 81 00 41 00 ff ff ff ff ff ff ff ff ff
80: 00 00 ff ff 00 00 00 00 00 00 00 00 00 27 02 0f
90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff
a0: ee 0b 0b 0b 0b 0b 0b ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


Cheers!

/Rune


On Fri, Feb 7, 2014 at 9:33 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Rune,
>
> On Thu, 6 Feb 2014 18:25:43 +0100, Rune Kj=E6r Svendsen wrote:
>> Here you go:
>>
>> root@rune-desktop:~# rmmod it87 root@rune-desktop:~# rmmod it87 Error:
>> Module it87 is not currently loaded root@rune-desktop:~# isadump -k
>> 0x87,0x01,0x55,0x55 0x2e 0x2f 0x07 WARNING! Running this program can cau=
se
>> system crashes, data loss and worse! I will probe address register 0x2e =
and
>> data register 0x2f. Probing bank 7 using bank register 0x07. Continue?
>> [Y/n] 0 1 2 3 4 5 6 7 8 9 a b c d e f 00: 00 00 00 00 00 00 00 07 00 00 =
00
>> 00 00 00 00 00 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 20: 87
>> 21 03 00 00 80 98 09 c0 00 00 00 9f 00 00 00 30: 00 00 00 00 00 00 00 00=
 00
>> 00 00 00 00 00 00 00 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 60: 00 00 0f 40 00 00
>> 00 00 00 00 00 00 00 00 00 00 70: 00 00 00 00 00 04 00 00 00 00 00 00 00=
 00
>> 00 00 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90: 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 a0: 00 00 00 00 00 00 00 00 00 00 00=
 00
>> 00 00 00 00 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0: 01 88
>> 40 00 00 00 00 00 01 80 40 00 00 00 00 00 d0: 00 00 00 00 00 00 00 00 00=
 00
>> 00 00 00 00 00 00 e0: 00 00 00 00 00 00 00 00 00 27 27 27 c4 3e 3e 0c f0:
>> 00 00 00 00 00 00 00 00 00 00 00 00 fb 00 00 00 root@rune-desktop:~#
>> isadump 0x295 0x296 WARNING! Running this program can cause system crash=
es,
>> data loss and worse! I will probe address register 0x295 and data regist=
er
>> 0x296. Continue? [Y/n] 0 1 2 3 4 5 6 7 8 9 a b c d e f 00: 19 00 b7 02 00
>> 00 00 00 00 80 58 0f 07 38 c4 86 10: 0c 6a 09 77 c7 00 00 00 04 02 03 fa=
 3d
>> c3 c3 c3 20: e5 e7 73 86 39 cd 10 19 8a 29 22 80 80 f0 ad ad 30: af 65 69
>> da 32 ee 92 6d 87 be 4a 1a 6f 00 0a 57 40: 6f f8 e7 68 63 85 5f 40 ad 6a=
 d4
>> 00 ff ff ff ff 50: 2f 18 7f 7f 7f 40 00 00 90 00 38 12 60 00 00 00 60: 80
>> 00 7f 00 00 41 00 ff 7f 7f 7f 80 00 00 00 ff 70: 80 00 7f 8a 00 41 00 ff=
 ff
>> ff ff ff ff ff ff ff 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 d1 02 fc
>> 90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff a0: ee 0b 0b 0b 0b 0b
>> 0b ff ff ff ff ff ff ff ff ff b0: ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
>> ff ff c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff d0: ff ff ff ff
>> ff ff ff ff ff ff ff ff ff ff ff ff e0: ff ff ff ff ff ff ff ff ff ff ff=
 ff
>> ff ff ff ff f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>
>> Hope it helps.
>
> Hmm, next time, please disable HTML and line wrapping ;-)
>
> Anyway... Some register values are unexpected. The fan4 and fan5 input
> pins are shared with the second serial port (COM2) so you can't have
> both. As there is no COM2 on the Asus M5A97 EVO R2.0, I'd expect these
> shared pins to be set to the fan input mode, which according to the
> datasheet is the default. However 4 of the 6 COM2 pins are used for the
> COM2 function (one of which has fan4 input as its alternative
> function.) I'd expect that neither or all are set... Enabling only some
> of them makes no sense to me - even less so when the board has no COM2
> to start with.
>
> This could be a BIOS bug so I encourage you to check your BIOS version
> and see if Asus as an update available.
>
> At least the fan5 input is selected. However monitoring is disabled for
> that input, which is why the it87 driver does not provide any value for
> it. We could try enabling it and see if the it87 driver then provides a
> valid value for it.
>
> This would be done with the following commands:
> # rmmod it87
> # isaset 0x295 0x296 0x0c 0x27
> # modprobe it87
>
> After that you should see fan5. It may or may not display a proper
> value.
>
> --
> Jean Delvare
> http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
