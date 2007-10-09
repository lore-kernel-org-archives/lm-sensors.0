From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 09 Oct 2007 00:48:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: VRM is not read from registers
Message-Id: <20071009004855.GL3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071008182435.59c4727c@hyperion.delvare>
In-Reply-To: <20071008182435.59c4727c@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-08 21:06:57 +0200]:
> Jean Delvare wrote:
> > The VRM value is not read from chip registers, so there's no need
> > to update the device data cache before exporting the VRM value to
> > user-space.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Looks good,
> 
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
