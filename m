From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 29 Jul 2007 18:39:15 +0000
Subject: Re: [lm-sensors] [PATCH] Fix regression caused by typo in lm90.c
Message-Id: <20070729183915.GA31314@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726230422.2955.70451.sendpatchset@localhost.localdomain> <BbJeFUOL.1185523665.8121830.khali@localhost>
In-Reply-To: <BbJeFUOL.1185523665.8121830.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: guichaz@yahoo.fr, Rainer Birkenmaier <rainer.birkenmaier@siemens.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi:

> On 7/26/2007, "Guillaume Chazarain" <guichaz@yahoo.fr> wrote:
> >diff -r 4cad6fced1a8 drivers/hwmon/lm90.c
> >--- a/drivers/hwmon/lm90.c	Thu Jul 26 13:44:58 2007 -0700
> >+++ b/drivers/hwmon/lm90.c	Tue Jul 24 00:02:52 2007 +0200
> >@@ -585,7 +585,7 @@ static int lm90_detect(struct i2c_adapte
> > 			 * those of the man_id register.
> > 			 */
> > 			if (chip_id = man_id
> >-			 && (address = 0x4F || address = 0x4D)
> >+			 && (address = 0x4C || address = 0x4D)
> > 			 && (reg_config1 & 0x1F) = (man_id & 0x0F)
> > 			 && reg_convrate <= 0x09) {
> > 			 	kind = max6657;

* Jean Delvare <khali@linux-fr.org> [2007-07-27 10:07:45 +0200]:
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
