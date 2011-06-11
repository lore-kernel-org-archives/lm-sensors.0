From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Jun 2011 09:36:07 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (ibmaem) Initialize sysfs
Message-Id: <20110611113607.31284c94@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306267814-31505-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306267814-31505-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 May 2011 13:10:12 -0700, Guenter Roeck wrote:
> Initialize dynamically allocated sysfs attributes before device_create_file()
> call to suppress lockdep_init_map() warning if lockdep debugging is enabled.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Compile tested only.

Can't test either, but looks good to me:

Acked-by: Jean Delvare <khali@linux-fr.org>

Candidate for stable series?

> 
>  drivers/hwmon/ibmaem.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
> index bc6e2ab..affc17e 100644
> --- a/drivers/hwmon/ibmaem.c
> +++ b/drivers/hwmon/ibmaem.c
> @@ -947,6 +947,7 @@ static int aem_register_sensors(struct aem_data *data,
>  
>  	/* Set up read-only sensors */
>  	while (ro->label) {
> +		sysfs_attr_init(&sensors->dev_attr.attr);
>  		sensors->dev_attr.attr.name = ro->label;
>  		sensors->dev_attr.attr.mode = S_IRUGO;
>  		sensors->dev_attr.show = ro->show;
> @@ -963,6 +964,7 @@ static int aem_register_sensors(struct aem_data *data,
>  
>  	/* Set up read-write sensors */
>  	while (rw->label) {
> +		sysfs_attr_init(&sensors->dev_attr.attr);
>  		sensors->dev_attr.attr.name = rw->label;
>  		sensors->dev_attr.attr.mode = S_IRUGO | S_IWUSR;
>  		sensors->dev_attr.show = rw->show;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
