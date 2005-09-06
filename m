From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 06 Sep 2005 05:28:07 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050906032739.GB24875@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

I wrote:
> > I know you don't want a lot of temporary code shoved in there, and for
> > that  matter neither do I.  So here is a minimal patch.  It simply
> > disables eeprom display for all 2.6.x kernels.  We can rip out the
> > guts of the eeprom code for the next release - my libsysfs patchset in
> > progress already does some of that anyway.
> > 
> > This should be easier to document and may also generate fewer bug
> > reports.

* Jean Delvare <khali@linux-fr.org> [2005-09-05 22:51:42 +0200]:
> Agreed. There are minor problems though.
> 
> 1* Your minimal hack leaves dead code in libsensors. It's probably not
> much of a problem, as long as we don't forget to remove it right after
> the release.

Sure, I didn't think you wanted to perform major surgery just prior to
the release.

> 2* Eeproms are not the only affected chips. "sensors" displays empty
> entries for all i2c chips that have a driver. This includes the adv7176
> and saa7110 video devices for me. They too will disappear when one loads
> any hwmon driver. It should cause less surprise than for eeprom, because
> no useful information is displayed, but it might still confuse the
> users. I have no immediate solution though.

Ooh, I didn't realize that: yeah, it's awkward.  I suppose my suggested
patch could be expanded into a blacklist - diminishing returns though.

> Feel free to commit your patch BTW, it looks good.

OK

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

