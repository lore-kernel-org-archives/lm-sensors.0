From: achim <achim@ag-web.biz>
Date: Sun, 04 May 2008 11:42:57 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209901377.3575.21.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Am Sonntag, den 04.05.2008, 09:41 +0200 schrieb Jean Delvare:
> Hi Achim,
> 
> On Sun, 04 May 2008 01:24:19 +0200, Achim Gottinger wrote:
> > I took a picture of the board and numbered the chips.
> > http://www.abload.de/image.php?img=img_6532l9j.jpg
> > 
> > Chip 1-2 are the two NIC chips. Chip three is interesting.
> > It was hard to read but i found that chip ICS9LPRS477BKL
> > 
> > I found that article later explaining that chip as an clock generator.
> > http://www.planet3dnow.de/vbulletin/showthread.php?t30028&garpg=6
> > 
> > Here are specs for a chip with an very similar number which is a clock 
> > generator chip.
> > http://www.idt.com/?genID=9LPRS478
> 
> There's also this one:
> http://www.idt.com/?genID=9LPRS471
> 
> Maybe you misread the last 1 as a 7?
I misread nearly all characters in the first place ~0.5 mm text height
is adveturous reading. Panet3dNow made a very clear picture of the chip
I already posted a link to their webpage.

9LPRS471 and 9LPRS478 where clock generator chips for the 690G chipset.
Googling for 9LPRS478 shows a link to the IDT page where you can
download a datasheet. Fortunately I have such a board here.

i2cdetect -l shows the PIIX4 adapter
i2cdetect 0 shows there is someting at 0x50,0x51 and 0x69
none of those adddresses can be dumped. I Tried each one after a cold
start, because as you expected this was required on the sapphire board
to get the dump work again.

I also have an Gigabyte 780G board and an Asus M3A board (770 chipset)
here.
﻿
The gigabyte has an 9LPRS477CKL chip and the M3A uses also the
9LPRS477BKL. 

780G 
﻿i2cdetect -l shows the PIIX4 adapter
i2cdetect 0 shows there is someting at 0x50,0x51,0x52,0x53, 0x38,0x69

I attached the dumps of 0x38 and 0x69 to that mail.

> 
> Both chips have an SMBus interface so most certainly at least one of
> the addresses of i2cdetect corresponds to this chip. We'd need a
> datasheet but it doesn't seem to be available for download :(
> 
> > 
> > Chip four is something like ICS 7714084.
> 
> Couldn't find anything about this one.
Same here but this chips is also very hard to read and the numbers might
be similar looking characters like those i noted.

BTW: Both DFI Lanparty boards have a feature in common "CPU Overheat
Protection function monitors CPU temperature during system boot-up"

Can be they use an separate chip for that, that is located below the
chipset heatpipes.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
