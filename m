From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jan 2012 14:29:04 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] lm90.c: fix checkpatch error
Message-Id: <20120105152904.54abf144@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325716040-22310-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325716040-22310-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 4 Jan 2012 14:29:05 -0800, Guenter Roeck wrote:
> On Wed, 2012-01-04 at 17:27 -0500, Frans Meulenbroeks wrote:
> > Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> > ---
> >  drivers/hwmon/lm90.c |   11 ++++++++---
> >  1 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > index 615bc4f..36dcbc9 100644
> > --- a/drivers/hwmon/lm90.c
> > +++ b/drivers/hwmon/lm90.c
> > @@ -388,9 +388,14 @@ static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
> >  	 * we have to read the low byte again, and now we believe we have a
> >  	 * correct reading.
> >  	 */
> > -	if ((err = lm90_read_reg(client, regh, &oldh))
> > -	 || (err = lm90_read_reg(client, regl, &l))
> > -	 || (err = lm90_read_reg(client, regh, &newh)))
> > +	err = lm90_read_reg(client, regh, &oldh);
> > +	if (err)
> > +		return err;
> > +	err = lm90_read_reg(client, regl, &l);
> > +	if (err)
> > +		return err;
> > +	err = lm90_read_reg(client, regh, &newh);
> > +	if (err)
> >  		return err;
> >  	if (oldh != newh) {
> >  		err = lm90_read_reg(client, regl, &l);
> 
> Ah, we left those in for readability.

Actually this is one of the things checkpatch complains about which I
consider a false positive. There is really nothing wrong with the code
above, it does the right thing with no risk of error. Its replacement,
OTOH, is harder to read, and less efficient.

The check should either be improved to only complain in cases which are
really wrong, or should be plain discarded if fixing it is not possible.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
