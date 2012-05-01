From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 01 May 2012 21:25:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: fix oops on cpu unplug
Message-Id: <20120501212512.GA4340@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335791881-1560-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20120501152014.GA2629@ericsson.com>
 <20120501210041.GA10629@otc-wbsnb-06>
In-Reply-To: <20120501210041.GA10629@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, May 01, 2012 at 05:00:41PM -0400, Kirill A. Shutemov wrote:
> On Tue, May 01, 2012 at 08:20:14AM -0700, Guenter Roeck wrote:
> > On Mon, Apr 30, 2012 at 09:18:01AM -0400, Kirill A. Shutemov wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > coretemp tries to access core_data array beyond bounds on cpu unplug if
> > > core id of the cpu if more than NUM_REAL_CORES-1.
> > > 
> > [ ... ]
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > Looking at it again, you were right. Adding the check to get_core_online()
> > doesn't really help as the platform device is per CPU, not per core.
> > 
> > Applied. I'll submit a separate patch to increase NUM_REAL_CORES.
> 
> Actually, the problem is bigger.
> 
> Documentation/cputopology.txt:
> ==
> 2) /sys/devices/system/cpu/cpuX/topology/core_id:
> 
>         the CPU core ID of cpuX. Typically it is the hardware platform's
>         identifier (rather than the kernel's).  The actual value is
>         architecture and platform dependent.
> ==
> 
> We should not use core id as an index in an array since it's an arbitrary
> number (from kernel POV).
> 
Yes, we know we'll need a better fix going forward. Using a fixed size array is bad,
no matter what context.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
