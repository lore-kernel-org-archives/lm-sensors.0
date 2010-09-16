From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Sep 2010 21:39:15 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1031) Replace update_rate
Message-Id: <1284673155.15696.66.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284602835-7605-1-git-send-email-guenter.roeck@ericsson.com>
	 <1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
	 <20100916171443.0322bdb6@hyperion.delvare>
	 <20100916153715.GE14165@ericsson.com>
	 <20100916184237.3be9250d@hyperion.delvare>
	 <1284666195.15696.35.camel@groeck-laptop>
	 <20100916230234.34f16725@hyperion.delvare>
In-Reply-To: <20100916230234.34f16725@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2010-09-16 at 17:02 -0400, Jean Delvare wrote:
> On Thu, 16 Sep 2010 12:43:15 -0700, Guenter Roeck wrote:
> > On Thu, 2010-09-16 at 12:42 -0400, Jean Delvare wrote:
> > > I'd rather change all these to "millisecond", so that the document
> > > consistently uses singular for all units.
> > > 
> > > I also see that the indentation isn't consistent, with power and energy
> > > having 4 tabs where the rest has only 2. Bah.
> > > 
> > To get beyond this ... how about you apply my rev2, and I make the other
> > changes (formatting and milliseconds --> millisecond) in a subsequent
> > patch ?
> 
> I'll do the milliseconds --> millisecond myself, no need to resend.
> Further changes would indeed belong to one or two separate patches, if
> you have time for that. This is definitely low priority though.
> 
Ok, thanks

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
