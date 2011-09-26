From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 26 Sep 2011 14:59:31 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON configuration option removal
Message-Id: <1317049171.3888.49.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110926033740.GA5637@ericsson.com>
	 <20110926103255.02db677c@endymion.delvare>
In-Reply-To: <20110926103255.02db677c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rene Herman <rene.herman@gmail.com>

On Mon, 2011-09-26 at 04:32 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 25 Sep 2011 20:37:40 -0700, Guenter Roeck wrote:
> > I just noticed the folllowing in feature-removal-schedule.txt:
> > 
> > What:   CONFIG_THERMAL_HWMON
> > When:   January 2009
> > Why:    This option was introduced just to allow older lm-sensors userspace
> >         to keep working over the upgrade to 2.6.26. At the scheduled time of
> >         removal fixed lm-sensors (2.x or 3.x) should be readily available.
> > Who:    Rene Herman <rene.herman@gmail.com>
> > 
> > I don't know what the lm-sensors changes are, and if they have been implemented.
> > Is it time to remove the configuration option ?
> 
> Not sure where you looked, but it's already gone. See commit
> ab92402af04c151c26541eb28e1c26286a429db5.
> 
Ah yes, now I remember. No idea what I looked at. Should teach me to
clean up my branches.

Sorry for the noise.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
