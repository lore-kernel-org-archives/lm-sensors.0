From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Feb 2011 15:20:28 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (jc42) do not allow writing to
Message-Id: <20110216152028.GA14199@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5BCA87.7010204@ladisch.de>
 <4D5BCAEE.6030502@ladisch.de>
 <20110216145049.GC13872@ericsson.com>
 <4D5BE927.7000306@ladisch.de>
In-Reply-To: <4D5BE927.7000306@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Feb 16, 2011 at 10:11:35AM -0500, Clemens Ladisch wrote:
> Guenter Roeck wrote:
> > On Wed, Feb 16, 2011 at 08:02:38AM -0500, Clemens Ladisch wrote:
> > > +		readonly = config & JC42_CFG_TCRIT_LOCK;
> > 
> > You are assigning a non-bool to a bool. I can see that recent C compilers
> > do the right thing, but I am not sure if that is always the case.
> > So I would prefer
> > 		readonly = !!(config & JC42_CFG_TCRIT_LOCK);
> > 
> > Same for the assignments below. I can make that change if you are ok with it.
> 
> I cannot imagine how a compiler could get this wrong even if it tried
> to, but if you think so, go ahead.  :)
> 
I don't know. Maybe I am just paranoid. Using !! is how I usually see it done.
Is it really needed ? No idea. Better safe than sorry...

Applied with above changes.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
