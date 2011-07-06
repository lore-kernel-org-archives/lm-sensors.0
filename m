From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Jul 2011 07:30:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) fix memory leak
Message-Id: <20110706093048.67cd62f7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110705195646.GA21684@nb-core2.darkstar.lan>
In-Reply-To: <20110705195646.GA21684@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Jul 2011 21:56:46 +0200, Luca Tettamanti wrote:
> The object returned by atk_gitm is dynamically allocated and must be
> freed.
> 
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> 
> ---
>  drivers/hwmon/asus_atk0110.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index dcb78a7..00e9851 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -674,6 +674,7 @@ static int atk_debugfs_gitm_get(void *p, u64 *val)
>  	else
>  		err = -EIO;
>  
> +	ACPI_FREE(ret);
>  	return err;
>  }
>  

Good catch. Applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
