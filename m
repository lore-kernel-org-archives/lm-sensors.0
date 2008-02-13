From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 13 Feb 2008 12:56:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max1619) Add individual alarm
Message-Id: <20080213125623.GB1154@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106152759.64209d42@hyperion.delvare>
In-Reply-To: <20080106152759.64209d42@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Juerg Haefliger <juergh@gmail.com> [2008-02-09 22:31:11 -0800]:
> Looks good and compiles cleanly.
> 
> Acked-by: Juerg Haefliger <juergh at gmail.com>
> 
> 
> > The new libsensors needs these individual alarm and fault files.
> >
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > ---
> > Alexey, would you have the opportunity to test this patch?
> >
> >   drivers/hwmon/max1619.c |   17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
