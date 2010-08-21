From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Aug 2010 10:02:50 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] Package Level Thermal Control and
Message-Id: <20100821120250.1a992b7d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <94E56C79ECC49A4B87113985F1FEBA8D03F8AE2A4B@bgsmsx502.gar.corp.intel.com>
 <4C485DF1.5050407@linux.intel.com>
 <20100722162222.GA22450@linux-os.sc.intel.com>
 <20100722172726.GA4914@ericsson.com>
 <20100722175225.GB22450@linux-os.sc.intel.com>
 <20100722185814.GA5235@ericsson.com>
 <20100722212111.GC22450@linux-os.sc.intel.com>
 <20100819174632.239aed93@hyperion.delvare>
 <20100819162719.GB4160@ericsson.com>
 <20100819205120.GA22602@linux-os.sc.intel.com>
In-Reply-To: <20100819205120.GA22602@linux-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "Wan, Huaxu" <huaxu.wan@intel.com>, lkml <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

One more thing...

On Thu, 19 Aug 2010 13:51:20 -0700, Fenghua Yu wrote:
> The pkgtemp reports thermal status for a set of sensors in a package. Please
> note the sensors in a package are not limited to processor sensors which are
> handled by coretemp. The sensors in a package also include gfx sensors, cache
> sensors, memory controllor sensors which are not handled by any hwmon drivers.

By "package" you mean CPU package, right? So by "gfx sensors" and
"memory controllor sensors", you refer to features possibly embedded
into the CPU package, not sensors outside the CPU, right?

> OS gets maximum package thermal status only from MSR PACKAGE_THERM_STATUS.
> There is no detailed thermal info for each sensor in a package. User-space
> can't compute a maximum by itself. So a piece of kernel driver code, whether
> a seperate driver or a integrated driver, is necessary if user-space wants to
> know thermal status of a package.

OK, now I understand, thanks for the clarification.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
