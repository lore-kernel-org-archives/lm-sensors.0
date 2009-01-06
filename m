From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 06 Jan 2009 08:20:35 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <49631453.4060208@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Luca Tettamanti wrote:
> Il Mon, Jan 05, 2009 at 08:00:49PM +0100, Hans de Goede ha scritto: 
>> Luca Tettamanti wrote:
>>> Il Sun, Jan 04, 2009 at 11:13:30PM +0100, Hans de Goede ha scritto: 
>>>> Luca Tettamanti wrote:
>>>>> It was simpler than I thought: I implemented per-attribute caching since
>>>>> updating all the values may take a long time (here unconnected fans take
>>>>> about 0.5s); the interval between reading is 1s (due to the high latency
>>>>> of the fan sensor it probably makes little sense to lower this value).
>>>> Erm, your current code is not correct (as in will not work under all  
>>>> circumstances). Your current code initializes last_updated to 0 for 
>>>> all new sensors, and you do not use a valid flag (as the other hwmon 
>>>> drivers do).
>>> Ah, I see... how about this:
>> Erm, sorry, but no that won't work. You've a last_updated per sensor, so 
>> the valid flag needs to be per sensor too, otherwise you will just hit 
>> the possible bug I described with the second sensor read.
> 
> Duh, of course...
> 

Looks good now :)

So once we can get the acpi_enforce_resources changed, this is good to go in to 
the mainline.

I was sortof waiting for Jean Delvare to resurface from the hollidays to get 
some input from him on this, but given that the 2.6.29 merge window has already 
opened, I think it would be best for us to move forward with this ourselves.

Can you please mail the acpi mailinglist, proposing to make the default strict, 
with explanation why?

Some notes which will be worthwhile to make in that mail:
1) I've checked all users of the affected functions and only hwmon superio IC's 
and smbus controllers will be affected by this change.

2) This can cause smbus controllers / superIO drivers to not load in 2.6.29, 
which could be seen as a regression by some (they would loose monitoring 
ability). I consider this not a bug, but a feature, if the firmware claims the 
resources we should not touch them. If they really want to live with the 
dangers this brings, let them pass in a kernel cmdline option to get the old 
wrong behaviour.

Please CC me on the mail :)

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
