From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jun 2012 17:34:47 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (applesmc) Do not return random value in error case
Message-Id: <20120620193447.6d413ab4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340120803-23543-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340120803-23543-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Jun 2012 09:38:33 -0700, Guenter Roeck wrote:
> On Wed, 2012-06-20 at 12:03 -0400, Henrik Rydberg wrote:
> > Or we could reduce the code further, as in the patch below. I had this
> > outlined some time ago, but refrained from sending it since it seemed
> > to make no difference at the time...
> > 
> > Cheers,
> > Henrik
> > 
> > From 479a3d94f2e50d7917b9f7959512af0c9b01ff9c Mon Sep 17 00:00:00 2001
> > From: Henrik Rydberg <rydberg@euromail.se>
> > Date: Wed, 20 Jun 2012 18:00:06 +0200
> > Subject: [PATCH] hwmon: (applesmc) Skip sensor mapping
> > 
> > The special motion sensor mapping is unnecessary; remove it.
> > 
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> >  drivers/hwmon/applesmc.c |   41 +++++++++++++----------------------------
> >  1 file changed, 13 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> > index 70d62f5..2bc6490 100644
> > --- a/drivers/hwmon/applesmc.c
> > +++ b/drivers/hwmon/applesmc.c
> > @@ -96,10 +96,6 @@ static const char *const fan_speed_fmt[] = {
> >  #define APPLESMC_INPUT_FUZZ	4	/* input event threshold */
> >  #define APPLESMC_INPUT_FLAT	4
> >  
> > -#define SENSOR_X 0
> > -#define SENSOR_Y 1
> > -#define SENSOR_Z 2
> > -
> >  #define to_index(attr) (to_sensor_dev_attr(attr)->index & 0xffff)
> >  #define to_option(attr) (to_sensor_dev_attr(attr)->index >> 16)
> >  
> > @@ -432,30 +428,19 @@ static int applesmc_has_key(const char *key, bool *value)
> >  }
> >  
> >  /*
> > - * applesmc_read_motion_sensor - Read motion sensor (X, Y or Z).
> > + * applesmc_read_s16 - Read 16-bit signed big endian register
> >   */
> > -static int applesmc_read_motion_sensor(int index, s16 *value)
> > +static int applesmc_read_s16(const char *key, s16 *value)
> >  {
> >  	u8 buffer[2];
> >  	int ret;
> >  
> > -	switch (index) {
> > -	case SENSOR_X:
> > -		ret = applesmc_read_key(MOTION_SENSOR_X_KEY, buffer, 2);
> > -		break;
> > -	case SENSOR_Y:
> > -		ret = applesmc_read_key(MOTION_SENSOR_Y_KEY, buffer, 2);
> > -		break;
> > -	case SENSOR_Z:
> > -		ret = applesmc_read_key(MOTION_SENSOR_Z_KEY, buffer, 2);
> > -		break;
> > -	default:
> > -		ret = -EINVAL;
> > -	}
> > +	ret = applesmc_read_key(key, buffer, 2);
> > +	if (ret)
> > +		return ret;
> >  
> >  	*value = ((s16)buffer[0] << 8) | buffer[1];
> > -
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  /*
> > @@ -624,8 +609,8 @@ static struct platform_driver applesmc_driver = {
> >   */
> >  static void applesmc_calibrate(void)
> >  {
> > -	applesmc_read_motion_sensor(SENSOR_X, &rest_x);
> > -	applesmc_read_motion_sensor(SENSOR_Y, &rest_y);
> > +	applesmc_read_s16(MOTION_SENSOR_X_KEY, &rest_x);
> > +	applesmc_read_s16(MOTION_SENSOR_Y_KEY, &rest_y);
> >  	rest_x = -rest_x;
> >  }
> >  
> > @@ -634,9 +619,9 @@ static void applesmc_idev_poll(struct input_polled_dev *dev)
> >  	struct input_dev *idev = dev->input;
> >  	s16 x, y;
> >  
> > -	if (applesmc_read_motion_sensor(SENSOR_X, &x))
> > +	if (applesmc_read_s16(MOTION_SENSOR_X_KEY, &x))
> >  		return;
> > -	if (applesmc_read_motion_sensor(SENSOR_Y, &y))
> > +	if (applesmc_read_s16(MOTION_SENSOR_Y_KEY, &y))
> >  		return;
> >  
> >  	x = -x;
> > @@ -659,13 +644,13 @@ static ssize_t applesmc_position_show(struct device *dev,
> >  	int ret;
> >  	s16 x, y, z;
> >  
> > -	ret = applesmc_read_motion_sensor(SENSOR_X, &x);
> > +	ret = applesmc_read_s16(MOTION_SENSOR_X_KEY, &x);
> >  	if (ret)
> >  		goto out;
> > -	ret = applesmc_read_motion_sensor(SENSOR_Y, &y);
> > +	ret = applesmc_read_s16(MOTION_SENSOR_Y_KEY, &y);
> >  	if (ret)
> >  		goto out;
> > -	ret = applesmc_read_motion_sensor(SENSOR_Z, &z);
> > +	ret = applesmc_read_s16(MOTION_SENSOR_Z_KEY, &z);
> >  	if (ret)
> >  		goto out;
> >  
> I like it - much better than the other options. Jean, what do you
> think ?

I like it a lot too, the diffstat speaks for itself.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
