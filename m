From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Sep 2013 23:01:05 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <522D01B1.2090408@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/08/2013 02:47 PM, Tomas Larsson wrote:
>> -----Original Message-----
>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>> Sent: Sunday, September 08, 2013 11:41 PM
>> To: Tomas Larsson; LM Sensors
>> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
>>
>> On 09/08/2013 02:27 PM, Tomas Larsson wrote:
>>>> -----Original Message-----
>>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>>> Sent: Sunday, September 08, 2013 11:20 PM
>>>> To: Tomas Larsson
>>>> Cc: 'Jean Delvare'; lm-sensors@lm-sensors.org
>>>> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
>>>>
>>>> On 09/08/2013 01:01 PM, Tomas Larsson wrote:
>>>>>> -----Original Message-----
>>>>>> From: Jean Delvare [mailto:khali@linux-fr.org]
>>>>>> Sent: Sunday, September 08, 2013 9:10 PM
>>>>>> To: Guenter Roeck
>>>>>> Cc: Tomas Larsson; lm-sensors@lm-sensors.org
>>>>>> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
>>>>>>
>>>>>> On Sun, 08 Sep 2013 11:58:39 -0700, Guenter Roeck wrote:
>>>>>>> Different driver. Centos 6.4 uses the coretemp driver which gets
>>>>>>> the temperature from the CPU directly. Unfortunately, Centos 6.4
>>>>>>> is quite old when it comes to kernel version, and so is its
>>>>>>> coretemp
>>> driver.
>>>>>>> The displayed temperatures in your version are all wrong; the
>>>>>>> maximum
>>>>>> temperature for Atom 330 is 125 degrees C, not 90 degrees C.
>>>>>>> You'll have to add 35 degrees C to the displayed temperature.
>>>>>>>
>>>>>>> You could either update the coretemp driver to a later version to
>>>>>>> fix this, or add the offset to /etc/sensors3.conf.
>>>>>>>
>>>>>>> Note that CPU temperatures are notoriously unreliable.
>>>>>>
>>>>>> "Inaccurate in the low temperature range" is a better way to
>>>>>> describe the situation IMHO. The coretemp values are reliably
>>>>>> telling the user when the temperature gets too close to the high
> limit.
>>>>>>
>>>>>> --
>>>>>> Jean Delvare
>>>>>
>>>>> Well, I'm aware of that, what I want to know is when the fan fails,
>>>>> these 40mm fans are not that reliable, unfortunately.
>>>>
>>>> Not sure if you can use the cpu temperature to predict if the fans
>>>> are
>>> working
>>>> or not. The CPU can get pretty hot under load, even with the fans
> working.
>>>>
>>>> Your initial e-mail showed the fan speeds as 0. Are they broken or
>>>> turned
>>> off
>>>> or not connected to the fan speed sensors ?
>>>>
>>>> Guenter
>>>
>>> Haven't got a clue why it says that they are 0, they definitely work
>>> now (changed the fans today), They are 3-pins and connected to the
>>> correct header.
>>>
>>
>> Do you get a non-zero speed reported after replacing the fans ? If the
>> reported speed is still 0, I am not sure I understand what is going on.
>>
>> Guenter
>
> Yes.
> Haven't checked what BIOS reports though, if it reports any fan-speeds.
>

Number of possibilities. Looks like the chip doesn't monitor fan speeds if pwm is 0.
So you should check for that. File should be /sys/class/hwmon/hwmonX/pwmY,
where X is either 0 or 1 and Y is 1 and 2.

Second, it may be that the fan divisor value (same directory) is too low or too high.
Try setting it to different values. 1, 2. 4, and 8 are permitted.

Third, it may be that the preload value is off. It is controlled with the "fanX_min"
attribute. Try setting a lower minimum speed (eg 500). If that doesn't work,
set the minimum speed to something really high.

In other words, play with the _div and _min attributes to see if you can get
a speed output.

But of course checking the BIOS would be a really good idea.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
