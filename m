From: Chris Murphy <bugzilla@colorremedies.com>
Date: Sun, 24 Nov 2013 16:22:52 +0000
Subject: Re: [lm-sensors] small regression: hwmon: (applesmc) Check key count before proceeding - 5f451386430
Message-Id: <76837691-ED07-4448-BC56-9D16EA321970@colorremedies.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131124092359.4241e633@fante.int.rhx> <5291CA7B.3080904@euromail.se>
In-Reply-To: <5291CA7B.3080904@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Michele Baldessari <michele@acksyn.org>, jwboyer@fedoraproject.org, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Chris Murphy <chris@cmurf.com>


On Nov 24, 2013, at 2:44 AM, Henrik Rydberg <rydberg@euromail.se> wrote:

> Hi Michele,
> 
>> The issue Chris has seen in Fedora on one MacBookPro4,1
>> (https://bugzilla.redhat.com/show_bug.cgi?id33414) is that this
>> machine returns a huge number from read_register_count() so now we will
>> try to allocate an insane amount of memory and we will barf:
>> [    8.603053] applesmc: key count changed from 261 to 1392508929
> 
> I was under the impression that this machine was tested before, and that
> 
> commit 25f2bd7f5add608c1d1405938f39c96927b275ca
> Author: Henrik Rydberg <rydberg@euromail.se>
> Date:   Wed Oct 2 19:15:03 2013 +0200
> 
>    hwmon: (applesmc) Always read until end of data
> 
> resolved this problem? But if the kernel under test is 3.11.8, both patches are
> already present... Chris, could you please sched some light on this before
> moving on?

Well, it seems to be a another one off event. It's the same hardware as before, and it was booting from a USB stick containing Fedora 20 final test candidate 2 which uses kernel 3.11.8. An immediate reboot did not reproduce the problem, nor multiple subsequent reboots. I think I previously mentioned a preponderance of these events happen when booting from USB sticks.

It would be nice to have an identical model for this testing. I suspect most users wouldn't go to the trouble to report the occasional, seemingly one off, events like this. So unfortunately it's  uncertain if the hardware I have has a unique problem, or if it's a model specific behavior.


Chris Murphy
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
