From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 30 Apr 2012 16:19:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: fix oops on cpu unplug
Message-Id: <20120430161941.GA3167@otc-wbsnb-06>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335791881-1560-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1335799690.2351.100.camel@groeck-laptop>
In-Reply-To: <1335799690.2351.100.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 30, 2012 at 08:28:10AM -0700, Guenter Roeck wrote:
> Hi,
> 
> good catch. Couple of problems, though.
> 
> First, what number of cores are we talking about ? We should probably
> increase NUM_REAL_CORES as well. Long term, we should get rid of the
> dependency to prevent that problem from happening again, but that is a
> different issue.

It triggered by another bug. Cores on my 10-core processor have ids 0, 1,
2, 8, 9, 16, 17, 18, 24, 25. :-/
No need to change NUM_REAL_CORES at the moment.

> Second, we'll need the same code in get_core_online(). Otherwise the
> platform device can be created for the new core (if the core is
> re-enabled) but will never be deleted.

It has already handled in create_core_data().

-- 
 Kirill A. Shutemov

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
