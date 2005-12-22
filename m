From: greg@kroah.com (Greg KH)
Date: Thu, 22 Dec 2005 17:25:01 +0000
Subject: [lm-sensors] [PATCH 01/11] hwmon: w83792d misc cleanups
Message-Id: <20051222172501.GA23601@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051218162940.702a24ac.khali@linux-fr.org>
In-Reply-To: <20051218162940.702a24ac.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 22, 2005 at 11:11:14AM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> > On Sun, Dec 18, 2005 at 04:29:40PM +0100, Jean Delvare wrote:
> > > -static int w83792d_read_value(struct i2c_client *client, u8 register);
> > > -static int w83792d_write_value(struct i2c_client *client, u8 register,
> > > +static inline int w83792d_read_value(struct i2c_client *client, u8 register);
> > > +static inline int w83792d_write_value(struct i2c_client *client, u8 register,
> > >  				u8 value);
> > 
> > Will cause compile errors, so I've dropped this portion of the patch
> > (see the patch I sent back to you for details.)
> 
> Can you explain please? We have four other hardware monitoring drivers
> with similar code, and no problem was ever reported. This change to the
> w83792d driver was compiling just fine for me with both gcc 2.95.3 and
> gcc 3.3.6. What exactly is supposed to cause problems, and with which
> compiler?

I'm using gcc 3.4.4 here, and this change caused build errors.  You
can't declare a function "static inline" and not actually declare the
full function before calling it, like this driver did (it called
w83792d_write_value() before that function was fully written.)  I think
older versions of gcc just ignore this and don't inline it.

The other drivers that do this, properly define the functions fully
before calling them, that's why it works.

Hope this helps,

greg k-h

