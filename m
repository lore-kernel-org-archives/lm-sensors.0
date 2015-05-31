From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 May 2015 15:31:08 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (atxp1) Drop auto-detection
Message-Id: <556B293C.7080102@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432931265-21499-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432931265-21499-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 05/31/2015 06:09 AM, Jean Delvare wrote:
> On Sat, 30 May 2015 11:17:28 -0700, Guenter Roeck wrote:
>> On 05/29/2015 01:27 PM, Guenter Roeck wrote:
>>> Auto-detection for this chip is highly unreliable, and one of its
>>> I2C addresses can also be used by EEPROMs, increasing the risk for
>>> false positives even more. Drop auto-detection entirely to remove
>>> the risk.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> v2: Add text describing the supported I2C addresses, and that the driver
>>>       must be instantiated explicitly.
>>>       Validate supported vrm values in probe function.
>>>
>> [ ... ]
>>
>>> -
>>>    static int atxp1_probe(struct i2c_client *client,
>>>    		       const struct i2c_device_id *id)
>>>    {
>>> @@ -309,6 +269,11 @@ static int atxp1_probe(struct i2c_client *client,
>>>
>>>    	/* Get VRM */
>>>    	data->vrm = vid_which_vrm();
>>> +	if (data->vrm != 90 && data->vrm != 91) {
>>> +		 dev_err(&adapter->dev, "atxp1: Not supporting VRM %d.%d\n",
>
> You have a stray space before "dev_err".
>
>>> +			 data->vrm / 10, data->vrm % 10);
>>
>> s/&adapter->//
>>
>> Compile testing is always a good idea.
>
> After fixing both issues:
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Fixed. Thanks a lot for the reviews!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
