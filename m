From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Sep 2013 18:58:39 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <522CC8DF.70402@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/08/2013 11:36 AM, Tomas Larsson wrote:
>> -----Original Message-----
>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>> Sent: Sunday, September 08, 2013 7:47 PM
>> To: Tomas Larsson
>> Cc: lm-sensors@lm-sensors.org
>> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
>>
>> On 09/08/2013 10:15 AM, Tomas Larsson wrote:
>>> Ok, that explains things, so how to get it working, are there any
>>> aspi-drivers available?
>>>
>>
>> Please don't top-post.
>>
>> I don't think there is an acpi driver available; most of the time there
> isn't.
>> Also, looks like the acpi thermal module isn't loaded, meaning acpi may
> not
>> export the necessary thermal information at all.
>>
>> acpi drivers are highly board and vendor specific, which means that
> typically
>> no one really bothers to write a driver for it, including board vendors.
>> Besides, most of the time much of the available information from the chips
> is
>> not exported to the user through acpi, so even if you had an acpi driver
> you
>> would likely end up with limited or even no information.
>>
>> Only option I could see (besides enabling the relax option) would be to
>> disassemble the DSDT, check what is available, and if there is anything
> write a
>> driver yourself to access it.
>> By disassembling the DSDT you would also see what kind of risk you could
> run
>> into by disabling the region conflict checks.
>>
>> Guenter
>
> Ok, sorry about the posting style.
>
> Now which version should I trust, regarding temperatures.
> I don't think the 3.1.1 version is showing correct values, guessing some 20
> degrees to low or so.
>
> The 2.10.7 version is only showing "CPU-Temperature" not for the cores them
> selves.
>

Different driver. Centos 6.4 uses the coretemp driver which gets the temperature
from the CPU directly. Unfortunately, Centos 6.4 is quite old when it comes to
kernel version, and so is its coretemp driver. The displayed temperatures in your version
are all wrong; the maximum temperature for Atom 330 is 125 degrees C, not 90 degrees C.
You'll have to add 35 degrees C to the displayed temperature.

You could either update the coretemp driver to a later version to fix this,
or add the offset to /etc/sensors3.conf.

Note that CPU temperatures are notoriously unreliable.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
