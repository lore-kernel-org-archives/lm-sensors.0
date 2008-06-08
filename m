From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jun 2008 15:16:33 +0000
Subject: Re: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <20080608151633.GD6807@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4836D061.9080501@hhs.nl>
In-Reply-To: <4836D061.9080501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2008-05-23 16:10:41 +0200]:
(...)
> It has been reported that the abituguru3 driver fails to load after a BIOS
> update. This patch fixes this by loosening the detection routine so that it
> will work after the BIOS update too. To compensate for the now very loose
> detection an additional check is added on the DMI Base Board vendor string to
> make sure we only load on Abit motherboards, this is the same as the check in
> the abituguru (1 / 2) driver.
> 
> Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, thanks.

(will include in final batch to Linus for 2.6.26 also)

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
