From: Ben Dooks <ben@simtec.co.uk>
Date: Tue, 26 May 2009 08:01:22 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <4A1BA1D2.6090802@simtec.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ramax Lo wrote:
> 2009/5/21 Ben Dooks <ben@simtec.co.uk>
>> Add support for the ADC controller on the S3C
>> series of processors to drivers/hwmon for use with
>> hardware monitoring systems.
>>
>> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
>>
>> Index: linux.git/drivers/hwmon/Kconfig
>> =================================
[snip]

>> +/**
>> + * s3c_hwmon_adcdone - ADC core callback
>> + * @value: The value that we got from the ADC core
>> + * @ignore: Only used for the touchscreen client.
>> + * @left: The number of conversions left (not used here).
>> + *
>> + * This is called when the ADC has finished its conversion to
>> + * inform us of the result.
>> + */
>> +static void s3c_hwmon_adcdone(unsigned value, unsigned ignore, unsigned *left)
>> +{
>> +       struct s3c_hwmon *adc = done_adc;
>> +
>> +       hwmon->val = value;
>> +       wake_up(&hwmon->wait);
> 
> The variable should be 'adc'?

Yes, you're right. It seems I failed to refresh the patch before
sending it from the quilt it was in. Will check and repost.

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
