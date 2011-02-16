From: Clemens Ladisch <clemens@ladisch.de>
Date: Wed, 16 Feb 2011 15:38:38 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (jc42) do not allow writing to
Message-Id: <4D5BEF7E.4010409@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5BCA87.7010204@ladisch.de> <4D5BCAEE.6030502@ladisch.de> <20110216145049.GC13872@ericsson.com> <4D5BE927.7000306@ladisch.de> <20110216152028.GA14199@ericsson.com>
In-Reply-To: <20110216152028.GA14199@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Guenter Roeck wrote:
> On Wed, Feb 16, 2011 at 10:11:35AM -0500, Clemens Ladisch wrote:
> > Guenter Roeck wrote:
> > > On Wed, Feb 16, 2011 at 08:02:38AM -0500, Clemens Ladisch wrote:
> > > > +		readonly = config & JC42_CFG_TCRIT_LOCK;
> > > 
> > > You are assigning a non-bool to a bool. I can see that recent C compilers
> > > do the right thing, but I am not sure if that is always the case.
> > > So I would prefer
> > > 		readonly = !!(config & JC42_CFG_TCRIT_LOCK);
> > > 
> > > Same for the assignments below. I can make that change if you are ok with it.
> > 
> > I cannot imagine how a compiler could get this wrong even if it tried
> > to, but if you think so, go ahead.  :)
> 
> I don't know. Maybe I am just paranoid. Using !! is how I usually see it done.

Usually, !! is used to convert non-zero to the _integer_ 1.  With
a compiler that implements bool, this conversion is already implied.
On older compilers, someone might be tempted to do "#define bool int",
but this is not an issue with the compilers required by Linux.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
