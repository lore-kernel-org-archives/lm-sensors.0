From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Sep 2011 12:27:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Avoid leaving around
Message-Id: <20110928142752.73b46ce5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316903589-28009-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316903589-28009-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Once again sorry for the late review. At this rate I'm going to add
this to my signature :(

On Sat, 24 Sep 2011 15:33:09 -0700, Guenter Roeck wrote:
> Storing the struct temp_data pointer allocated from create_core_data()
> when returning an error has the potential of leaving around a pointer
> to freed memory. Reset it to NULL for error returns.
> 
> Reported-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> I want to send the pending patches to Linus, and include a fix for the problem
> reported by Jan. So here it is.
> 
>  drivers/hwmon/coretemp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 44b2391..5100b01 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -508,6 +508,7 @@ static int create_core_data(struct platform_device *pdev,
>  
>  	return 0;
>  exit_free:
> +	pdata->core_data[attr_no] = NULL;
>  	kfree(tdata);
>  	return err;
>  }

Yes, obviously correct and the right thing to do.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
