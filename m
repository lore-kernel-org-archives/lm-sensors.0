From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Sun, 18 Oct 2009 21:25:43 +0000
Subject: Re: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <4ADB87D7.3090401@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AD1E14B.90604@shikadi.net>
In-Reply-To: <4AD1E14B.90604@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> As there doesn't seem to be any change planned in the immediate future,
> I've committed my code as is. If the name format changes upstream,
> we'll have to update libsensors accordingly.

No worries, I'll keep an eye on it.  Thanks again for your help getting it
working!

>>> I'll post instructions on what to do once the modules are loaded when I post
>>> the code shortly.
>> Great, thanks.
> 
> Unfortunately I can't seem to find the time to test it, sorry.

No problem, it's there if you ever need to verify your HID code is working
properly.

By the way, if you are still looking at buying a PSU with sensors in it, there
are a few alternatives to the Gigabyte that support nVidia's ESA:
http://www.nvidia.com/object/nvidia_certified_products.html

Of course there is no Linux support that I am aware of as yet, but as ESA is
supposed to be an open standard I wouldn't imagine it would take too long
(still waiting to hear back with specs though.)

Cheers,
Adam.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
