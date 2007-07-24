From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jul 2007 11:58:10 +0000
Subject: Re: [lm-sensors] Fujitsu-Siemens Scylla (fscscy)
Message-Id: <20070724135810.04e024a9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46933578.3010701@miloi.de>
In-Reply-To: <46933578.3010701@miloi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 23 Jul 2007 16:33:12 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi Hans,
> > 
> > You may also want to take a look at the pending driver for the new FSC
> > Heimdall chip:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018629.html
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018787.html
> > I wonder if it is also similar. I just added an entry to wiki/Devices.
> 
> It is indeed similar too, for some reason FSC keeps changes fan and temp 
> register addresses, but that can easily be handled with an array addressed with 
> the chip-type.

It depends on how different they are, but in general, different
register maps is the reason #1 for writing different drivers.

> Also they seem to have done strange things with temp sensor numbers, for the 
> fscpos and fscher the temp sensors are identical, however the fscscy adds a 
> fourth sensor, but in the 2.4 sensors puts that in as temp2 moving temp2 and 3 
> to temp3 and 4 when compared to the fscher / fscpos, I guess its best to just 
> clone this erm "interesting" numbering in the 2.6 driver.

If you're going for a new driver, and it makes it easier to number them
differently, go for it.

> > * I discourage the use of "x" in the driver names. It looks great only
> > until the day a new chip is released, those name matches the mask, but
> > which isn't compatible at all. For hardware monitoring drivers, we tend
> > to name the driver after the first supported chip, and consider the
> > others as "mostly foo-compatible."
> 
> Okay, so I will call it fscpos_new then.

If you're going to include Scylla support in it, it might make sense to
name it fscscy instead, as this driver doesn't yet exist in 2.6, this
will save us the pain of renaming the driver at a later date.

> > * If you go for a new driver, without watchdog support, then we will
> > have to keep all the other drivers around for at least some time
> > anyway. So the watchdog problem is more or less independent from your
> > decision.
> 
> I know, but doing a new driver is in my mind way easier then juggling a lot of 
> incremental patches to an existing driver, and there is more then just the 
> watchdog, the current drivers also have old alarm files and various exports of 
> status registers in raw formats, the fscpos also has very interesting 
> rempX_reset sysfs entries, which can be written to reset the alarms for temps, etc.
> 
> So I'll start working on a new clean unified driver for the 4, without watchdog 
> support for starters, but watchdog support according to the standard API's will 
> be on my roadmap.
> 
> I'm actually planning to make writing the watchdog support a lab assignment for 
> a device driver class I will be teaching starting september.

Good plan :)

> AFAIK I already asked, but let me ask again: I could really use some ideas / 
> suggestion for chips/devices which come with docs and need a 2.6 driver 
> written. So that I can use this as assignments, don't worry I will review, 
> submit (if usable) and maintain any resulting drivers myself. Unless ofcourse a 
> student likes writing the driver so much he pledges to maintain it himself.
> 
> I'm currently thinking about trying to get some adm1024 chips for example, but 
> I wonder is the statement on the devices wiki-page that the adm1024 is not 
> supported with 2.6 still accurate?

Yes, this statement is still accurate.

In general, I suggest that you avoid pushing in the kernel support for
random chips which are not known to be in use in real-world hardware.
Even if you maintain them yourself, you won't do it forever, and having
unused drivers only slows things down and lower the average quality. So
better pick chips from the Devices page where at least one user
requested support already (as the ADM1024, ADT7475/76, F75387SG/RG or
MAX6648/92.)

If your 1st year students learn how to write drivers, maybe in 2nd year
you can teach them how to review drivers? ;) That's what we need the
most.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
