From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 20 Oct 2010 16:49:29 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <20101020164929.GB22572@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287530020.10409.594.camel@Joe-Laptop>
 <20101020094208.3136b9dd@endymion.delvare>
 <1287590363.1813.148.camel@Joe-Laptop>
In-Reply-To: <1287590363.1813.148.camel@Joe-Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Alistair John Strachan <alistair@devzero.co.uk>, Henrik Rydberg <rydberg@euromail.se>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Luca Tettamanti <kronos.it@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Juerg Haefliger <juergh@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, Jim Cromie <jim.cromie@gmail.com>, Roger Lucas <vt8231@hiddenengine.co.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Oct 20, 2010 at 11:59:23AM -0400, Joe Perches wrote:
[ ... ]
> 
> Anyway, I'd like to sort it out eventually.
> For now, I just add the #define pr_fmt, with
> a long term goal of removing them all and using
> a different mechanism to remove the duplicated
> prefix string altogether from the formats and
> save some text.
> 
I don't mind individual pr_fmt defines as long as they are used.
However, that is not the case in many of the patches.
Just adding a pr_fmt define to a file without using it doesn't make sense to me.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
