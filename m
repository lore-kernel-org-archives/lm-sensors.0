From: lmsensors.Andy@spiegl.de (Andy Spiegl)
Date: Sat, 15 Apr 2006 15:03:19 +0000
Subject: [lm-sensors] many wrong values from w83627hf since kernel 2.6.14
Message-Id: <20060415150319.GC8489@spiegl.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060413004532.GA4802@spiegl.de>
In-Reply-To: <20060413004532.GA4802@spiegl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> OK, so we are probably down to a configuration file tweaking issue,
> rather than a driver breakage.
Yep, except for the vid value.

> Until the bug is fixed, a solution is to hardcode the vid value in the
> configuration file. Replace:
...
> With:
> 
>     set in0_min 1.525 * 0.95
>     set in0_max 1.525 * 1.05
Thanks!  But since the in0 reading is between 1.59 and 1.62
I still get alarms. :-(

> I just found a sample configuration file for this motherboard posted by
> Mark M. Hoffman to the list some times ago:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-February/010490.html
Great, thanks a lot!  That leaves me with just one alarm now.

Happy Easter!
 Andy.

-- 
 In Germany everything is forbidden, unless something is specifically allowed.
 In the UK  everything which is not specifically forbidden, is allowed.
 In France  everything is allowed, even if it is forbidden.
 In Italy   everything is allowed, especially when it is forbidden.

