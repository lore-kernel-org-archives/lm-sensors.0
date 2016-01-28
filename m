From: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date: Thu, 28 Jan 2016 09:02:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (fam15h_power) Add bit masking for tdp_limit
Message-Id: <56A9D93E.6090508@profitbricks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453892529-17120-1-git-send-email-gi-oh.kim@profitbricks.com>
 <20160127111256.GG30712@pd.tnic> <20160128022538.GB26655@hr-amur2>
In-Reply-To: <20160128022538.GB26655@hr-amur2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org



On 28.01.2016 03:25, Huang Rui wrote:
> On Wed, Jan 27, 2016 at 12:12:56PM +0100, Borislav Petkov wrote:
>> On Wed, Jan 27, 2016 at 12:02:09PM +0100, Gioh Kim wrote:
>>> Add bit masking to read ApmTdpLimit precisely
>>>
>>> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
>>> ---
>>>   drivers/hwmon/fam15h_power.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
>>> index f77eb97..4f695d8 100644
>>> --- a/drivers/hwmon/fam15h_power.c
>>> +++ b/drivers/hwmon/fam15h_power.c
>>> @@ -90,7 +90,15 @@ static ssize_t show_power(struct device *dev,
>>>   	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
>>>   				  REG_TDP_LIMIT3, &val);
>>>   
>>> -	tdp_limit = val >> 16;
>>> +	/*
>>> +	 * On Carrizo and later platforms, ApmTdpLimit bit field
>>> +	 * is extended to 16:31 from 16:28.
>>> +	 */
>>> +	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model >= 0x60)
>>> +		tdp_limit = val >> 16;
>>> +	else
>>> +		tdp_limit = (val >> 16) & 0x1fff;
>>> +
>>>   	curr_pwr_watts = ((u64)(tdp_limit +
>>>   				data->base_tdp)) << running_avg_range;
>>>   	curr_pwr_watts -= running_avg_capture;
>>> -- 
>> Acked-by: Borislav Petkov <bp@suse.de>
>>
>> Btw, Rui, you could consider unifying the code under a single
>>
>> 	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model >= 0x60) {
>> 		...
>>
>> 	else
>> 		...
>>
>> as with this patch you'll have two of those checks. Unified might be
>> better readable but that is for another patch.
>>
> Make sence, I will do that. :-)
>
> Thanks,
> Rui
Agree. It'll be better.
Thank you.


-- 
Best regards,
Gi-Oh Kim


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
