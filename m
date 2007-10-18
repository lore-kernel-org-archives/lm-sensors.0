From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 18 Oct 2007 13:34:52 +0000
Subject: Re: [lm-sensors] [2.6 patch] hwmon/ibmpex.c: fix NULL dereference
Message-Id: <20071018133452.GB3526@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017192902.GB3778@stusta.de>
In-Reply-To: <20071017192902.GB3778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi:

* Adrian Bunk <bunk@kernel.org> [2007-10-17 21:29:02 +0200]:
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
>  

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
