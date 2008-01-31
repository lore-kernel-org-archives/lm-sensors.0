From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:21:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) Add AUX4 fan input	for
Message-Id: <20080131132109.GE8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1200423464-19294-1-git-send-email-vsu@altlinux.ru>
In-Reply-To: <1200423464-19294-1-git-send-email-vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergey, Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2008-01-16 15:51:26 +0100]:
> Sergey Vlasov wrote:
> > Abit IP35 Pro has 6 fan connectors (CPU, SYS and AUX1-4), but the
> > entry for AUX4 was missing from the table.
> > 
> > Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> > ---
> >  drivers/hwmon/abituguru3.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> > index e72a21b..0e6b142 100644
> > --- a/drivers/hwmon/abituguru3.c
> > +++ b/drivers/hwmon/abituguru3.c
> > @@ -528,6 +528,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
> >  		{ "AUX1 Fan",		33, 2, 60, 1, 0 },
> >  		{ "AUX2 Fan",		35, 2, 60, 1, 0 },
> >  		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
> > +		{ "AUX4 Fan",		37, 2, 60, 1, 0 },
> >  		{ NULL, 0, 0, 0, 0, 0 } }
> >  	},
> >  	{ 0x001B, "unknown", {
> 
> Looks good to me:
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
