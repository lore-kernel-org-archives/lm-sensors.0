From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 12:39:59 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080504143959.65609ff8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Achim,

On Sun, 04 May 2008 14:03:32 +0200, achim wrote:
> Am Sonntag, den 04.05.2008, 13:42 +0200 schrieb achim:
> > Am Sonntag, den 04.05.2008, 09:41 +0200 schrieb Jean Delvare:
> > > Hi Achim,
> > > 
> > > On Sun, 04 May 2008 01:24:19 +0200, Achim Gottinger wrote:
> > > > I took a picture of the board and numbered the chips.
> > > > http://www.abload.de/image.php?img=img_6532l9j.jpg
> > > > 
> > > > Chip 1-2 are the two NIC chips. Chip three is interesting.
> > > > It was hard to read but i found that chip ICS9LPRS477BKL
> > > > 
> > > > I found that article later explaining that chip as an clock generator.
> > > > http://www.planet3dnow.de/vbulletin/showthread.php?t30028&garpg=6
> > > > 
> > > > Here are specs for a chip with an very similar number which is a clock 
> > > > generator chip.
> > > > http://www.idt.com/?genID=9LPRS478
> > > 
> > > There's also this one:
> > > http://www.idt.com/?genID=9LPRS471
> > > 
> > > Maybe you misread the last 1 as a 7?
> >
> > I misread nearly all characters in the first place ~0.5 mm text height
> > is adveturous reading. Panet3dNow made a very clear picture of the chip
> > I already posted a link to their webpage.

Ah, sorry, I missed that. OK, the picture really says 9LPRS477BKL. Odd
that there is no reference to this on the IDT website. Rudolf, can you
please try to get information about this chip? If you can also get
information about the '471 and '478 models, that would be great too.

> > 9LPRS471 and 9LPRS478 where clock generator chips for the 690G chipset.
> > Googling for 9LPRS478 shows a link to the IDT page where you can
> > download a datasheet.

I already tried this, unfortunately the link is apparently to a
datasheet for a different chip (ICS951464). I can tell it's not the
same chip because the 9LPRS478 is in a VFQFPN 72 package (square, with
pins on 4 sides) while the 951464 is rectangular with pins on 2 sides.

> > Fortunately I have such a board here.
> > 
> > i2cdetect -l shows the PIIX4 adapter
> > i2cdetect 0 shows there is someting at 0x50,0x51 and 0x69

0x69 is the address of the ICS951464 according to the datasheet.

> > none of those adddresses can be dumped. I Tried each one after a cold
> > start, because as you expected this was required on the sapphire board
> > to get the dump work again.

Hmmm, that's strange. 0x50 and 0x51 are your memory module SPD EEPROMs,
they should be dumpable. For 0x69 you should use the "s" mode of
i2cdump.

> > 
> > I also have an Gigabyte 780G board and an Asus M3A board (770 chipset)
> > here.
> > ﻿
> > The gigabyte has an 9LPRS477CKL chip and the M3A uses also the
> > 9LPRS477BKL. 
> > 
> > 780G 
> > ﻿i2cdetect -l shows the PIIX4 adapter
> > i2cdetect 0 shows there is someting at 0x50,0x51,0x52,0x53, 0x38,0x69
> > 
> > I attached the dumps of 0x38 and 0x69 to that mail.
> > 
> M3A-770
> ﻿﻿i2cdetect -l shows the PIIX4 adapter
> i2cdetect 0 shows there is someting at 0x52,0x53, 0x38,0x69
> 
> ﻿I attached the dumps of 0x38 and 0x69 to that mail.
> 
> PS: Also added the dumps of the gbt board i forgott in the last mail.
> I'll try to modify a few frequencies and compare the dumps of 0x38 and
> 0x69 now.

No idea what is the chip at 0x38. At 0x69 it's usually clock chips.

Note that sensors-detect (at least recent versions thereof) doesn't
probe address 0x38 nor 0x69, as there are no known hardware monitoring
chips using these addresses.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
