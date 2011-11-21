From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 21 Nov 2011 16:08:07 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Fix checkpatch errors
Message-Id: <1321891687.2730.56.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-11-21 at 10:47 -0500, Jean Delvare wrote:
> On Mon, 21 Nov 2011 18:49:23 +0530, Shubhrajyoti Datta wrote:
> > Hi Guenter,
> > 
> > On Mon, Nov 21, 2011 at 4:12 AM, Guenter Roeck
> > <guenter.roeck@ericsson.com> wrote:
> > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > >  drivers/hwmon/lm63.c |   74 +++++++++++++++++++++++++++++++++++--------------
> > >  1 files changed, 53 insertions(+), 21 deletions(-)
> > > (...)
> > > @@ -231,11 +236,15 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *dummy,
> > >        struct i2c_client *client = to_i2c_client(dev);
> > >        struct lm63_data *data = i2c_get_clientdata(client);
> > >        unsigned long val;
> > > -
> > > +       int err;
> > > +
> > >        if (!(data->config_fan & 0x20)) /* register is read-only */
> > >                return -EPERM;
> > >
> > > -       val = simple_strtoul(buf, NULL, 10);
> > > +       err = kstrtoul(buf, 10, &val);
> > > +       if (err)
> > > +               return err;
> > > +
> > Since the valid range is upto 255 do we still need string to long ?
> 
> What else do you suggest we could use?
> 
We could use kstrtou8(). Something to keep in mind for new drivers. Not
that sure about old drivers - I am always concerned that it may
complicate back-porting of patches to older kernels.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
