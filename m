From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Sep 2010 21:02:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1031) Replace update_rate
Message-Id: <20100916230234.34f16725@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284602835-7605-1-git-send-email-guenter.roeck@ericsson.com>
	<1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
	<20100916171443.0322bdb6@hyperion.delvare>
	<20100916153715.GE14165@ericsson.com>
	<20100916184237.3be9250d@hyperion.delvare>
	<1284666195.15696.35.camel@groeck-laptop>
In-Reply-To: <1284666195.15696.35.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Randy Dunlap <rdunlap@xenotime.net>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 16 Sep 2010 12:43:15 -0700, Guenter Roeck wrote:
> On Thu, 2010-09-16 at 12:42 -0400, Jean Delvare wrote:
> > I'd rather change all these to "millisecond", so that the document
> > consistently uses singular for all units.
> > 
> > I also see that the indentation isn't consistent, with power and energy
> > having 4 tabs where the rest has only 2. Bah.
> > 
> To get beyond this ... how about you apply my rev2, and I make the other
> changes (formatting and milliseconds --> millisecond) in a subsequent
> patch ?

I'll do the milliseconds --> millisecond myself, no need to resend.
Further changes would indeed belong to one or two separate patches, if
you have time for that. This is definitely low priority though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
