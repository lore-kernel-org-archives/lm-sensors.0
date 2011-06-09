From: Donggeun Kim <dg77.kim@samsung.com>
Date: Thu, 09 Jun 2011 05:38:05 +0000
Subject: Re: [lm-sensors] [PATCH v4] drivers/hwmon NTC Thermistor Initial
Message-Id: <4DF05C3D.70500@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307532911-2185-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1307532911-2185-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 06월 09일 00:10, Guenter Roeck wrote:
(snip)
> 
> else statement is not needed here.
> 
(snip)
> 
> This implementation is quite expensive. Can you consider using binary search
> instead ?
> 
I will use binary search at the next version.
(snip)
> 
> You want to return ret here. Sure, it is the same, but that may change and you want
> to return the original error, not replace it.
> 
(snip)
> Please use { } in the else statement as well (CodingStyle, chapter 3).
> 
(snip)
> 
> This overrides the original return value if set. The case should never happen,
> so you might want to use else above. Besides, either read_ohm or read_uV must be set,
> or ret won't even be initialized. A simple if/else (without checking if read_uV
> is actually set) should be sufficient here. And you can improve readability with
> 
> 	int ret;
> 	unsigned int ohm;
> 
> 	if (data->pdata->read_ohm)
> 		ohm = data->pdata->read_ohm();
> 	else
> 		ohm = get_ohm_of_thermistor(data, data->pdata->read_uV());
> 
> 	ret = get_temp_mC(data, ohm, temp);
> 
> One concern I have is that read_ohm() and read_uV() don't return errors. This may be true
> for the current back-end driver, but may not be true for future drivers. I would suggest 
> to declare the function return codes as "int" and support (and check) error return values.
> 
OK, I will fix it.
(snip)
> 
> else is not needed here.
> 
(snip)
> 
> You want to return ret here, not the error code converted into a string.
> 
(snip)
> 
> Do _min and _max have any real value here ? What happens if a temperature is outside the 
> reported range ? Seems all you do is to report the lowest/highest temperatures supported
> by the conversion functions, but there is no alarm associated with it nor does it really
> have a practical effect. 
> In other words, all it does is to report the temperature range supported by the driver
> for a given chip, which isn't the idea. I would suggest to drop those attributes.
> 
(snip)
> 
> Odd comment, doesn't provide any value. Please remove.
> 
(snip)
> You want to set this to NULL prior to releasing the memory.
> 
I will follow all suggestions at the next patch.

Thank you.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
