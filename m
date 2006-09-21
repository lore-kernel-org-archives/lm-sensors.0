From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 08:41:43 +0000
Subject: [lm-sensors] [patch] hwmon/pc87360: update vrm setting using
Message-Id: <20060921104143.81446758.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4505F5AF.7090708@gmail.com>
In-Reply-To: <4505F5AF.7090708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> pc87360 currently hardcodes vrm = 90 (2.4 vintage).  Update it to use
> newer code in hwmon-vid which reads cpuid to determine the correct vid.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

Doesn't apply :( I guess your mailer converted the tabs to spaces or
something equally silly. Can you please resubmit (maybe as an
attachement if you can't educate Thunderbird)?

> ---
> 
> My board has an NSC SC-1100 (a 586-mmx class cpu), which is seen as 
> unknown,
> so perhaps theres more to do / investigate, but 'unknown' is certainly 
> accurate at this point.
> 
> Looking at hwmon-vid.c, I note:
> - it looks rather complete, at least for pentium 2 and up
> - there are no i586's listed, from any vendor.
> - I couldnt find anything at Intel website, or elsewhere
> 
> I reluctantly conclude that no VID standard existed back then.
> Anyone have better / contradicting info ?

As far as I know the Pentium Pro was the first one to have VID pins.
I'm pretty certain the regular Pentium (socket 7) and previous CPUs did
not have VID pins, so it comes to no surprise that the SC1100 doesn't
have any.

Thanks,
-- 
Jean Delvare

