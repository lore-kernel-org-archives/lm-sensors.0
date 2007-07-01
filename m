From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 01 Jul 2007 15:55:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/smsc47b397: Don't report missing
Message-Id: <20070701155517.GD18198@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-06-23 14:58:22 +0200]:
> Correct, and I consider it a bug in the driver. A stopped or missing
> fan should really be reported as 0 RPM, not 82. Here's a patch fixing
> it.
> 
> * * * * *
> 
> Also protects ourselves against a possible division by zero.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied to testing, thanks.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
