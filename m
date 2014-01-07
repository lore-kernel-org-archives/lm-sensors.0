From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Jan 2014 15:07:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sensors: fix SENSORS_LM75 dependencies
Message-Id: <20140107160738.4a76a6d0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140106204020.b47e53cc3ead8f90164ef5b7@canb.auug.org.au>
	<52CB0948.6030702@infradead.org>
	<20140106203209.GA21630@roeck-us.net>
	<52CB53DC.4030901@infradead.org>
	<52CB65DA.2010103@roeck-us.net>
	<20140107130401.23bffcd2@endymion.delvare>
	<52CBF1CF.2000603@ti.com>
	<744357E9AAD1214791ACBA4B0B909263011BC64C@SHSMSX101.ccr.corp.intel.com>
	<52CC15F0.6020209@ti.com>
In-Reply-To: <52CC15F0.6020209@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Guenter Roeck <linux@roeck-us.net>, Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org

On Tue, 7 Jan 2014 10:57:52 -0400, Eduardo Valentin wrote:
> On 07-01-2014 10:05, Zhang, Rui wrote:
> > BTW, I've been thinking of make CONFIG_THERMAL a bool since long time ago, the only thing that blocks me is that Thermal subsystem needs to register a hwmon device for each thermal zone and CONFIG_HWMON is a tristate.
> 
> I agree with the move of having CONFIG_THERMAL as bool. Unless you have
> use cases where users are dynamically loading and unloading thermal per
> user demand, which I doubt.

Modularity is not only about reloading modules (although this can be
useful for developers in particular.) It's also about enabling many
features in a generic distribution kernel and each feature only gets
loaded/used on the hardware which needs it. This is why, as a
distribution kernel maintainer, I keep complaining when I see boolean
options which might easily be tristates.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
