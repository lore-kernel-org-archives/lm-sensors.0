From: Stefan Sassenberg <stefan.sassenberg@gmx.de>
Date: Fri, 07 Mar 2008 15:30:15 +0000
Subject: Re: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <47D15F87.8020103@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <47CD5B89.1070302@gmx.de>
In-Reply-To: <47CD5B89.1070302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 07 Mar 2008 15:34:47 +0100, Stefan Sassenberg wrote:
>> Jean Delvare wrote:
>>> Hi Stefan,
>>>
>>> On Fri, 07 Mar 2008 11:57:11 +0100, Stefan Sassenberg wrote:
>>>> Jean Delvare wrote:
>>>>> Huu, that's not what I suggested. Leave the adm1021, adm1025, adm1026,
>>>>> adm1029 and adm1031 drivers alone, they won't work for you. Instead,
>>>>> try loading the lm85 driver that way:
>>>>>
>>>>> modprobe lm85 force_adm1027=0,0x2e
>>>>>
>>>>> As you are using lm-sensors 2.10.1 with a recent kernel, it is possible
>>>>> that libsensors won't work properly with the forced ADM1027 chip, but
>>>>> at least you should be able to read some temperature values directly
>>>>> from /sys/class/hwmon.
>>>> Excellent hint. Since I don't need the values human readable but 
>>>> automated, I can now read the values from a file, eventually convert 
>>>> them from Fahrenheit to Celsius, et voila. And it works for all my four 
>>>> types of mainboard.
>>> The sysfs values are in 1/1000 of Celsius, so converting them "from
>>> Fahrenheit to Celsius" wouldn't make much sense.
>> Yes, except for the "lm85 force_adm1027=0,0x2e" (see above). Those are 
>> either in mFahrenheit or they are just nonsense and make sense when 
>> converted to Celsius. Could that be?
> 
> They are mCelsius, really. If they don't make sense, it means that the
> trick of forcing the adm1027 didn't work as expected...

Well, in that case, I think I have to consider that mainboard type 
unsupported. Of course, the offer persists. :-)

Stefan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
