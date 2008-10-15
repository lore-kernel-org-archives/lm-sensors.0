From: Eric Piel <eric.piel@tremplin-utc.net>
Date: Wed, 15 Oct 2008 11:20:17 +0000
Subject: Re: [lm-sensors] Accelerometer driver for HP laptops
Message-Id: <48F5D1F1.3060702@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C984F5.5000804@tudelft.nl> <200809120736.06594.trenn@suse.de> <48CAD89F.1050806@tremplin-utc.net> <20081015072511.GA20607@atrey.karlin.mff.cuni.cz> <48F5A0C8.1080102@tremplin-utc.net> <20081015105805.GD4247@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20081015105805.GD4247@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@suse.cz>
Cc: lm-sensors@lm-sensors.org, kernel list <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Tejun Heo <tj@kernel.org>, Yan Burman <burman.yan@gmail.com>

Pavel Machek schreef:

> 
>> I've got already a changelog ready. Give me a couple of days to clean
>> things up and I'll send it to akpm myself :-)
> 
> Ok, I'd like to help with cleaning... let me know if I can help some more.
Hi,
Thanks a lot for this patch.
> 
> * whitelist hp2133
Great!
> 
> * the driver has different name now.
That was too obvious for me to notice ;-)
> 
> * remove /** from comments that are not linuxdoc compliant.
Hum... I'll try to fix the comments to make them linuxdoc compliant. I
must be missing something obvious, but do you know where is the doc
about linuxdoc?
> 
> * remove /dev/accel. We can reintroduce it when it works
Right, that's probably the safest for now.

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
