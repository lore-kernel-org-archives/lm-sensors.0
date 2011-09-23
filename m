From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 17:45:41 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: remove struct platform_data *
Message-Id: <1316799941.3888.43.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E7C7E280200007800057880@nat28.tlf.novell.com>
In-Reply-To: <4E7C7E280200007800057880@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-23 at 06:40 -0400, Jan Beulich wrote:
> The only caller of the function obtained the pointer solely for the
> purpose of passing it to this function, while it can be easily
> determined from the struct platform_device * parameter also passed.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> ---
>  drivers/hwmon/coretemp.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> --- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
> +++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
> @@ -548,11 +548,11 @@ static struct temp_data *init_temp_data(
>  	return tdata;
>  }
>  
> -static int create_core_data(struct platform_data *pdata,
> -				struct platform_device *pdev,
> +static int create_core_data(struct platform_device *pdev,
>  				unsigned int cpu, int pkg_flag)
>  {
>  	struct temp_data *tdata;
> +	struct platform_data *pdata = platform_get_drvdata(pdev);
>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	u32 eax, edx;
>  	int err, attr_no;
> @@ -625,16 +625,13 @@ exit_free:
>  
>  static void coretemp_add_core(unsigned int cpu, int pkg_flag)
>  {
> -	struct platform_data *pdata;
>  	struct platform_device *pdev = coretemp_get_pdev(cpu);
>  	int err;
>  
>  	if (!pdev)
>  		return;
>  
> -	pdata = platform_get_drvdata(pdev);
> -
> -	err = create_core_data(pdata, pdev, cpu, pkg_flag);
> +	err = create_core_data(pdev, cpu, pkg_flag);
>  	if (err)
>  		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
>  }

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
