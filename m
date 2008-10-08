From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Oct 2008 11:13:02 +0000
Subject: Re: [lm-sensors] [PATCH 08/12] i5k_amb: Load automatically on all
Message-Id: <20081008131302.5dfd4bb4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
	<20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-scsi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Darrick,

On Mon, 06 Oct 2008 18:19:04 -0700, Darrick J. Wong wrote:
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/hwmon/i5k_amb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index 2ede938..bf153ae 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -605,3 +605,6 @@ MODULE_LICENSE("GPL");
>  
>  module_init(i5k_amb_init);
>  module_exit(i5k_amb_exit);
> +
> +MODULE_ALIAS("pci:v00008086d000025F0sv*sd*bc*sc*i*");
> +MODULE_ALIAS("pci:v00008086d00004030sv*sd*bc*sc*i*");

This looks wrong to me. If these PCI devices provide the feature this
driver supports, then why is this a platform driver and not a PCI
driver? You would get the right module aliases for free.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
