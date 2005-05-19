From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20040420215149.0776f527.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The NM34W02 datasheet makes clear in Figure 5 what a byte write is,
> it's what we call byte-write-data.
> The ST M34C02 datasheet has the same thing in Figure 6.

OK, good point. You're definitely better than me at readin datasheets ;)

> You're right we can't guarantee it. But the datasheets I've seen
> have been quite consistent.

I take note.

> Maybe it's a value to tell the user what it is.
> But we've been telling them for years it's a "shadow",
> maybe it doesn't add any value to tell them otherwise.

Well you've documented it the way it has to be, I think it's enough if
people need additional information.

> We've been using quick write for years, and haven't ever had a report
> that somebody saw something once at 30-37 and never again.
> Of course who would notice such a thing?

Nobody, especially since we were not actually detecting it, and also
because write-protecting the eeprom would be harmless in most cases (SPD
EEPROMS for example have no reason to be updated - write-protecting them
could even be considered a good thing).

> > I would suggest that we comment out the eeprom with $chip = 2 in
> > @chips_id by default. We can leave it in if some people happen to
> > need it, but not do it by default.
> 
> If you wish. I did it as an experiment.

OK, I've done that.

> > BTW, at least one EEPROM model (Catalyst CAT34RC02) can also read
> > byte from its write-protection address, so your detection method
> > would miss it.
> 
> Correct. We'd have to add it as yet another eeprom chip type.
> Which stretches things even more.

Feel free to add this in sensors-detect, I've not done it. Also feel
free to add a "default eeprom" entry and rework eeprom_detect a little
bit if you want.

So sensors-detect is clear. I've retained ranges 0x30-0x37 and 0x50-0x5F
for probe-with-reads. I'll do i2cdetect tomorrow. I plan to use the same
ranges.

Maybe we could provide command line flags to restore original probing
(all quick writes) and all probe-with-reads (with all due warnings)?

Then I'll submit a patch for the 2.6 kernels. i2c-core needs to be
changed to issue reads instead of quick writes on the above-mentioned
range. eeprom and ddcmon drivers lose their extra quick write. i2c-piix4
lose its IBM check. I don't know if we want to even remove the unsafe
smbus check in dmi_scan, I'll see that later.

As for the 2.4 kernel modules, there's a problem there. i2c-core and
eeprom are distributed in different packages and not necessarily in
sync, since there is no explicit version checking. Thus mixing a new
i2c-core with an old eeprom would result in the extra quick write in
eeprom actually corrupt the chip. Bad. There's still the IBM check in
i2c-piix4 however. Maybe we don't want to change anything in 2.4 after
all (except ensure that the extra quickwrites are consistently issued).

Comments welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
