From: Pavel Machek <pavel@suse.cz>
Date: Wed, 15 Oct 2008 07:25:11 +0000
Subject: Re: [lm-sensors] Accelerometer driver for HP laptops
Message-Id: <20081015072511.GA20607@atrey.karlin.mff.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C984F5.5000804@tudelft.nl> <200809120736.06594.trenn@suse.de> <48CAD89F.1050806@tremplin-utc.net>
In-Reply-To: <48CAD89F.1050806@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Piel <eric.piel@tremplin-utc.net>, lm-sensors@lm-sensors.org, kernel list <linux-kernel@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, Tejun Heo <tj@kernel.org>, Yan Burman <burman.yan@gmail.com>

Hi!

I took a look at the driver, and it seems to work for me... I'd like
to get it to the mainline...

> >>Attached is our work-in-progress version of the driver for a fourth take
> >>on the LKML (it used to be mdps). It works really fine, with lots of
> >>"goodies" (like automatically convert the axes to fit to a standard,
> >>automatic power-off of the device when not in used) excepted the
> >>interrupt support for free-fall detection.

I wonder if mdps was really a better name? Driver is HP-specific
(because of the ACPI usage), not really chip specific... and lis3lv02d
looks like an alphabet soup to me...

Ok, it is a bit chip-specific, too...

What are the next plans... lm_sensors is listed as orphan in
MAINTAINERS, so I guess I'll clean it up a tiny bit then submit to akpm?

>  Documentation/hwmon/lis3lv02d      |   92 ++++
>  drivers/hwmon/Kconfig              |   23 +
>  drivers/hwmon/Makefile             |    1 +
>  drivers/hwmon/lis3lv02d.c          |  865 ++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/lis3lv02d.h          |  149 ++++++
>  5 files changed, 1145 insertions(+), 16 deletions(-)

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
