From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: w83l785ts inserted but no readings right away
Message-Id: <20040901133953.M10595@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <410E4CA4.6070601@johanneshuebner.com>
In-Reply-To: <410E4CA4.6070601@johanneshuebner.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 01 Sep 2004 12:17:35 +0200, Johannes H?bner wrote

> I wrote a while ago because of problems with the w83l785ts. I think the
> problem is solved since I swapped the order in which  the modules are
> loaded: First i2c-nforce2, then w83l785ts, and then asb100. I also
> updated my BIOS from 1007 to 1010 but the problem was gone before that.

Thanks for reporting. I've updated the relevant bug (#2899 [1]) in the kernel
bugzilla base.

I'm a bit suspicious that changing the order will solve the problem in all
cases, because you said earlier that you sometimes had to cycle the w83l785ts
driver more than once to get it to work. And, as a matter of fact, it did not
solve the problem for the bug submitter. So I think there are two different
causes of failure, possibly linked.

Please let us know if you experience difficulties again despite the modules
load order change.

Thanks.

[1] http://bugzilla.kernel.org/show_bug.cgi?id(99

-- 
Jean Delvare
http://khali.linux-fr.org/
