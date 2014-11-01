From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Sat, 01 Nov 2014 17:52:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (ibmpowernv) Quieten when probing finds no device
Message-Id: <54551CDB.2090407@linux.vnet.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1414737923-8227-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1414737923-8227-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 10/31/2014 11:42 PM, Guenter Roeck wrote:
> On Fri, Oct 31, 2014 at 05:45:22PM +1100, Michael Ellerman wrote:
>> Because we build kernels with drivers built in for many platforms, it's
>> normal for the ibmpowernv driver to be loaded on systems that don't have
>> the appropriate hardware.
>>
>> Currently the driver spams the log with:
>>
>>    ibmpowernv ibmpowernv.0: Opal node 'sensors' not found
>>    ibmpowernv: Platfrom driver probe failed
>>
>> But there is no error, this machine is not a powernv and doesn't have
>> the hardware. So change the sensors message to dev_dbg(), and only print
>> an error about the probe failing if it's not ENODEV.
>>
>> Also fix the spelling of "Platfrom" and print the actual error value.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Neelesh,
>
> is there a compatible property in the powernv devicetree which can be
> used to identify the system ?

I think the driver should not be loaded at first place on *non* powernv 
platforms.
Still, we can improve by introducing 'platform_driver.id_table' and 
moving the
platform device creation code in platform init 'opal-sensor.c' using
of_platform_device_create() and just do driver register in module init.

- Neelesh

>
> I am ok with applying this patch for the time being, but it would be better
> if we can change the driver to only instantiate when actually needed.
>
> Thanks,
> Guenter
>
>> ---
>>   drivers/hwmon/ibmpowernv.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>> index d2bf2c97ae70..6a30eeea94be 100644
>> --- a/drivers/hwmon/ibmpowernv.c
>> +++ b/drivers/hwmon/ibmpowernv.c
>> @@ -181,7 +181,7 @@ static int __init populate_attr_groups(struct platform_device *pdev)
>>   
>>   	opal = of_find_node_by_path("/ibm,opal/sensors");
>>   	if (!opal) {
>> -		dev_err(&pdev->dev, "Opal node 'sensors' not found\n");
>> +		dev_dbg(&pdev->dev, "Opal node 'sensors' not found\n");
>>   		return -ENODEV;
>>   	}
>>   
>> @@ -335,7 +335,9 @@ static int __init ibmpowernv_init(void)
>>   
>>   	err = platform_driver_probe(&ibmpowernv_driver, ibmpowernv_probe);
>>   	if (err) {
>> -		pr_err("Platfrom driver probe failed\n");
>> +		if (err != -ENODEV)
>> +			pr_err("Platform driver probe failed (%d)\n", err);
>> +
>>   		goto exit_device_del;
>>   	}
>>   
>> -- 
>> 1.9.1
>>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
