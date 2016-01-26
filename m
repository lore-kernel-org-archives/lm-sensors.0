From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Jan 2016 02:43:59 +0000
Subject: Re: [lm-sensors] [RFC] hwmon: (fam15h_power) Add bit masking for tdp_limit
Message-Id: <56A6DD6F.9080704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453722067-6747-1-git-send-email-gi-oh.kim@profitbricks.com>
 <20160126022531.GA23394@hr-amur2>
In-Reply-To: <20160126022531.GA23394@hr-amur2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Gioh Kim <gi-oh.kim@profitbricks.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

On 01/25/2016 06:25 PM, Huang Rui wrote:
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

Ack is fine. No need to make things more complicated than necessary.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
