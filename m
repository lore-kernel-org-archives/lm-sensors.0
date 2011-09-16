From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Fri, 16 Sep 2011 21:37:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (coretemp) Drop duplicate
Message-Id: <493994B35A117E4F832F97C4719C4C040133348A5C@orsmsx505.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110916212143.557f8495@endymion.delvare>
In-Reply-To: <20110916212143.557f8495@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Friday, September 16, 2011 12:22 PM
> To: LM Sensors
> Cc: Yu, Fenghua; Guenter Roeck; R, Durgadoss
> Subject: [PATCH 1/2] hwmon: (coretemp) Drop duplicate function
> get_pkg_tjmax
> 
> Function get_pkg_tjmax is a simplified copy of get_tjmax. Drop it and
> always use get_tjmax, result is the same and this avoids code
> duplication.
> 
> Also make get_tjmax less verbose: don't warn about MSR read failure
> when failure was expected, and don't report TjMax in the logs unless
> debugging is enabled.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Durgadoss R <durgadoss.r@intel.com>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
