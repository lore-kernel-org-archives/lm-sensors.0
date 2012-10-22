From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 22 Oct 2012 00:29:03 +0000
Subject: Re: [lm-sensors] [PATCH v2 8/8] hwmon: (it87) Manage device specific features with table
Message-Id: <20121022002903.GA6521@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1350841995-5748-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1350841995-5748-9-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 21, 2012 at 04:30:38PM -0700, Phil Pokorny wrote:
> On Sun, Oct 21, 2012 at 10:53 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > +
> > +#define        FEAT_12MV_ADC           (1 << 0)
> > +#define        FEAT_NEWER_AUTOPWM      (1 << 1)
> > +#define        FEAT_OLD_AUTOPWM        (1 << 2)
> >
> 
> Newer or older than what?  Would it make more sense to number these?  Gen1,
> Gen2 or V1, V2 so that if yet another AUTOPWM mode/feature is added we
> don't end up with "even_newer_autopwm"?
> 
I simply replaced existing functions with a bit map. Choosing a different
definition for a bit doesn't make sense w/o changing the matching function
name as well. That would require a separate patch, and I am not sure if
it would make sense.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
