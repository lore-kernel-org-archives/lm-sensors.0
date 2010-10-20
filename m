From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 19:52:03 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <1287604323.15567.22.camel@Joe-Laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287530020.10409.594.camel@Joe-Laptop>
	 <20101020094208.3136b9dd@endymion.delvare> <1287602386.2210.6.camel@cowboy>
	 <20101020213810.6b31c04e@endymion.delvare>
In-Reply-To: <20101020213810.6b31c04e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: dave@gnu.org, Guenter Roeck <guenter.roeck@ericsson.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Alistair John Strachan <alistair@devzero.co.uk>, Henrik Rydberg <rydberg@euromail.se>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Luca Tettamanti <kronos.it@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Juerg Haefliger <juergh@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, Jim Cromie <jim.cromie@gmail.com>, Roger Lucas <vt8231@hiddenengine.co.uk>, lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 2010-10-20 at 21:38 +0200, Jean Delvare wrote:
> On Wed, 20 Oct 2010 16:19:46 -0300, Davidlohr Bueso wrote:
> > Well we do have this:
> > #ifndef pr_fmt
> > #define pr_fmt(fmt) fmt
> > #endif
> I can read the code, thank you. My point is that what we have is
> insufficient, as Joe is proposing to use a different pr_fmt definition
> for pretty much all drivers in the kernel tree.

No, I'm proposing to use a uniform pr_fmt definition for
files that want a prefix on their logging messages.

At some point, the files that do not want a prefix
should be converted to use #define pr_fmt(fmt) fmt.

Repeating from another email, there are ~1500 files that
use pr_<level> without using pr_fmt.  There are 335 files
that #define pr_fmt.

So I'm not saying that point in time is now.

Another way to do this would be to standardize
hwmon.h so it would add:
	"#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt"
in only 1 place.

So perhaps add this to include/linux/hwmon.h instead:

#if defined pr_fmt
#undef pr_fmt
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
#endif



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
