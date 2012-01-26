From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Jan 2012 17:17:21 +0000
Subject: Re: [lm-sensors] [PATCH 06/79] hwmon: (lm87) Fix: do not use assignment in if condition
Message-Id: <1327598241.2649.218.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-7-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-7-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-01-26 at 09:28 -0500, Jean Delvare wrote:
> On Mon, 23 Jan 2012 18:48:45 -0800, Guenter Roeck wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> > 
> > Fix checkpatch issue:
> > ERROR: do not use assignment in if condition
> > 
> > Replace repeated calls to device_create_file() with calls to sysfs_create_group.
> > 
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/lm87.c |  152 ++++++++++++++++++++++++++------------------------
> >  1 files changed, 80 insertions(+), 72 deletions(-)
> 
> Overall I like it. Just one suggestion:
> 
> > +static void lm87_remove_files(struct i2c_client *client)
> > +{
> 
> I think it makes sense to introduce
> 	struct device *dev = &client->dev;
> to make the rest of the function easier to read. The binary code
> generated is unchanged.
> 
Good idea; I'll make that change.

> The same might be a good idea in the probe function, for the same
> reason.
> 
Possibly. Not now, though; it interferes with your other patches.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
