From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Aug 2007 10:23:27 +0000
Subject: Re: [lm-sensors] [PATCH 4/8] sis5595: re-use s_bridge->revision
Message-Id: <20070828122327.6fa219cc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827231655.27448.9252.stgit@localhost.localdomain>
In-Reply-To: <20070827231655.27448.9252.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Auke,

On Mon, 27 Aug 2007 16:17:01 -0700, Auke Kok wrote:
> Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
> Cc: lm-sensors@lm-sensors.org
> ---
> 
>  drivers/hwmon/sis5595.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
> index 92956eb..3d20a0c 100644
> --- a/drivers/hwmon/sis5595.c
> +++ b/drivers/hwmon/sis5595.c
> @@ -517,7 +517,7 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, data);
>  
>  	/* Check revision and pin registers to determine whether 4 or 5 voltages */
> -	pci_read_config_byte(s_bridge, PCI_REVISION_ID, &data->revision);
> +	data->revision = s_bridge->revision;
>  	/* 4 voltages, 1 temp */
>  	data->maxins = 3;
>  	if (data->revision >= REV2MIN) {

I didn't know this revision field existed. Good cleanup, thanks.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
