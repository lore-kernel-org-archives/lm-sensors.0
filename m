From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Wed, 11 Sep 2013 19:25:05 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] hwmon: (ibmaem) Fix return value
Message-Id: <20130911192505.GD12114@blackbox.djwong.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378873192-6297-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378873192-6297-2-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks fine to me, so:
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

On Wed, Sep 11, 2013 at 09:49:49AM +0530, Sachin Kamat wrote:
> Propagate appropriate error code obtained from ipmi_create_user()
> instead of hardcoding.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  drivers/hwmon/ibmaem.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
> index e2b56a2..632f1dc 100644
> --- a/drivers/hwmon/ibmaem.c
> +++ b/drivers/hwmon/ibmaem.c
> @@ -292,7 +292,7 @@ static int aem_init_ipmi_data(struct aem_ipmi_data *data, int iface,
>  		dev_err(bmc,
>  			"Unable to register user with IPMI interface %d\n",
>  			data->interface);
> -		return -EACCES;
> +		return err;
>  	}
>  
>  	return 0;
> -- 
> 1.7.9.5
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
