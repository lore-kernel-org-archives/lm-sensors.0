From: Huang Rui <ray.huang@amd.com>
Date: Wed, 27 Jan 2016 06:45:38 +0000
Subject: Re: [lm-sensors] [RFC] hwmon: (fam15h_power) Add bit masking for tdp_limit
Message-Id: <20160127064537.GA25036@hr-amur2>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453722067-6747-1-git-send-email-gi-oh.kim@profitbricks.com>
 <20160126022531.GA23394@hr-amur2>
 <56A7511F.1050205@profitbricks.com>
In-Reply-To: <56A7511F.1050205@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

On Tue, Jan 26, 2016 at 11:57:35AM +0100, Gi-Oh Kim wrote:
> 
> 
> On 26.01.2016 03:25, Huang Rui wrote:
> >On Mon, Jan 25, 2016 at 07:41:07PM +0800, Gioh Kim wrote:

> Thanks for your reply.
> I'm not completely sure that the reserved bits are always zero.
> Are they always zero?
> Or do we need bit-masking like following?
> 

Reserved bits aren't always zero. But here they are reserved for
ApmTdpLimit expansion.

Yes, we would better add bit-masking here. :-)

> -------------- 8< -----------------
> Subject: [PATCH] hwmon: (fam15h_power) Add bit masking for tdp_limit
> 
> Add bit masking to read ApmTdpLimit precisely
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> ---
>  drivers/hwmon/fam15h_power.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index f77eb97..edbcf6c 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -90,7 +90,11 @@ static ssize_t show_power(struct device *dev,
>      pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
>                    REG_TDP_LIMIT3, &val);
> 
> -    tdp_limit = val >> 16;
> +    if (boot_cpu_data.x86_model >= 0x60)
> +        tdp_limit = val >> 16;

You need add CPU family check and a comment to mention bit field
change. This updates since family 15h and model 60h.

if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model >= 0x60)

Thanks,
Rui

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
