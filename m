From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Upcoming rpms: i2c headers under /usr/include/i2c
Message-Id: <20050102112613.0c184f48.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041230173527.GF10397@neu.nirvana>
In-Reply-To: <20041230173527.GF10397@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Please note that almost all headers included in lm_sensors are not
> > supposed to be "exported" to /usr/include (or whatever) since they
> > really are headers for kernel space, not user space.
> 
> Where should kernel space headers for building depending kernel
> modules go? You need the "i2c-kernheaders" at least for building the
> lm_sensors kernel modules.

Damn. I completely missed that. At the moment I removed the headers
export from i2c, I was mostly thinking of the patch-the-kernel
installation option, which goes fine without exporting the headers, of
course. I also remembered that "user-space should not include
kernel-space headers", and I completely forgot that lm_sensors actually
needs these ones. I had no problem when testing because I had "old"
headers remaining from before the change, which were recent enough to
work OK. Unfortunately, it won't work for other people out there because
1* they might not have any "old" version if they install i2c for the
first time and 2* the important compatibility changes I made make the
2.8.x versions useless anyway.

Ticket #1857 shows the problem. I expect many similar complaints in the
next few days and week. I apologize for being such a moron and breaking
i2c a few weeks before the 2.9.0 release without proper testing of the
change I made.

We of course need to revert the change in CVS but it won't fix the
released 2.9.0 package. Options we have now:

1* Silently re-release 2.9.0 with the change.

2* Release 2.9.1 ASAP with the change.

3* Provide a patch on the download page.

Option 3 is probably the most simple... Opinion anyone?

> Perhaps /usr/include/linux is for userland
> interfacing the kernel, but then there is no FHS place for
> kernel-kernel headers (they are assumed to be hiding in the kernel
> source only). Perhaps per kernel /lib/modules/.../{source,build}
> locations would have been more appropriate.

I have no idea where the correct location would be, so anything you come
with is fine with me.

Very sorry again,
-- 
Jean Delvare
http://khali.linux-fr.org/
