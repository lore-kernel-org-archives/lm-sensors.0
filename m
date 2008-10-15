From: Pavel Machek <pavel@suse.cz>
Date: Wed, 15 Oct 2008 12:03:39 +0000
Subject: Re: [lm-sensors] Accelerometer driver for HP laptops
Message-Id: <20081015120339.GE4247@atrey.karlin.mff.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C984F5.5000804@tudelft.nl> <200809120736.06594.trenn@suse.de> <48CAD89F.1050806@tremplin-utc.net> <20081015072511.GA20607@atrey.karlin.mff.cuni.cz> <48F5A0C8.1080102@tremplin-utc.net> <20081015105805.GD4247@atrey.karlin.mff.cuni.cz> <48F5D1F1.3060702@tremplin-utc.net>
In-Reply-To: <48F5D1F1.3060702@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: lm-sensors@lm-sensors.org, kernel list <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Tejun Heo <tj@kernel.org>, Yan Burman <burman.yan@gmail.com>

Hi!

> >> I've got already a changelog ready. Give me a couple of days to clean
> >> things up and I'll send it to akpm myself :-)
> > 
> > Ok, I'd like to help with cleaning... let me know if I can help some more.
> Hi,
> Thanks a lot for this patch.

You are welcome.

> > * remove /** from comments that are not linuxdoc compliant.
> Hum... I'll try to fix the comments to make them linuxdoc compliant. I
> must be missing something obvious, but do you know where is the doc
> about linuxdoc?

Documentation/kernel-doc-nano-HOWTO.txt, AFAICT. It took me a while to
find.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
