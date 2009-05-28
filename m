From: Ben Dooks <ben@simtec.co.uk>
Date: Thu, 28 May 2009 13:16:49 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <4A1E8EC1.4020108@simtec.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 28 May 2009 12:22:41 +0100, Ben Dooks wrote:
>> Jean Delvare wrote:
>>> On Tue, 26 May 2009 09:07:01 +0100, Ben Dooks wrote:
>>>> +	int			val;
>>> This is an horribly vague struct member name, and undocumented at that.
>> Added documentation and renamed to ret_val.
>>
>>   * @ret_val: Value returned from current conversion to return to caller.
> 
> This seems artificially complex. You need to wait for the conversion to
> complete anyway, so why bother with an asynchronous mechanism?

I'll add a sync conversion call to the adc core driver
and this'll get rid of both of these.

> 
>>>> +static struct s3c_hwmon *done_adc;
>>> What is this?
>> The core adc driver doesn't keep any private data, so we need
>> this to get back to our state when the conversion ends.
> 
> This will break if you have two "s3c-hwmon" devices on the same system.
> Why don't you just fix the core adc driver?
> 
> 
>>>> +	ret *= cfg->mult;
>>>> +	ret /= cfg->div;
>>> Division lacks rounding.
>> Which rounding should be used?
> 
> DIV_ROUND_CLOSEST()

ok, will change.

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
