From: lmsensorslist@nodivisions.com
Date: Thu, 11 Mar 2010 20:38:05 +0000
Subject: Re: [lm-sensors] Wrong temperatures reported for Core2Duo CPU in
Message-Id: <f4f807d0219cd01d74100b59ee5dbde3.squirrel@webmail.nodivisions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
In-Reply-To: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Today I installed Windows XP on this same system, to see what it would
> report for the core temperatures.  I installed 3 apps for this: SpeedFan,
> Core Temp, and Real Temp.  Here's what they reported while idle and after
> 10 minutes of high load (all 3 temperature apps reporting simultaneously):
>
> SpeedFan: idle 49C, loaded 70C
> Core Temp: idle 54C, loaded 75C
> Real Temp: idle 59C, loaded 80C
>
> The Core Temp & Real Temp apps explicitly show what they're using for
> TjMax: 85C and 90C respectively.  And from the idle/load temps it looks
> like SpeedFan is probably using 80C.  lm-sensors/coretemp are 10 degrees
> higher still.
>
> So which is correct?  Is the TjMax value published by Intel, and/or
> definitively known to be a certain value?  I searched intel.com and the
> datasheet for my CPU (the E6600) but didn't see it.  And this tomshardware
> piece seems to say that Intel deliberately obfuscates this information
> (read the update at the bottom):
>
> http://www.tomshardware.com/news/intel-dts-specs,6517.html
>
> If SpeedFan is correct, I feel much better about my CPU; but if
> lm-sensors/coretemp is right, I'm more worried.


Sorry for the double-post, but I meant to re-iterate just for
completeness' sake: the idle/loaded temps reported by lm-sensors+coretemp
under Linux are ~73C/93C, in contrast to the lower temperatures reported
by the 3 Windows apps mentioned above.

Thanks,

--
Anthony DiSante
http://nodivisions.com/



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
