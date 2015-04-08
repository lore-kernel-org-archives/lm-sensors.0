From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Apr 2015 19:40:22 +0000
Subject: Re: [lm-sensors] Kernel Panic when running sensors on new CentOS kernel (3.10.0-229.1.2)
Message-Id: <20150408194022.GA28217@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <55256D66.1000400@winfirst.com>
In-Reply-To: <55256D66.1000400@winfirst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 08, 2015 at 12:15:08PM -0700, Mark Hansen wrote:
> On 4/8/2015 11:52 AM, Guenter Roeck wrote:
> >On Wed, Apr 08, 2015 at 11:27:05AM -0700, Guenter Roeck wrote:
> >> On Wed, Apr 08, 2015 at 11:03:18AM -0700, Mark Hansen wrote:
> >
> >[ ... ]
> >> >
> >> I would guess that some patch from a later kernel version was back-ported,
> >> but is missing a critical part. Do you know if the source code for that kernel
> >> is available somewhere ?
> >>
> >
> >Never mind, I found the source and had a look. It turns out that the
> >hardware monitoring code in drivers/gpu/drm/radeon/radeon_pm.c (which
> >is what affects you) is broken in 7.1. You might want to open a case
> >with the CentOS community (or possibly Fedora / Redhat).
> >
> >Guenter
> >
> 
> Guenter,
> 
> Thanks for the quick look. I've had a question posted to the CentOS 7.x forum since the weekend
> but not much response there. I can see if I can figure out how to open the case with the CentOS
> team. Is there any way you can provide me with what I'll need to tell them, so they know what
> is broken, or do you think the information I provided in my initial e-mail here will be enough?
> 
The information you provided should be enough. I don't know how patches
are applied to CentOS, so I don't know exactly what went wrong.

I _suspect_ that someone attempted to back-port commit ec39f64bba34
("drm/radeon/dpm: Convert to use devm_hwmon_register_with_groups"), realized
that the new API is not available in 3.10, and instead of dropping the patch
applied it partially - with the to-be-expected result. That is just a wild
guess, though.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
