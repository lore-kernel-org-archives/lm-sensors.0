From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 17:45:22 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: constify static data
Message-Id: <1316799922.3888.42.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E7C7D650200007800057868@nat28.tlf.novell.com>
In-Reply-To: <4E7C7D650200007800057868@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-23 at 06:36 -0400, Jan Beulich wrote:
> These arrays won't ever be written to, so protect them from
> unintentional modification.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> ---
>  drivers/hwmon/coretemp.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
> +++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
> @@ -442,15 +442,15 @@ static int create_core_attrs(struct temp
>  				int attr_no)
>  {
>  	int err, i;
> -	static ssize_t (*rd_ptr[TOTAL_ATTRS]) (struct device *dev,
> +	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
>  			struct device_attribute *devattr, char *buf) = {
>  			show_label, show_crit_alarm, show_temp, show_tjmax,
>  			show_max_alarm, show_ttarget, show_tmin };
> -	static ssize_t (*rw_ptr[TOTAL_ATTRS]) (struct device *dev,
> +	static ssize_t (*const rw_ptr[TOTAL_ATTRS]) (struct device *dev,
>  			struct device_attribute *devattr, const char *buf,
>  			size_t count) = { NULL, NULL, NULL, NULL, NULL,
>  					store_ttarget, store_tmin };
> -	static const char *names[TOTAL_ATTRS] = {
> +	static const char *const names[TOTAL_ATTRS] = {
>  					"temp%d_label", "temp%d_crit_alarm",
>  					"temp%d_input", "temp%d_crit",
>  					"temp%d_max_alarm", "temp%d_max",
> 
Applied.

Thanks,
Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
