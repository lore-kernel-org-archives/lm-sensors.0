From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Oct 2010 16:42:06 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <20101020184206.1b2ce1e1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287530020.10409.594.camel@Joe-Laptop>
	<20101020032938.GA20095@ericsson.com>
	<1287545658.10409.606.camel@Joe-Laptop>
	<20101020035346.GA20178@ericsson.com>
	<1287547662.10409.618.camel@Joe-Laptop>
	<20101020093438.07b129c8@endymion.delvare>
	<1287592068.1813.185.camel@Joe-Laptop>
In-Reply-To: <1287592068.1813.185.camel@Joe-Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Alistair John Strachan <alistair@devzero.co.uk>, Henrik Rydberg <rydberg@euromail.se>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Luca Tettamanti <kronos.it@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Juerg Haefliger <juergh@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, Jim Cromie <jim.cromie@gmail.com>, Roger Lucas <vt8231@hiddenengine.co.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, 20 Oct 2010 09:27:48 -0700, Joe Perches wrote:
> On Wed, 2010-10-20 at 09:34 +0200, Jean Delvare wrote:
> > Joe, would you mind providing a similar patch for the driver at:
> >   http://khali.linux-fr.org/devel/misc/w83795/w83795.c
> > This driver will be added to kernel 2.6.37.
> 
> This file doesn't use printk and doesn't need any similar patch.

OK, thanks for checking!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
