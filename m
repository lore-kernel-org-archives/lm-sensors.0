From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 05 Jan 2009 19:00:49 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <496258E1.4070102@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Luca Tettamanti wrote:
> Il Sun, Jan 04, 2009 at 11:13:30PM +0100, Hans de Goede ha scritto: 
>> Luca Tettamanti wrote:
>>> It was simpler than I thought: I implemented per-attribute caching since
>>> updating all the values may take a long time (here unconnected fans take
>>> about 0.5s); the interval between reading is 1s (due to the high latency
>>> of the fan sensor it probably makes little sense to lower this value).
>> Erm, your current code is not correct (as in will not work under all  
>> circumstances). Your current code initializes last_updated to 0 for all 
>> new sensors, and you do not use a valid flag (as the other hwmon drivers 
>> do).
> 
> Ah, I see... how about this:
> 

Erm, sorry, but no that won't work. You've a last_updated per sensor, so the 
valid flag needs to be per sensor too, otherwise you will just hit the possible 
bug I described with the second sensor read.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
