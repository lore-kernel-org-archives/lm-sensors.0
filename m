From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Jul 2011 16:34:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (pmbus) Drop check for PMBus
Message-Id: <20110703163427.GE15945@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309454993-8641-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309454993-8641-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 03, 2011 at 03:46:05AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the (too) late review.
> 
> On Thu, 30 Jun 2011 10:29:50 -0700, Guenter Roeck wrote:
> > Some PMBus devices do not support the PMBus revision register, so don't check
> > if it exists.
> 
> This was the only use of PMBUS_REVISION. Should its definition be kept
> in pmbus.h?
> 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/pmbus_core.c |    8 ++------
> >  1 files changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
> > index 354770e..bd613e7 100644
> > --- a/drivers/hwmon/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus_core.c
> > @@ -1430,12 +1430,8 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
> >  	i2c_set_clientdata(client, data);
> >  	mutex_init(&data->update_lock);
> >  
> > -	/*
> > -	 * Bail out if status register or PMBus revision register
> > -	 * does not exist.
> > -	 */
> > -	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0
> > -	    || i2c_smbus_read_byte_data(client, PMBUS_REVISION) < 0) {
> > +	/* Bail out if PMBus status register does not exist. */
> > +	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
> >  		dev_err(&client->dev,
> >  			"Status or revision register not found\n");
> 
> This error message should be updated accordingly.
> 
Forgot to mention: I fixed that before I sent the patch to Linus.
Sorry, things are a bit hectic nowadays and I forgot to send the updated patch
to the list.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
