From: Henrik Rydberg <rydberg@euromail.se>
Date: Sun, 24 Nov 2013 09:44:27 +0000
Subject: Re: [lm-sensors] small regression: hwmon: (applesmc) Check key count before proceeding - 5f451386430
Message-Id: <5291CA7B.3080904@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131124092359.4241e633@fante.int.rhx>
In-Reply-To: <20131124092359.4241e633@fante.int.rhx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michele Baldessari <michele@acksyn.org>
Cc: jwboyer@fedoraproject.org, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, bugzilla@colorremedies.com, Chris Murphy <chris@cmurf.com>

Hi Michele,

> The issue Chris has seen in Fedora on one MacBookPro4,1
> (https://bugzilla.redhat.com/show_bug.cgi?id33414) is that this
> machine returns a huge number from read_register_count() so now we will
> try to allocate an insane amount of memory and we will barf:
> [    8.603053] applesmc: key count changed from 261 to 1392508929

I was under the impression that this machine was tested before, and that

commit 25f2bd7f5add608c1d1405938f39c96927b275ca
Author: Henrik Rydberg <rydberg@euromail.se>
Date:   Wed Oct 2 19:15:03 2013 +0200

    hwmon: (applesmc) Always read until end of data

resolved this problem? But if the kernel under test is 3.11.8, both patches are
already present... Chris, could you please sched some light on this before
moving on?

Thanks,
Henrik


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
