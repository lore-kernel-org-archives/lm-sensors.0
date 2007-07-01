From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 01 Jul 2007 15:47:32 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru3-new-driver.patch: Add
Message-Id: <20070701154732.GC18198@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-06-17 00:28:45 +0200]:
> This third version has no changes compared to the second except for a sync 
> to the 2.6.22rc4 kernel.
> 
> This patch adds a new driver for the hardware monitoring features of the
> third revision of the Abit uGuru chip, found on recent Abit
> motherboards. This is an entirely different beast then the first and
> second revision (its again a winbond microcontroller, but the "protocol"
> to talk to it and the bank addresses are very different.

Applied to testing, w/ much trailing whitespace fixed.  Hans, please remember
to check your future patches for that.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
