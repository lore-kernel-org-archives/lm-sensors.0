From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 30 Apr 2012 16:59:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: fix oops on cpu unplug
Message-Id: <1335805164.2351.116.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335791881-1560-1-git-send-email-kirill.shutemov@linux.intel.com>
	 <1335799690.2351.100.camel@groeck-laptop>
	 <20120430161941.GA3167@otc-wbsnb-06>
In-Reply-To: <20120430161941.GA3167@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2012-04-30 at 12:19 -0400, Kirill A. Shutemov wrote:
> On Mon, Apr 30, 2012 at 08:28:10AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > good catch. Couple of problems, though.
> > 
> > First, what number of cores are we talking about ? We should probably
> > increase NUM_REAL_CORES as well. Long term, we should get rid of the
> > dependency to prevent that problem from happening again, but that is a
> > different issue.
> 
> It triggered by another bug. Cores on my 10-core processor have ids 0, 1,
> 2, 8, 9, 16, 17, 18, 24, 25. :-/
> No need to change NUM_REAL_CORES at the moment.
> 
The problem, though, is that core_data[] is indexed by the core ID. So,
NUM_REAL_CORES is a bit misleading. It should probably be named
NUM_CORE_ID or something similar.

> > Second, we'll need the same code in get_core_online(). Otherwise the
> > platform device can be created for the new core (if the core is
> > re-enabled) but will never be deleted.
> 
> It has already handled in create_core_data().
> 
... which is called from coretemp_add_core(), which does not return an
error. Besides, it is called after the call to coretemp_device_add().

As a result, the platform device for the unsupported core(s) will be
created, even if the core is not supported. I just don't think that is a
good idea.

Besides, if you'd have the check in get_core_online(), you would not
even hit the problem in put_core_offline(), since the platform device
would not exist and the function would bail out because of that.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
