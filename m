From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 20 Oct 2010 03:29:38 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <20101020032938.GA20095@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287530020.10409.594.camel@Joe-Laptop>
In-Reply-To: <1287530020.10409.594.camel@Joe-Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Alistair John Strachan <alistair@devzero.co.uk>, Henrik Rydberg <rydberg@euromail.se>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Luca Tettamanti <kronos.it@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Juerg Haefliger <juergh@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, Jim Cromie <jim.cromie@gmail.com>, Roger Lucas <vt8231@hiddenengine.co.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Oct 19, 2010 at 07:13:40PM -0400, Joe Perches wrote:
> Convert printks to pr_<level>
> Coalesce long formats
> Removed prefixes from formats
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Standardized abitguru messages for reporting and finding MAINTAINER
> 
> Compiled x86 allyesconfig only.
> I inspected "strings drivers/hwmon/built-in.o",
> but it's otherwise untested.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

There are several lines longer than 80 characters.
Does this rule no longer apply ?

Oddly enough, there are only four checkpatch warnings about long lines,
even though there are many more.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
