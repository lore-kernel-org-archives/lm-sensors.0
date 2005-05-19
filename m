From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Ticket 1719 problems.
Message-Id: <20040707230018.7aba8a44.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40EC5AF8.2030100@nc.rr.com>
In-Reply-To: <40EC5AF8.2030100@nc.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm sorry if I'm making a nuisance of myself but I guess I must be
> being obtuse.  The various documentation says that you have to be
> careful to only use certain version of lm_sensors with the various
> versions of the kernel.  I'm using an Asus A7N8X which has a w83l785ts
> on it, apparently the fix came in a version after the one that
> Mandrake considers to work with my kernel.  I'm using 2.6.3-7mdk
> kernel and lm_sensors-2.8.4-2mdk.i586. I got an rpm of 
> lm_sensors-2.8.7-4mdk.i586.rpm and it's kicking the procfs/sysfs
> thing. Is my only real solution to upgrade my lm_sensors AND my
> kernel? 

Yes, there are incompatibilities for early 2.6 kernels. We were just
ending our massive interface rework, so file names were changing much.
See this page for the correct matching:
http://www2.lm-sensors.nu/~lm78/kernel26.html

Beware that distributions often lie about kernel versions. A 2.6.N-rc
kernel will most likely be labelled 2.6.(N-1), so if a given combination
doesn't work, you have to try with the next version of lm_sensors.

The interface has now (almost) stabilised so the trouble with versions
has gone now. So if you upgrade both kernel and lm_sensors you're safe.

-- 
Jean Delvare
http://khali.linux-fr.org/
