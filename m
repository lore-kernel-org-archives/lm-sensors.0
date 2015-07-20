From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jul 2015 14:45:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) remove duplicate pci-id define
Message-Id: <55AD0972.9070201@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437133879-5352-1-git-send-email-adamm@zombino.com>
In-Reply-To: <1437133879-5352-1-git-send-email-adamm@zombino.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/17/2015 04:51 AM, Adam Majer wrote:
> PCI_DEVICE_ID_AMD_15H_M60H_NB_F3 is now defined in pci_ids.h
>
> Signed-off-by: Adam Majer <adamm@zombino.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Jean, do you want to take that one, or should I take it ?

Thanks,
Guenter

> ---
>   drivers/hwmon/k10temp.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 1e7bdcd..9cdfde6 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -60,7 +60,6 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>    * Control]
>    */
>   #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
> -#define PCI_DEVICE_ID_AMD_15H_M60H_NB_F3	0x1573
>
>   static void amd_nb_smu_index_read(struct pci_dev *pdev, unsigned int devfn,
>   				  int offset, u32 *val)
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
