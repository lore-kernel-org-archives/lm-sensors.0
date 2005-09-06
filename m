From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Sep 2005 21:16:46 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050906211640.368eff4f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> Sure, I didn't think you wanted to perform major surgery just prior to
> the release.

And you were of course right at that. I was merely trying to figure out
what the next (post-release) steps would be if we went that direction.
And it looks OK to me.

> > 2* Eeproms are not the only affected chips. "sensors" displays empty
> > entries for all i2c chips that have a driver. This includes the
> > adv7176 and saa7110 video devices for me. They too will disappear
> > when one loads any hwmon driver. It should cause less surprise than
> > for eeprom, because no useful information is displayed, but it might
> > still confuse the users. I have no immediate solution though.
> 
> Ooh, I didn't realize that: yeah, it's awkward.  I suppose my
> suggested patch could be expanded into a blacklist - diminishing
> returns though.

On second thought, I'm not sure it's even worth the effort, as sensors
doesn't print anything for these chips in the first place, so I doubt
people will complain or even wonder. Also, the list of non-sensors i2c
chips is so long that a blacklist would be impossible to maintain
anyway.

> > Feel free to commit your patch BTW, it looks good.
> 
> OK

Nice. I updated the FAQ to explain why the EEPROMs were disappearing
(4.33.2). I guess we are ready for release this time.

Philip, the next steps are up to you: bump the library version to 3.0.9,
and release!

Thanks,
-- 
Jean Delvare
