From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Apr 2011 19:40:53 +0000
Subject: Re: [lm-sensors] [PATCH] thermal: Drop CONFIG_THERMAL_HWMON
Message-Id: <20110424214053.15aa4def@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110423150703.78ba86db@endymion.delvare>
	<20110424015853.GA8045@ericsson.com>
In-Reply-To: <20110424015853.GA8045@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Len Brown <len.brown@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Rene Herman <rene.herman@gmail.com>

Hi Guenter,

On Sat, 23 Apr 2011 18:58:53 -0700, Guenter Roeck wrote:
> On Sat, Apr 23, 2011 at 09:07:03AM -0400, Jean Delvare wrote:
> > It's about time to revert 16d752397301b95abaa95cbaf9e785d221872311.
> > Anybody running a kernel >= 2.6.40 would also be running a recent
> > enough version of lm-sensors.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Rene Herman <rene.herman@gmail.com>
> > Cc: Len Brown <len.brown@intel.com>
> 
> Two other and less complex options:
> 
> - Add
> 	select THERMAL_HWMON if HWMON=y || HWMON=THERMAL
>   to "menuconfig THERMAL", and keep THERMAL_HWMON as non-selectable bool
>   [ I don't know what HWMON=THERMAL means, though ]

HWMON=THERMAL means: both HWMON and THERMAL built as modules, or both
built into the kernel, or neither built at all. Given that the "y" case
is already mentioned explicitly, and the whole thing isn't even
evaluated if THERMAL=n, HWMON=THERMAL here is essentially a shortcut
for "THERMAL=m && HWMON=m".

> - Add
> 	select HWMON
>   to "menuconfig THERMAL", and remove THERMAL_HWMON.

Thanks for the suggestions. I admit I blindly reverted the original
commit without putting much thought into possible alternatives.

Your second suggestion is by far the most simple. However it has a
drawback, it makes it impossible to select THERMAL without HWMON. This
is no concern to me, but maybe some embedded systems will be unhappy
about this. HWMON has no interest in the absence of local users.

Your first suggestion makes a lot of sense, as it avoids repeating the
same non-trivial conditional construct in 3 different places. But OTOH
it leaves in Kconfig an option that shouldn't be there, as nobody
should depend on its value. I consider it an abuse of the Kconfig
system.

In fact, my impression is that the repeated tests, and the fact that two
of them are in <linux/thermal.h>, are the consequence of bad code
design. The fact that THERMAL_HWMON affects a public structure when the
implementation is completely internal to the thermal driver makes no
sense. It should be possible to implement things differently.

Len, please hold on until we agree on the best way to address the issue.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
