From: Henrik Rydberg <rydberg@euromail.se>
Date: Thu, 26 Sep 2013 11:11:51 +0000
Subject: Re: [lm-sensors] applesmc oops in 3.10/3.11
Message-Id: <20130926111151.GA2194@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+5PVA5mmLPEqM2r5=fBN4sM4LLacynn8R1tewObsX35e4_TfA@mail.gmail.com>
 <20130925195628.GA1532@roeck-us.net>
 <20130925214807.GA3234@polaris.bitmath.org>
 <20130925220838.GB4184@roeck-us.net>
 <20130926063453.GA526@polaris.bitmath.org>
 <5244121B.7070904@roeck-us.net>
In-Reply-To: <5244121B.7070904@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, khali@linux-fr.org, lm-sensors@lm-sensors.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, bugzilla@colorremedies.com

> Applied. I'll run my sanity tests before I send it upstream.
> I'll also Cc: stable.

Great.

> Interesting is that this started to happen with 3.10, even though
> I did not find any relevant changes in the driver. Is it possible that
> changed boot timing (ie reduced boot time) exposes this problem ?

I was thinking the same thing - if the SMC takes some time to boot up,
it could very well be the culprit. Imagine that, the kernel is too
fast. ;-)

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
