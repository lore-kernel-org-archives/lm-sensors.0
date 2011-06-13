From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Jun 2011 17:14:04 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/1] Hwmon: Add core_pkg Threshold
Message-Id: <20110613171404.GC2629@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307791723-28272-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1307791723-28272-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durga,

On Sat, Jun 11, 2011 at 07:28:43AM -0400, Durgadoss R wrote:
> This patch adds the core and pkg support to coretemp.
> These thresholds can be configured via the sysfs interfaces tempX_max
> and tempX_max_hyst. An interrupt is generated when CPU temperature reaches
> or crosses above tempX_max OR drops below tempX_max_hyst.
> 
> This patch is based on the documentation in IA Manual vol 3A, that can be
> downloaded from here:
> http://download.intel.com/design/processor/manuals/253668.pdf
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

[ ... ]

> +			size_t count) = { NULL, NULL, NULL, NULL, NULL,
> +					store_ttarget, store_tmin };
> +	static const char *names[TOTAL_ATTRS] = {
>  					"temp%d_label", "temp%d_crit_alarm",
> -					"temp%d_max", "temp%d_input",
> -					"temp%d_crit" };
> +					"temp%d_imput", "temp%d_crit",

s/imput/input/

Seems like we need another round of detailed testing ...

> +					"temp%d_max_alarm", "temp%d_max",
> +					"temp%d_max_hyst" };
>  
> -	for (i = 0; i < MAX_ATTRS; i++) {
> +	for (i = 0; i < tdata->attr_size; i++) {
>  		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
>  			attr_no);
>  		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
>  		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
>  		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
> +		if (rw_ptr[i])
> +			tdata->sd_attrs[i].dev_attr.attr.mode |= S_IWUSR;
>  		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
> -		tdata->sd_attrs[i].dev_attr.store = NULL;
> +		tdata->sd_attrs[i].dev_attr.store = rw_ptr[i];

Since you check for rw_ptr above anyway, you might as well move this assignment
into the if branch above. The NULL assignment is not necessary anyway, since the
entire structure is pre-initialized from kzalloc().

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
