From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Jun 2012 11:03:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83781d) Fix compile warning
Message-Id: <20120618110319.GA28693@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339620986-14314-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339620986-14314-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 18, 2012 at 12:07:25PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 13 Jun 2012 13:56:26 -0700, Guenter Roeck wrote:
> > The following compile warning may be seen if the driver is compiled with
> > -Wuninitialized:
> > 
> > drivers/hwmon/w83781d.c: warning: 'sc_addr[1]' may be used uninitialized in this
> > function [-Wuninitialized]
> > 
> > While this is a false positive, it is annoying in nightly builds, and may help
> > to conceal real problems. The current code is quite tricky, and and it is easy
> > to rearrage the code to make the problem disappear. So fix it.
> 
> I don't see this warning here (gcc 4.6.2.) While I see why it can be
> reported, I don't really understand why your change makes it disappear,
> as you still depend on the value of a local variable, which could have
> changed between the moment you set sc_addr[1] and the moment you use
> it. I'm curious why the compiler is able to keep track of the value in
> one case and not in the other case.
> 
> Out of curiosity, have you tried defining kind as const? If it makes
> the compiler equally happy, I think it would be a better way to solve
> this warning.
> 

Hi Jean,

Try with http://roeck-us.net/linux/config.hwmon as config file.
I tried with gcc versions 4.4.3 and 4.6.3.

Unfortunately, const kind does not help.

My guess is that the sequence is too complex for gcc to resolve, ie that it does
not connect the reason for the break statement in the second loop with the fact
that sc_addr[1] was never initialized.

> > Cc: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/w83781d.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> > index b03d54a..a82f508 100644
> > --- a/drivers/hwmon/w83781d.c
> > +++ b/drivers/hwmon/w83781d.c
> > @@ -867,6 +867,7 @@ w83781d_detect_subclients(struct i2c_client *new_client)
> >  	struct i2c_adapter *adapter = new_client->adapter;
> >  	struct w83781d_data *data = i2c_get_clientdata(new_client);
> >  	enum chips kind = data->type;
> > +	int num_adapter = 1;
> 
> This name is inadequate, you're not counting adapters but subclients.
> num_sc maybe? Or num_subclients if you want to be verbose.
> 
Sure, no problem.

> >  
> >  	id = i2c_adapter_id(adapter);
> >  
> > @@ -891,6 +892,7 @@ w83781d_detect_subclients(struct i2c_client *new_client)
> >  	}
> >  
> >  	if (kind != w83783s) {
> > +		num_adapter = 2;
> >  		if (force_subclients[0] = id &&
> >  		    force_subclients[1] = address) {
> >  			sc_addr[1] = force_subclients[3];
> > @@ -906,7 +908,7 @@ w83781d_detect_subclients(struct i2c_client *new_client)
> >  		}
> >  	}
> >  
> > -	for (i = 0; i <= 1; i++) {
> > +	for (i = 0; i < num_adapter; i++) {
> >  		data->lm75[i] = i2c_new_dummy(adapter, sc_addr[i]);
> >  		if (!data->lm75[i]) {
> >  			dev_err(&new_client->dev, "Subclient %d "
> > @@ -917,8 +919,6 @@ w83781d_detect_subclients(struct i2c_client *new_client)
> >  				goto ERROR_SC_3;
> >  			goto ERROR_SC_2;
> >  		}
> > -		if (kind = w83783s)
> > -			break;
> >  	}
> >  
> >  	return 0;
> 
> 
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
