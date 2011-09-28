From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Sep 2011 13:04:15 +0000
Subject: Re: [lm-sensors] fan change between 3.1.0-rc6 and commit b172e38
Message-Id: <20110928150415.0256b513@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <m339flbipr.fsf@jhcloos.com>
In-Reply-To: <m339flbipr.fsf@jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Sep 2011 19:37:07 -0400, James Cloos wrote:
> >>>>> "GR" = Guenter Roeck <guenter.roeck@ericsson.com> writes:
> 
> GR> I don't recall a relevant change, nor did I find one in the commit log.
> 
> OK.  Perhaps it was a change in another subsystem....
> 
> GR> Did pwmconfig ever work for you ?
> 
> I never tried it before.  I'll have to reboot to the previous kernel and check.

Please do, if nothing else just to confirm that this really makes the
fans spin down again.

As we did not touch the driver, it could be an issue with ACPI or the
thermal subsystem, or things like cpuidle or cpufreq. As the number of
commits is relatively small and you seem to know how to build a kernel
from the git repository, your best chance is probably to bisect the
problem and then contact the author of the faulty commit directly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
