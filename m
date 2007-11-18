From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 18 Nov 2007 19:22:38 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: remove duplicated defines
Message-Id: <20071118192238.GB12086@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071107132859.1d961027@lucky.kitzblitz>
In-Reply-To: <20071107132859.1d961027@lucky.kitzblitz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2007-11-09 14:52:59 +0100]:
> Hi Nicolas,
> 
> On Wed, 7 Nov 2007 13:28:59 +0100, Nicolas Kaiser wrote:
> > Remove duplicated defines.
> 
> Obviously correct, thanks.
> 
> > 
> > Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> > ---
> > 
> >  drivers/hwmon/w83793.c |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > --- a/drivers/hwmon/w83793.c	2007-11-07 11:28:29.000000000 +0100
> > +++ b/drivers/hwmon/w83793.c	2007-11-07 13:08:54.000000000 +0100
> > @@ -131,6 +131,7 @@
> >  #define PWM_DUTY			0
> >  #define PWM_START			1
> >  #define PWM_NONSTOP			2
> > +#define PWM_STOP_TIME			3
> >  #define W83793_REG_PWM(index, nr)	(((nr) = 0 ? 0xb3 : \
> >  					 (nr) = 1 ? 0x220 : 0x218) + (index))
> >  
> > @@ -407,10 +408,6 @@
> >  	return count;
> >  }
> >  
> > -#define PWM_DUTY			0
> > -#define PWM_START			1
> > -#define PWM_NONSTOP			2
> > -#define PWM_STOP_TIME			3
> >  static ssize_t
> >  show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
> >  {

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
