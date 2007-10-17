From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Oct 2007 20:58:50 +0000
Subject: Re: [lm-sensors] [2.6 patch] hwmon/ibmpex.c: fix NULL dereference
Message-Id: <20071017225850.7d8a9e88@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017192902.GB3778@stusta.de>
In-Reply-To: <20071017192902.GB3778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 17 Oct 2007 21:29:02 +0200, Adrian Bunk wrote:
> Don't dereference "data" when we know for sure it's NULL.
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 66bec2ef5c6d55fc30ef6ac5bb97fdfcfaf394f2 
> diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
> index c462824..e14ce3d 100644
> --- a/drivers/hwmon/ibmpex.c
> +++ b/drivers/hwmon/ibmpex.c
> @@ -457,7 +457,7 @@ static void ibmpex_register_bmc(int iface, struct device *dev)
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data) {
>  		printk(KERN_ERR DRVNAME ": Insufficient memory for BMC "
> -		       "interface %d.\n", data->interface);
> +		       "interface.\n");
>  		return;
>  	}

As a side note, dev_err() should be used instead of printk here, and
possibly in other places. Darrick, could you please send a patch fixing
this?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
