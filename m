From: Roland Stigge <stigge@antcom.de>
Date: Tue, 21 Feb 2012 08:41:21 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <4F4358B1.2010606@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 02/21/2012 12:57 AM, Guenter Roeck wrote:
> Patch #3 under the same headline .. unless I lost count :-(. I actually did
> miss the original patch (thinking it was a reply), and only caught this one
> since I wondered why you acked the other patch twice.
> 
> What is wrong with the original calculation ?

The original speed/RPM calculation included data->ppr in a wrong way. I
also needed to re-read the datasheet. See also "Table 7,
RPM-to-Tachometer Count Relationship Examples" and the printed formula
where the actual PPR value is removed from by "selected number of pulses
per revolution / actual fan pulses".


>>> -#define FAN_FROM_REG(val, div, rpm_range)	((val) = 0 ? -1 : \
>>> -	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / ((div + 1) * (val)))
>>> +#define FAN_FROM_REG(val, rpm_range)	((val) = 0 ? -1 : \
>>> +	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / val)
>>>  #define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val) / 1000, 0, 255)
>>>
>>>  /*
>>> @@ -333,7 +333,7 @@ static ssize_t show_fan_input(struct dev
>>>  		return PTR_ERR(data);
>>>
>>>  	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
>>> -		       data->ppr, data->rpm_range));
>>> +		       data->rpm_range));
> 
> This is a bit problematic. Always was, actually. If val=0 it returns a fan speed of -1,
> which does not make much sense. It should either return 0, or some kind of error.

Agreed!

Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
