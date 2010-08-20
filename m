From: "H. Peter Anvin" <hpa@linux.intel.com>
Date: Fri, 20 Aug 2010 18:39:42 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] Package Level Thermal Control and
Message-Id: <4C6ECBEE.5000301@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <94E56C79ECC49A4B87113985F1FEBA8D03F8AE2A4B@bgsmsx502.gar.corp.intel.com>	<4C485DF1.5050407@linux.intel.com>	<20100722162222.GA22450@linux-os.sc.intel.com>	<20100722172726.GA4914@ericsson.com>	<20100722175225.GB22450@linux-os.sc.intel.com>	<20100722185814.GA5235@ericsson.com>	<20100722212111.GC22450@linux-os.sc.intel.com>	<20100819174632.239aed93@hyperion.delvare>	<20100819162719.GB4160@ericsson.com>	<20100819205120.GA22602@linux-os.sc.intel.com> <20100820103356.01c9907f@hyperion.delvare>
In-Reply-To: <20100820103356.01c9907f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Brown, Len" <len.brown@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "Wan, Huaxu" <huaxu.wan@intel.com>, lkml <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 08/20/2010 01:33 AM, Jean Delvare wrote:
> 
> Side question: is it safe to assume a maximum of 2 siblings per core on
> Intel x86 CPUs?
> 

That is true for all current CPUs, but is not guaranteed for the future.

	-hpa

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
