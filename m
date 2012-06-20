From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jun 2012 16:01:00 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (applesmc) Do not return random value in error case
Message-Id: <20120620180100.1bd46c6c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340120803-23543-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340120803-23543-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Jun 2012 08:00:42 -0700, Guenter Roeck wrote:
> On Wed, Jun 20, 2012 at 04:44:05PM +0200, Jean Delvare wrote:
> > On Tue, 19 Jun 2012 08:46:41 -0700, Guenter Roeck wrote:
> > > If a bad parameter is passed to applesmc_read_motion_sensor(), an uninitialized
> > > and thus arbitrary value is returned. Fix by returning immediately if a bad
> > > parameter is detected.
> > > 
> > > Cc: Henrik Rydberg <rydberg@euromail.se>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/hwmon/applesmc.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> > > index f082e48..cc8dd57 100644
> > > --- a/drivers/hwmon/applesmc.c
> > > +++ b/drivers/hwmon/applesmc.c
> > > @@ -450,7 +450,7 @@ static int applesmc_read_motion_sensor(int index, s16 *value)
> > >  		ret = applesmc_read_key(MOTION_SENSOR_Z_KEY, buffer, 2);
> > >  		break;
> > >  	default:
> > > -		ret = -EINVAL;
> > > +		return -EINVAL;
> > >  	}
> > >  
> > >  	*value = ((s16)buffer[0] << 8) | buffer[1];
> > 
> > It doesn't really matter as this code is never executed anyway. That
> > would be a driver bug if it was. A better fix would probably be to get
> > rid of this branch altogether.
> > 
> If we do that, the compiler will likely complain that ret may be used but not set.
> I could add BUG() or WARN(), but I am not sure if that is worth it.

You can just replace one of the labels with default (or add default and
leave the label for clarity) to make the compiler happy. Alternatively
using an enum instead of independent constants may make the compiler
happy without a default at all.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
