From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Dec 2011 16:05:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on driver load
Message-Id: <1322755542.23607.94.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111201110047.130190a5@endymion.delvare>
In-Reply-To: <20111201110047.130190a5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-12-01 at 05:00 -0500, Jean Delvare wrote:
> On Thu, 1 Dec 2011 01:26:39 +0100, Jean Delvare wrote:
> > On Thu, 01 Dec 2011 07:25:15 +0800 (HKT), undersys wrote:
> > > Hi All,
> > > 
> > > I can no longer load the core temp module, it gives me the following kernel Opps.
> > > (...)
> > > This used to work fine before I updated the kernel to 3.0.x. (...)
> > 
> > Ah, yes, I can reproduce that, and the bug is pretty obvious. I'll send
> > a patch tomorrow.
> > 
> > Meanwhile you may be able to work around the problem by installing the
> > microcode_ctl package and ensuring that the microcode is updated before
> > loading the coretemp driver.
> 
> If the CPU microcode is too old, the coretemp driver won't work. But
> instead of failing gracefully, it currently oops. Check for NULL
> platform device data to avoid this.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Durgadoss R <Durgadoss.r@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Jean, how do we send this to Greg ? stable@vger.kernel.org ?

Guenter

> ---
> This is for stable kernel branch 3.0 only. Previous and later versions
> have different code paths and are not affected by this bug.
> 
>  drivers/hwmon/coretemp.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-3.0.orig/drivers/hwmon/coretemp.c	2011-12-01 08:39:45.000000000 +0100
> +++ linux-3.0/drivers/hwmon/coretemp.c	2011-12-01 08:49:32.000000000 +0100
> @@ -539,6 +539,8 @@ static void coretemp_add_core(unsigned i
>  		return;
>  
>  	pdata = platform_get_drvdata(pdev);
> +	if (!pdata)
> +		return;
>  
>  	err = create_core_data(pdata, pdev, cpu, pkg_flag);
>  	if (err)
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
