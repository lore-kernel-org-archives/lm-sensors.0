From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <NrrGrp6k.1108976823.1208530.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip,

> > It is very common that datasheets will document the lowest possible
> > revision/stepping for a chip, leaving it up to us to decide which range
> > we want to accept. This is what I proposed (and committed), based on
> > both the ADM1027 (rev.A) and the ADT7463 (rev.B) datasheets.
>
> OK.  I haven't seen a range of revisions documented in a datasheet, but
> I believe that you've read more datasheets than I have.

An example of this can be read in the LM90 datasheet:

"2.13 DIE REVISION CODE REGISTER

(Read Address FFh) Default value 21h. This register will increment by 1
every time there is a revision to the die by National Semiconductor."

I think I remember reading the same on the LM86, LM89 and LM99 datasheets.

On other datasheets, no revision is mentioned at all, so we have little
choice but to rely on chip dumps or ask the manufacturer directly for
hints (the LM83 and ADM1032 fall into that category). On yet other
datasheets, one part (typically the high nibble) of the revision is
given and the rest isn't (the ADM1025 falls into that category).

So there are obviously different cases, which must be dealt with
appropriately.

> > How exactly is it safer? I obviously don't know the LM85 and compatibles
> > family as good as you do, but I don't see what risk we have here. The
> > worst that could happen would be that we think the chip has feature it
> > doesn't actually have, right? These features will just not work, and
> > users will report about it.
>
> Or the register bits could have changed in a non-backward compatible
> way.  We could end up disabling something or turning something off that
> causes the system to overheat when we attempt to program the ADT7463
> specific functions.

Right. I assumed wisdom from Analog Devices in the improvements they
could do to the chip. I wouldn't have from all companies, but even then
my assumption might be too high and unsafe, as you underlined.

> Witness the recent changes to the config bits on the LM75 driver.  The
> operation of the interrupt output function.

The recent LM75 case is different, I think. The code was not correct in
the first place, even for a real, fully documented LM75.

Also not that I have always been advocating minimum initialization steps,
which are a requirement for the kind of forward compatibility I was
suggesting here. When the initialization in a given driver does more
than it should (e.g. chip reset or arbitrary reconfiguration of
particular features), then my point is void, agreed.

> Each member of the lm85 family has it's additional features implemented
> differently.  Registers above 0x70 are generally completely manufacturer
> specific.  (Register 0x74 and 0x75 are completely different between the
> LM85 and the ADM1027/ADT7463)

Well, as long as it is manufacturer-specific and not model-specific, my
approach seems to be still valid.

> And between the ADM1027 and the ADT7463, there is the _THERM_Enable bit
> in Configuration Register 3.  This bit is not defined on the ADM1027 but
> is on the ADT7463.  This bit controls the Interrupt or
> "overheat/shutdown" function of the chip and system.  Not something we
> want to program incorrectly.
>
> Lastly, the ADT7463 datasheet says "DO NOT WRITE TO THESE REGISTERS" in
> the description of registers 0x7e and 0x7f.  These registers are named
> "Test Register 1" and 2.  What other "test registers" might exist in
> future or compatible chips that shouldn't be written to?  What if they
> happen to be at the same address as one of the config registers
> currently implemented in the ADT7463 driver?

The cases you describe here are not a problem as long as Analog Devices
take care of backward and forward compatibility among a family of their
chips. I'd expect it, but of course we can't be sure.

> Shouldn't we investigate each revision of the chip to determine if there
> are new features that should be enabled or bits that have changed rather
> than just blindly assuming the manufacturer made a backward compatible
> upgrade?
>
> I would suggest that the "minimal subset" would be a much better default
> than the "maximum functionality" that your patch produces.

Makes sense. I might be assuming too much.

> > As a matter of fact, with my code, Christophe's chip would have been
> > properly detected. With yours it required a driver update.
>
> The driver should have already detected his chip correctly.  There is an
> else/if clause that matches for the Analog Devices manufacturer ID and a
> generic '0x6?' revision ID.  In that case, it should detect the chip and
> provide the basic functionality along with a message to advise them to
> look into the driver for better support.

In Linux 2.6.8.1 the code happens to be slightly different, unknown
revision IDs of Analog Devices chips do default to ADM1027 and not the
minimum LM85 subset. This has been fixed since (by Rafael Espindola,
[1]) to do what you describe (similar in that respect to the Linux 2.4
driver).

Also, when defaulting to the generic case, the message doesn't really
invite the user to report. If you want him/her to, I'd suggest you be
more explicit about it.

> > So unless there is a real risk I am missing, I do believe that the
> > change I made is an improvement.
>
> And we disagree.  But that is the nature of the open source development
> process.

"(...) the fundamental strength of open source is exactly the fact that
people don't have to agree about everything." -- Linus Torvalds,
2005-01-13 [2]

You made your point clear and I come to somewhat agree with you.
Different family of chips require different care. You know that
particular family better than I do, and it's not exactly a simple one.
You also know the driver better that I do - you wrote it after all, and
it differs from the other ones in several respects.

Please provide a patch for the Linux 2.6 lm85 driver adding support for
the 0x6a revision of the ADT7463 the way you like it.

I'll apply your patch to CVS this evening. BTW, don't you happen to
have CVS write access? If you do, you can commit the changes yourself
(and if you don't, please consider asking for one.)

Thanks a lot for looking into this, this is much appreciated.

[1]
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/chips/lm85.c@1.27
[2] http://lkml.org/lkml/2005/1/12/388

--
Jean Delvare
