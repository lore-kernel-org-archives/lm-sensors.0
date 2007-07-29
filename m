From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 29 Jul 2007 18:45:31 +0000
Subject: Re: [lm-sensors] [2.6 patch] make
Message-Id: <20070729184531.GB31314@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070729145701.GJ16817@stusta.de> <46ACBB8E.9080302@hhs.nl>
In-Reply-To: <46ACBB8E.9080302@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-29 18:08:46 +0200]:
> Adrian Bunk wrote:
> >abituguru3_read_increment_offset() can become static.
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Looks good, good catch.
> 
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> >
> >---
> >--- linux-2.6.23-rc1-mm1/drivers/hwmon/abituguru3.c.old	2007-07-26 
> >08:56:33.000000000 +0200
> >+++ linux-2.6.23-rc1-mm1/drivers/hwmon/abituguru3.c	2007-07-26 
> >08:57:00.000000000 +0200
> >@@ -691,8 +691,9 @@
> > 
> > /* Sensor settings are stored 1 byte per offset with the bytes
> >    placed add consecutive offsets. */
> >-int abituguru3_read_increment_offset(struct abituguru3_data *data, u8 
> >bank,
> >-	u8 offset, u8 count, u8 *buf, int offset_count)
> >+static int abituguru3_read_increment_offset(struct abituguru3_data *data,
> >+					    u8 bank, u8 offset, u8 count,
> >+					    u8 *buf, int offset_count)
> > {
> > 	int i, x;
> > 
> >

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
