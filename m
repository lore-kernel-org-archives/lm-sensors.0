From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 12 Jun 2007 11:23:46 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-pre] s/SENSORS_/HWMON_/  in Kconfig,
Message-Id: <20070612112346.GA15658@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <466E2E83.4010203@gmail.com>
In-Reply-To: <466E2E83.4010203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim:

* Jim Cromie <jim.cromie@gmail.com> [2007-06-11 23:26:27 -0600]:
> 
> (patch attached, with this stuff at the top - hope thats ok)
> 
> This changes SENSORS to HWMON in Kconfig and Makefile,
> which makes it agree with 'menuconfig HWMON' at the top of Kconfig,
> and with the dir-name itself.  ISTM that theres no reason
> (save legacy) to keep this arbitrary difference.

It will break 'make oldconfig', although I don't care *too* much about that.
Does anyone else care one way or the other?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
