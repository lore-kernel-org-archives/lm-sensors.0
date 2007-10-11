From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 11 Oct 2007 11:45:56 +0000
Subject: Re: [lm-sensors] [PATCH] ibmpex: Release IPMI user if hwmon
Message-Id: <20071011114556.GE3994@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164905.GM32667@tree.beaverton.ibm.com> <20070828232504.GP32667@tree.beaverton.ibm.com> <20070911132335.GJ31992@jupiter.solarsys.private> <20070914193346.GM30825@tree.beaverton.ibm.com> <20071009120044.GP3835@jupiter.solarsys.private> <470BAFD7.10305@tiscali.nl> <20071009220824.GL16752@tree.beaverton.ibm.com>
In-Reply-To: <20071009220824.GL16752@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Roel Kluin <12o3l@tiscali.nl>, Jean Delvare <khali@linux-fr.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, haveblue@us.ibm.com

Hi:

* Darrick J. Wong <djwong@us.ibm.com> [2007-10-09 15:08:24 -0700]:
> Roel Kluin <12o3l@tiscali.nl> found a minor defect in the init code if
> hwmon device registration fails.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/hwmon/ibmpex.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
> index fe2c261..c462824 100644
> --- a/drivers/hwmon/ibmpex.c
> +++ b/drivers/hwmon/ibmpex.c
> @@ -498,8 +498,7 @@ static void ibmpex_register_bmc(int iface, struct device *dev)
>  		printk(KERN_ERR DRVNAME ": Error, unable to register hwmon "
>  		       "class device for interface %d\n",
>  		       data->interface);
> -		kfree(data);
> -		return;
> +		goto out_user;
>  	}
>  
>  	/* finally add the new bmc data to the bmc data list */

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
