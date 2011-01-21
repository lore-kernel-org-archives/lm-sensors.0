From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 21 Jan 2011 02:26:11 +0000
Subject: Re: [lm-sensors]
Message-Id: <20110121022611.GC9496@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF046541094482ED6A@bgsmsx502.gar.corp.intel.com>
 <20110120221704.GA26954@linux-os.sc.intel.com>
In-Reply-To: <20110120221704.GA26954@linux-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>, H Peter Anvin <hpa@zytor.com>

On Thu, Jan 20, 2011 at 05:17:05PM -0500, Fenghua Yu wrote:
[ ... ]
> This patch has compilation error:
> ERROR: "platform_thermal_notify" [drivers/hwmon/coretemp.ko] undefined!
> 
> The reason is commit 9e76a97efd31a08cb19d0ba12013b8fb4ad3e474 patch for
> therm_throt.c in upstream doesn't export the symbol platform_thermal_notify.
> 
> The following patch should fix the issue. Apply it before compiling your patch.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

You are hiding your patch in a reply to another patch. Plus, your patch needs to go
into a different subsystem. Hope the x86 maintainers catch it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
