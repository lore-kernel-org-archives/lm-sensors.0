From: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date: Tue, 26 Jan 2016 10:57:35 +0000
Subject: Re: [lm-sensors] [RFC] hwmon: (fam15h_power) Add bit masking for tdp_limit
Message-Id: <56A7511F.1050205@profitbricks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453722067-6747-1-git-send-email-gi-oh.kim@profitbricks.com>
 <20160126022531.GA23394@hr-amur2>
In-Reply-To: <20160126022531.GA23394@hr-amur2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Guenter Roeck <linux@roeck-us.net>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>



On 26.01.2016 03:25, Huang Rui wrote:
> On Mon, Jan 25, 2016 at 07:41:07PM +0800, Gioh Kim wrote:
>> The bits [31:29] of D18F5xE8 TDP Limit3 are reserved.
>> I think it'd better to add masking to read ApmTdpLimit[28:16] precisely.
>>
>> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
>> ---
>>   drivers/hwmon/fam15h_power.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
>> index f77eb97..f9647c8 100644
>> --- a/drivers/hwmon/fam15h_power.c
>> +++ b/drivers/hwmon/fam15h_power.c
>> @@ -90,7 +90,7 @@ static ssize_t show_power(struct device *dev,
>>   	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
>>   				  REG_TDP_LIMIT3, &val);
>>   
>> -	tdp_limit = val >> 16;
>> +	tdp_limit = (val >> 16) & 0x1fff;
>
> Thanks to send the patch on fam15h_power driver. :-)
> In latest AMD (family 15h, Model 60h) processor, ApmTdpLimit field is
> expanded to [32:16]. The orignal reserved bits actually are reserved
> for ApmTdpLimit expansion.
>
> http://support.amd.com/TechDocs/50742_15h_Models_60h-6Fh_BKDG.pdf
>
> Guenter, Will I collect all patches of fam15h_power and send them to
> you, or ack it that you can apply directly?
>
> Thanks,
> Rui

Thanks for your reply.
I'm not completely sure that the reserved bits are always zero.
Are they always zero?
Or do we need bit-masking like following?

-------------- 8< -----------------
Subject: [PATCH] hwmon: (fam15h_power) Add bit masking for tdp_limit

Add bit masking to read ApmTdpLimit precisely

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
  drivers/hwmon/fam15h_power.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index f77eb97..edbcf6c 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -90,7 +90,11 @@ static ssize_t show_power(struct device *dev,
      pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
                    REG_TDP_LIMIT3, &val);

-    tdp_limit = val >> 16;
+    if (boot_cpu_data.x86_model >= 0x60)
+        tdp_limit = val >> 16;
+    else
+        tdp_limit = (val >> 16) & 0x1fff;
+
      curr_pwr_watts = ((u64)(tdp_limit +
                  data->base_tdp)) << running_avg_range;
      curr_pwr_watts -= running_avg_capture;
-- 
2.5.0



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
