From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Mar 2010 15:28:01 +0000
Subject: Re: [lm-sensors] [patch] hwmon: saving negative errors in unsigned
Message-Id: <20100311162801.482d96d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100311103151.GN6321@bicker>
In-Reply-To: <20100311103151.GN6321@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Thu, 11 Mar 2010 12:08:32 +0100, Hans de Goede wrote:
> Ack.
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

> On 03/11/2010 11:31 AM, Dan Carpenter wrote:
> > "ret" is used to store the return value for watchdog_trigger() and it
> > should be signed for the error handling to work.
> >
> > Signed-off-by: Dan Carpenter<error27@gmail.com>
> >
> > diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> > index 9de81a4..612807d 100644
> > --- a/drivers/hwmon/w83793.c
> > +++ b/drivers/hwmon/w83793.c
> > @@ -1294,7 +1294,7 @@ static int watchdog_close(struct inode *inode, struct file *filp)
> >   static ssize_t watchdog_write(struct file *filp, const char __user *buf,
> >   	size_t count, loff_t *offset)
> >   {
> > -	size_t ret;
> > +	ssize_t ret;
> >   	struct w83793_data *data = filp->private_data;
> >
> >   	if (count) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
