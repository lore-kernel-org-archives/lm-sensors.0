From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 04 Jun 2006 17:20:09 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <44831649.4020903@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
>> It looks like I've discover yet another feature of the uguru, a bit in
>> the fan bank which seemed to be sometimes 1 sometimes 0 actually seems
>> to indicate whether a fan is present or not. I'm not 100% sure, but I'm
>> starting to see a pattern and sofar it holds in 100% of the cases I
>> have. I'll buy myself an extra 3 wire fan and put it on the aux fan
>> connectors then I'll know for sure soon enough.
>>
>> Which brings me to the question, do we want to export this to userspace
>> (I guess we do) and if we do how. May I suggest a readonly boolean
>> fan[1-x]_present?
> 
> Sure, why not. fan[1-*]_present sounds like a good idea. I wonder how
> this works physically.

I think they are just seeing if it gives any "ticks" at all, so it won't
detect a 2 wire fan even if connected to one if its headers.

And as said I'm not even sure it does that, its basicly a mistery bit in
the uguru which I think does this :)  When I have some more spare time
and renewed energy for the uGuru I'll try to connect a 3 wire fan to my
other fan headers and see what happens.

Regards,

Hans


