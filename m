From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 04 Jan 2009 22:13:30 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <4961348A.3060100@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Luca Tettamanti wrote:
> Il Sun, Jan 04, 2009 at 08:14:25PM +0100, Hans de Goede ha scritto: 
>> Luca Tettamanti wrote:
>>> 2 has been taken care of
>> Nice! One small mistake though, you forgot to do the value *= 100 when 
>> its a temp sensor in the show_limitX functions.
> 
> Ops, fixed.
> 
>>> will do 3.
>> Ok.
> 
> It was simpler than I thought: I implemented per-attribute caching since
> updating all the values may take a long time (here unconnected fans take
> about 0.5s); the interval between reading is 1s (due to the high latency
> of the fan sensor it probably makes little sense to lower this value).
> 

Erm, your current code is not correct (as in will not work under all 
circumstances). Your current code initializes last_updated to 0 for all new 
sensors, and you do not use a valid flag (as the other hwmon drivers do).

Notice that jiffies can wrap! And time_after handles this, so to make this easy 
lets say that the jiffies counter is only 8 bits, then a counter value of 128 
is not after 0, but rather before. So if your driver gets loaded (or is not 
used before) the jiffies counter reaching over half its range, then the current 
time will be seen as before the 0 init value of last_updated, so no update will 
be done. This is why all the other hwmon drivers have a combo of a valid flag 
and a last_updated counter, and first check the flag, and only when that is set 
(which happens after the first caching, when last_updated also gets set to 
something sane) then check the last_updated counter.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
