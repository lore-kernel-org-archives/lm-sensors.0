From: =?ISO-8859-1?Q?Rune_Kj=E6r_Svendsen?= <runesvend@gmail.com>
Date: Thu, 06 Feb 2014 17:25:43 +0000
Subject: Re: [lm-sensors] Missing fan speed readout for ASUS M5A97 EVO R2.0 motherboard
Message-Id: <CAH2=CKxf=bxByOgjbC8um=wu1if-Yj6xeY38znvdcfQan2cPig@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
In-Reply-To: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean

Here you go:

root@rune-desktop:~# rmmod it87 root@rune-desktop:~# rmmod it87 Error:
Module it87 is not currently loaded root@rune-desktop:~# isadump -k
0x87,0x01,0x55,0x55 0x2e 0x2f 0x07 WARNING! Running this program can cause
system crashes, data loss and worse! I will probe address register 0x2e and
data register 0x2f. Probing bank 7 using bank register 0x07. Continue?
[Y/n] 0 1 2 3 4 5 6 7 8 9 a b c d e f 00: 00 00 00 00 00 00 00 07 00 00 00
00 00 00 00 00 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 20: 87
21 03 00 00 80 98 09 c0 00 00 00 9f 00 00 00 30: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 60: 00 00 0f 40 00 00
00 00 00 00 00 00 00 00 00 00 70: 00 00 00 00 00 04 00 00 00 00 00 00 00 00
00 00 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90: 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 a0: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0: 01 88
40 00 00 00 00 00 01 80 40 00 00 00 00 00 d0: 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 e0: 00 00 00 00 00 00 00 00 00 27 27 27 c4 3e 3e 0c f0:
00 00 00 00 00 00 00 00 00 00 00 00 fb 00 00 00 root@rune-desktop:~#
isadump 0x295 0x296 WARNING! Running this program can cause system crashes,
data loss and worse! I will probe address register 0x295 and data register
0x296. Continue? [Y/n] 0 1 2 3 4 5 6 7 8 9 a b c d e f 00: 19 00 b7 02 00
00 00 00 00 80 58 0f 07 38 c4 86 10: 0c 6a 09 77 c7 00 00 00 04 02 03 fa 3d
c3 c3 c3 20: e5 e7 73 86 39 cd 10 19 8a 29 22 80 80 f0 ad ad 30: af 65 69
da 32 ee 92 6d 87 be 4a 1a 6f 00 0a 57 40: 6f f8 e7 68 63 85 5f 40 ad 6a d4
00 ff ff ff ff 50: 2f 18 7f 7f 7f 40 00 00 90 00 38 12 60 00 00 00 60: 80
00 7f 00 00 41 00 ff 7f 7f 7f 80 00 00 00 ff 70: 80 00 7f 8a 00 41 00 ff ff
ff ff ff ff ff ff ff 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 d1 02 fc
90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff a0: ee 0b 0b 0b 0b 0b
0b ff ff ff ff ff ff ff ff ff b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff d0: ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff e0: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Hope it helps.

Cheers!

/Rune


On Thu, Feb 6, 2014 at 5:53 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Rune,
>
> On Thu, 6 Feb 2014 15:54:33 +0100, Rune Kj=E6r Svendsen wrote:
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >
> > Driver `it87':
> >   * ISA bus, address 0x290
> >  Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)
> >
> > Driver `fam15h_power' (autoloaded):
> >   * Chip `AMD Family 15h power sensors' (confidence: 9)
> >
> > Driver `k10temp' (autoloaded):
> >   * Chip `AMD Family 15h thermal sensors' (confidence: 9)
>
> This pretty much rules out the theory of a second hardware monitoring
> device to which the last fan would be connected.
>
> > (...)
> > [   16.382872] it87: Found IT8721F chip at 0x290, revision 3
>
> I took a look at the datasheet for this chip and could not find
> anything wrong with the driver.
>
> However, if you provide a few register dumps, I can double check if the
> chip is in an unexpected state.
>
> # rmmod it87
> # isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 0x07
> # isadump 0x295 0x296
> # modprobe it87
>
> With these two register dumps I should be able to check if fan4_input
> is supposed to be enabled or disabled.
>
> --
> Jean Delvare
> http://jdelvare.nerim.net/wishlist.html
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
