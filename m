From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 03 Jan 2007 14:36:45 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <20070103153645.6d9eaa40.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew, David,

On Fri, 29 Dec 2006 06:24:27 +0300, Andrew Gaydenko wrote:
> Hi, David,
> 
> ==== On Friday 29 December 2006 06:09, you wrote: ===> >Setting pwmX_enable to 0 is supposed to disable the pwm output for
> >that fan, resulting in the maximum fan speed. The w83627ehf and
> >w83627dhg do not have a way to disable the pwm output. Just write 255
> >to pwmX.
> 
> OK, I'm tracing for SVN tree :-)

This is a known bug which was first reported here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-November/018291.html
See my answer here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018521.html
There's a patch in that post, if you want to try it out, it should solve
the problem. I didn't have the time to try it myself yet. If it works
I'll commit it to lm_sensors SVN before we release 2.10.2.

Thanks,
-- 
Jean Delvare

