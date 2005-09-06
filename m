From: mgreer@mvista.com (Mark A. Greer)
Date: Tue, 06 Sep 2005 20:43:12 +0000
Subject: [lm-sensors] [PATCH 2.6.13-mm1] i2c: bug fix for
Message-Id: <20050906184228.GF10346@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050902010549.GD10106@mag.az.mvista.com>
In-Reply-To: <20050902010549.GD10106@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Sep 02, 2005 at 09:25:47PM +0200, Jean Delvare wrote:
> Hi Mark,
> 
> > When an i2c transfer is successful, an incorrect value may be
> > returned. This patch fixes that.
> 
> I would make this "is returned", as I can't think of a non-degenerated
> successful case where a correct value would be returned.
> 
> > diff -Nur linux-2.6.13-mm1/drivers/i2c/busses/i2c-mv64xxx.c linux-2.6.13-mm1-mag/drivers/i2c/busses/i2c-mv64xxx.c
> > --- linux-2.6.13-mm1/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-01 16:26:21.000000000 -0700
> > +++ linux-2.6.13-mm1-mag/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-01 17:00:58.000000000 -0700
> > @@ -429,7 +429,7 @@
> >  		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
> >  			break;
> >  
> > -	return rc;
> > +	return (rc < 0) ? rc : num;
> >  }
> >  
> >  static struct i2c_algorithm mv64xxx_i2c_algo = {
> 
> Looks less than optimal to me. What about:
> 
> When an i2c transfer is successful, an incorrect value is returned.
> This patch fixes that.

Yes, that's better.

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
>  drivers/i2c/busses/i2c-mv64xxx.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.13.orig/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-02 20:44:25.000000000 +0200
> +++ linux-2.6.13/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-02 20:49:16.000000000 +0200
> @@ -423,13 +423,13 @@
>  mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  {
>  	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
> -	int	i, rc = 0;
> +	int	i, rc;
>  
>  	for (i=0; i<num; i++)
> -		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
> -			break;
> +		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) < 0)
> +			return rc;
>  
> -	return rc;
> +	return num;
>  }
>  
>  static struct i2c_algorithm mv64xxx_i2c_algo = {
> 
> 
> Note that the change from "!= 0" to "< 0" is purely for safety, as
> mv64xxx_i2c_execute_msg is not supposed to return stricly positive
> values anyway.

Agreed.  However, I think we still need to init 'rc' to 0 in case 'num' is
ever 0 to prevent random data from being returned.

Thanks for taking time for this.

Mark
