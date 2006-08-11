From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 11 Aug 2006 07:47:48 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <20060811094748.f1e7fd34.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> > Hans, see why I was reluctant to having your driver in the kernel tree?
> > Nothing personal, but that kind of problem is to be expected when
> > writing a driver without a datasheet :(
>
> This would / could have happened with a datasheet too, its a combination
> of a buggy chip (the uguru) which is a pain to work with (it would be
> even with a datasheet) and a bug in my driver.

I believe this is less likely to happen when a chip has a datasheet.
Reasons for this are:
1* A public datasheet means more people can work on the driver, so bugs
are more likely to be caught early.
2* A public datasheet means the manufacturer is ashamed to make buggy
hardware or firmware and pays more attention (in the long run, of
course.)

It is my experience that the availability and quality of technical
documentation comes with well designed hardware.

> Things are not as bad as they look, the driver did not corrupt the BIOS,
> nor the CMOS ram. For some strange reason (design probably) the Abit
> uGuru motherboards BIOS saves the uguru settings to CMOS on successfull
> (ACPI) poweroff. So all the driver did was write the uGuru register it
> was designed to write, its not writing over random memory.

OK.

> Also notice that the BIOS is also being buggy in this case, because it
> hangs because of a single invalid byte in the uguru's settings, whereas
> it should just be checking the relevant bits and ignoring the irrelevant
> ones.

Yeah, this is quite common that BIOS assume lots of things where it
shouldn't. But users want their machines to just work when they use our
drivers, so we must keep the BIOS happy.

> Sergey also correctly points out that this code is writing the uguru
> todo the probing and that this is not ideal, unfortunatly, I cannot
> think of another way.

Same goes for all legacy ISA hardware monitoring chips, and to a lesser
extent for Super-I/O chips. We try to limit the writes to be as safe as
possible, and nobody ever reported a problem with that so far.

> I do not believe this bug will reoccur, not with sunil's new and
> improved timeout handling, which make the chance of actually getting a
> timeout error pretty small, combine this with the always restoring the
> settings on an error, instead of the current buggy behaviour and
> retrying this restore in case of a write failure (due to those same
> timeouts, which are pretty rare now), the total chance of this happening
> again is very small. And even if it happens a CMOS reset is enough, most
> likely load setup defaults is enough, that fixed a similar issue for me
> when I completly trashed the uguru during driver development (I was
> probing random uguru bank addresses, which the uguru did not like).
> 
> To make really really sure we never get bitten by this I've added code
> to the sensors detect code, to mask out any invalid bits from the
> original settings byte before restoring it to the uguru.

Great, thanks.

(As a side note, our sensors-detect script still doesn't know about the
uGuru. Don't you want to add support for it? Or is it just too
dangerous because of the non-standard I/O addresses?)

-- 
Jean Delvare

