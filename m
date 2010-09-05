From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 05 Sep 2010 16:35:12 +0000
Subject: Re: [lm-sensors] [PATCH] therm_throt.c: Fix error handling in
Message-Id: <20100905163512.GA2114@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283474726-20109-1-git-send-email-fenghua.yu@intel.com>
 <20100903093553.GA6821@elte.hu>
 <20100903213456.GA22124@fenghua-desk.sc.intel.com>
 <20100905123229.GA8254@elte.hu>
In-Reply-To: <20100905123229.GA8254@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Jin Dongming <jin.dongming@np.css.fujitsu.com>

On Sun, Sep 05, 2010 at 08:32:29AM -0400, Ingo Molnar wrote:
> 
> * Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> > Or other options could be:
> > 
> > 1. Just calling sysfs_add_file_to_group() without collecting returned error and
> > return 0 at the end (driver/pci/pcie/aspm.c does like this). The drawback is
> > there is no error logged if an unlikely errorr occurs. But user can see some
> > files are missing in sysfs.
> >
> > 2. Or collect errors in err1, err2, etc for each sysfs_add_file_to_group. At
> > the end, return -ENODEV(??) if any err1, err2, etc is not 0. This option makes
> > code unreasonable complex to handle unlikely errors.
> 
> Well, the usual way to handle errors is to abort the operation when it 
> occurs, and return the error code that sysfs_add_file_to_group() gave.
> 
> The error is not 'fatal' but missing sysfs files sure are confusing, and 
> might break user-land which depends on them. So we should either 
> initialize a driver fully - or not intialize it at all.
> 
> Now, a sub-case is the question whether to emit something more than the 
> return code from sysfs_add_file_to_group(). If it's exceedingly rare 
> (and subsequently poorly tested) then adding a WARN_ON_ONCE(ret) is OK - 
> but that error code should be returned.
> 
> Am i missing any detail?
> 
Unless I am missing something, the problem here is that if driver initialization
code returns an error, the driver won't be installed. If device entries are retained,
this will ultimately cause the kernel to crash.

From my perspective, the usual handling is just fine - ie not install the driver
at all. Everything else just causes confusion.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
