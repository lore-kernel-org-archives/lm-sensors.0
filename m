From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [gstewart@spamcop.net: Linux kernel / i2c_adapter structure]
Message-Id: <20031219203813.GA4997@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031219120846.GA655@frodo.local>
In-Reply-To: <20031219120846.GA655@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 19, 2003 at 10:22:56PM +0200, Ky?sti M?lkki wrote:
> On Fri, 19 Dec 2003, Greg KH wrote:
> >
> > Use the i2c_get_adapdata() and i2c_set_adapdata() functions to get and
> > set a private data pointer.  See the adapter drivers for examples of how
> > to use this properly.
> 
> Hmm... it goes to adapter.dev.driver_data.

Yes, is there a problem with that?  a i2c_adapter contains a struct
device, and the driver core provides a private pointer, driver_data,
which can be used by the high level driver.

> Currently in 2.6 adapter is bound with a "dummy" driver that never
> references dev.driver_data.

Even if it did have a "real" driver, it would not reference this field.

> While it does work it is not very clean as
> for an i2c_adapter device, the device driver is the algorithm.
> Therefore, driver_data should point a structure specific to this
> algorithm. IMO, one should move *algo_data and not *data to
> dev.driver_data using the functions you mention above, right?

No.  Perhaps the field, "driver_data" is a bit confusing.  Perhaps it
should be called "device_data", or "private".

thanks,

greg k-h
