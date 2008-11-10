From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Nov 2008 09:38:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081110103806.1a36b6a6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jordan,

On Sun, 09 Nov 2008 18:27:53 -0700, Jordan Crouse wrote:
> Jean Delvare wrote:
> > For what it's worth, Jordan Crouse seems to think that blacklisting on
> > a per-revision basis may still work.
> 
> I think it can.  A much larger sample would probably need to be taken to 
> be completely sure - but I hope that we'll find that the problem is 
> deterministic enough for a blacklist.  I think we would agree that a 
> blacklist would be the more user friendly solution.

OK, but then we should probably extend Rudolf's patch to ask users
potentially affected by the errata to report to us. The report should
include the CPUID information (e.g. contents of /proc/cpuinfo), the
output of sensors (or the raw temperature values from sysfs), and
whether or not the user thinks the temperature values are correct.

If we don't do that, I fear it will take forever before we can complete
the blacklist.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
