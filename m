From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 24 Apr 2011 01:58:53 +0000
Subject: Re: [lm-sensors] [PATCH] thermal: Drop CONFIG_THERMAL_HWMON
Message-Id: <20110424015853.GA8045@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110423150703.78ba86db@endymion.delvare>
In-Reply-To: <20110423150703.78ba86db@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <len.brown@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Rene Herman <rene.herman@gmail.com>

On Sat, Apr 23, 2011 at 09:07:03AM -0400, Jean Delvare wrote:
> It's about time to revert 16d752397301b95abaa95cbaf9e785d221872311.
> Anybody running a kernel >= 2.6.40 would also be running a recent
> enough version of lm-sensors.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Rene Herman <rene.herman@gmail.com>
> Cc: Len Brown <len.brown@intel.com>

Two other and less complex options:

- Add
	select THERMAL_HWMON if HWMON=y || HWMON=THERMAL
  to "menuconfig THERMAL", and keep THERMAL_HWMON as non-selectable bool
  [ I don't know what HWMON=THERMAL means, though ]
- Add
	select HWMON
  to "menuconfig THERMAL", and remove THERMAL_HWMON.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
