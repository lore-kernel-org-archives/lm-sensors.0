From: Chris Murphy <bugzilla@colorremedies.com>
Date: Sun, 24 Nov 2013 17:02:22 +0000
Subject: Re: [lm-sensors] small regression: hwmon: (applesmc) Check key count before proceeding - 5f451386430
Message-Id: <E32ACDC7-AF59-4BD0-9CAF-02DF37806B67@colorremedies.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131124092359.4241e633@fante.int.rhx> <5291CA7B.3080904@euromail.se> <76837691-ED07-4448-BC56-9D16EA321970@colorremedies.com> <52922FDC.7070006@euromail.se>
In-Reply-To: <52922FDC.7070006@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Michele Baldessari <michele@acksyn.org>, jwboyer@fedoraproject.org, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Chris Murphy <chris@cmurf.com>


On Nov 24, 2013, at 9:57 AM, Henrik Rydberg <rydberg@euromail.se> wrote:

> Hi Chris,
> 
>> Well, it seems to be a another one off event. It's the same hardware as
> before, and it was booting from a USB stick containing Fedora 20 final test
> candidate 2 which uses kernel 3.11.8. An immediate reboot did not reproduce the
> problem, nor multiple subsequent reboots. I think I previously mentioned a
> preponderance of these events happen when booting from USB sticks.
> 
> Ok, thanks, that makes sense. So at least one problem is still there, but
> possibly very difficult to hit.
> 
>> It would be nice to have an identical model for this testing. I suspect most users wouldn't go to the trouble to report the occasional, seemingly one off,
> events like this. So unfortunately it's  uncertain if the hardware I have has a
> unique problem, or if it's a model specific behavior.
> 
> I will keep this in mind next time I see this particular model. It is also
> possible that the SMC needs to be reset after having testing various more or
> less successful patches. Given the tiny cross-section, it looks like this one
> can rest for now.

This SMC has been reset within that past week, after a rest without its battery or power for about 2 weeks. So unless the SMC is particularly prone to corruption, I think the cause is elsewhere.

OS X always says this battery needs servicing, but doesn't elaborate. The manifestation is merely limited battery life, about 1 hour. All testing is always done with power connected.


Chris Murphy
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
