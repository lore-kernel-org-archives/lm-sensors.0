From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 May 2008 20:42:21 +0000
Subject: Re: [lm-sensors] [patch 2/2] ADT746X: logical-bitwise & confusion
Message-Id: <20080526224221.0ef8ad6d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080526191635.GA18446@mars.solarsys.private>
In-Reply-To: <20080526191635.GA18446@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 May 2008 15:16:35 -0400, Mark M. Hoffman wrote:
> Hi again:
> 
> * Mark M. Hoffman <mhoffman@lightlink.com> [2008-05-26 11:55:23 -0400]:
> > Hi:
> > 
> > * Andrew Morton <akpm@linux-foundation.org> [2008-03-28 14:23:59 -0700]:
> > > From: Roel Kluin <12o3l@tiscali.nl>
> > > 
> > > logical-bitwise & confusion
> > > 
> > > Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> > > Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> > > Acked-by: Colin Leroy <colin@colino.net>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > > Cc: "Darrick J. Wong" <djwong@us.ibm.com>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > > 
> > >  drivers/hwmon/adt7473.c |    6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff -puN drivers/hwmon/adt7473.c~adt746x-logical-bitwise-confusion-in-set_max_duty_at_crit drivers/hwmon/adt7473.c
> > > --- a/drivers/hwmon/adt7473.c~adt746x-logical-bitwise-confusion-in-set_max_duty_at_crit
> > > +++ a/drivers/hwmon/adt7473.c
> > > @@ -573,11 +573,11 @@ static ssize_t set_max_duty_at_crit(stru
> > >  				    const char *buf,
> > >  				    size_t count)
> > >  {
> > > -	u8 reg;
> > > +	u8 reg, temp;
> > >  	struct i2c_client *client = to_i2c_client(dev);
> > >  	struct adt7473_data *data = i2c_get_clientdata(client);
> > > -	int temp = simple_strtol(buf, NULL, 10);
> > > -	temp = temp && 0xFF;
> > > +
> > > +	temp = simple_strtol(buf, NULL, 10);
> > >  
> > >  	mutex_lock(&data->lock);
> > >  	data->max_duty_at_overheat = temp;
> > > _
> > 
> > Applied to hwmon-2.6.git/testing, thanks.
> 
> Oops.  Thank you Jean for pointing out that the above is no good.  How about
> this one instead...
> 
> commit ad49ac743a01705a77318a06831bb82b7f44c5ec
> Author: Mark M. Hoffman <mhoffman@lightlink.com>
> Date:   Mon May 26 15:09:36 2008 -0400
> 
>     hwmon: (adt7473) clarify an awkward bit of code
>     
>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> 
> diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
> index 93dbf5e..24c2239 100644
> --- a/drivers/hwmon/adt7473.c
> +++ b/drivers/hwmon/adt7473.c
> @@ -572,10 +572,9 @@ static ssize_t set_max_duty_at_crit(struct device *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7473_data *data = i2c_get_clientdata(client);
>  	int temp = simple_strtol(buf, NULL, 10);
> -	temp = temp && 0xFF;
>  
>  	mutex_lock(&data->lock);
> -	data->max_duty_at_overheat = temp;
> +	data->max_duty_at_overheat = !!temp;
>  	reg = i2c_smbus_read_byte_data(client, ADT7473_REG_CFG4);
>  	if (temp)
>  		reg |= ADT7473_CFG4_MAX_DUTY_AT_OVT;
> 

Yep, much better.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
