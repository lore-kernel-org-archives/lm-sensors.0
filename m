From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Nov 2013 17:33:38 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <20131113173338.GA21385@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 12, 2013 at 11:01:44PM -0800, p. stephen w wrote:
> No prob.  See attached.
> 
Hi,

[ not sure if I actually sent my prevous response. Too early in the morning ;-). ]

First of all, thanks a lot for testing. For some reason, the output is the same
as before. Yet, the latest driver version should only create the "pwm*weight"
attributes for pwm2. So I wonder - is it possible that you did not unload the
old driver version with "modprobe -r" before loading the new version ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
