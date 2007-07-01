From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 01 Jul 2007 16:36:55 +0000
Subject: Re: [lm-sensors] [RESEND][PATCH] THMC50 and ADM1022 support for 2.6
Message-Id: <20070701183655.6f5cc0f7.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <467FD8F2.1000409@wp.pl>
In-Reply-To: <467FD8F2.1000409@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you very much for the review.

There is one thing I still need help with.

On Sun, 1 Jul 2007 10:03:25 -0400
"Mark M. Hoffman" <mhoffman@lightlink.com> wrote:

> > +	if (kind = thmc50) {
> > +		type_name = "thmc50";
> > +	/* Remove temp3 attributes */
> > +		thmc50_group.attrs[8] = NULL;
> > +		thmc50_group.attrs[9] = NULL;
> > +		thmc50_group.attrs[10] = NULL;
> 
> Hrm, fragile.  Please just put these in a separate group, as other hwmon
> drivers do.  Ultimately, the attr arrays should be defined const as well
> anyway, but for some missing const modifiers in the driver core.

I know it is kind of hack. Can you point me to the "other hwmon drivers"? The drivers
which use groups to remove/add some of attributes depending on mode/chip type in correct
way.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
