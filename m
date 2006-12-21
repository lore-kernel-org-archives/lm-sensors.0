From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Dec 2006 21:06:42 +0000
Subject: [lm-sensors] Simplifying hwmon drivers locking
Message-Id: <20061221220642.25eea3ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061215140939.471935f1.khali@linux-fr.org>
In-Reply-To: <20061215140939.471935f1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Thu, 21 Dec 2006 07:57:15 -0500, Mark M. Hoffman wrote:
> Hi Jean:
> 
> One comment about this...
> 
> * Jean Delvare <khali at linux-fr.org> [2006-12-15 14:09:39 +0100]:
> > Many hardware monitoring drivers use two different mutexes, one to
> > protect their per-device data structure, and one to protect the
> > access to the device registers. These mutexes are essentially
> > redundant, as the drivers are transfering values between the device
> > registers and the data cache, so it almost always ends up holding both
> > mutexes at the same time. Using a single mutex will make the mode more
> > simple and faster.
> > 
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > ---
> >  drivers/hwmon/f71805f.c |   22 ++++++----------------
> >  drivers/hwmon/it87.c    |   22 +++++-----------------
> >  2 files changed, 11 insertions(+), 33 deletions(-)
> > 
> > --- linux-2.6.20-rc1.orig/drivers/hwmon/f71805f.c	2006-12-15 13:30:30.000000000 +0100
> > +++ linux-2.6.20-rc1/drivers/hwmon/f71805f.c	2006-12-15 13:43:16.000000000 +0100
> > @@ -146,7 +146,6 @@
> >  struct f71805f_data {
> >  	unsigned short addr;
> >  	const char *name;
> > -	struct mutex lock;
> >  	struct class_device *class_dev;
> >  
> >  	struct mutex update_lock;
> > @@ -271,50 +270,42 @@
> >   * Device I/O access
> >   */
> >  
> > +/* Must be called with data->update_lock held, except during initialization */
> >  static u8 f71805f_read8(struct f71805f_data *data, u8 reg)
> >  {
> > -	u8 val;
> > -
> > -	mutex_lock(&data->lock);
> >  	outb(reg, data->addr + ADDR_REG_OFFSET);
> > -	val = inb(data->addr + DATA_REG_OFFSET);
> > -	mutex_unlock(&data->lock);
> > -
> > -	return val;
> > +	return inb(data->addr + DATA_REG_OFFSET);
> >  }
> >  
> > +/* Must be called with data->update_lock held, except during initialization */
> >  static void f71805f_write8(struct f71805f_data *data, u8 reg, u8 val)
> >  {
> > -	mutex_lock(&data->lock);
> >  	outb(reg, data->addr + ADDR_REG_OFFSET);
> >  	outb(val, data->addr + DATA_REG_OFFSET);
> > -	mutex_unlock(&data->lock);
> >  }
> 
> Better than just a comment, let's add WARN_ON(!mutex_is_locked(&data->lock)) at
> the front of the read/write routines.  Overhead should be negligible.

This increases the .text size of driver f71805f by 4.5%, which is more
than what my patch saves (2.8%). Not sure the overhead is really
negligible either, checking a mutex is not significantly different from
taking it, is it? The read functions can be called relatively
frequently, the whole idea was to lower the overhead on register
access, if we need to increase it again, it's void.

Additionally, as the comment says, calling without data->update_lock
held is OK during initialization, so the WARN_ON() would trigger here.
Unless we change the initialization path to hold the lock just for
validation purpose.

One might argue that performance isn't an issue here and it's more
important to make sure we get the locking right - but in that case I'd
rather stick to the code we have at the moment (unless someone
demonstrates that WARN_ON(!mutex_is_locked()) has actually a lower
overhead than taking and releasing a mutex.)

As far as I am concerned I feel safe with the single-mutex version and
no additional check, because both mutexes were redundant almost by
construction. I only had to move one register access (out of 102) in
these two drivers to get it right. But if you don't feel safe with
that, I respect that and I'll leave the other drivers untouched.

Thanks,
-- 
Jean Delvare

