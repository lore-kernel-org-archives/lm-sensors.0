From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <20041019051726.GC18098@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys:

* Jean Delvare <khali@linux-fr.org> [2004-10-18 10:18:21 +0200]:
> >If we could come up with a "wrapper" model of an i2c bus driver for
> >these mux situations that seems to me to be the ideal.  Such a wrapper
> >would capture the knowledge of how to mux the bus and what branch of the
> >mux is currently selected.  It would register multiple "virtual" i2c
> >busses and mark the "parent" i2c bus as no-probe and in general attempt
> >to prevent anything from accessing the parent bus directly.
> 
> This pretty much matches what Mark M. Hoffman suggested to me on IRC
> yesterday. Great you seem to agree on the proper way to do it ;) I
> didn't read the original virtual bus implementation proposal in enough
> details to say if it was similar or not.

What Jean & I chatted about was adding a pair of functions to i2c-core;
they would look something like this:

	int i2c_lock_adapter(struct i2c_adapter *);
	int i2c_unlock_adapter(struct i2c_adapter *);

The first would actually pull the adapter out of the core list, including
auto-detaching any clients that might have already attached.  The purpose
of that is to prevent probing as you (Philip) mentioned.  Usage, e.g.:

static struct i2c_adapter *xyz_real_adap;
static struct i2c_adapter *xyz_virt_adap;

static int __init xyz_mux_init(void)
{

	int err;

	/* register myself as a driver/client */
	if ((err = i2c_add_driver(&xyz_mux_driver))
		goto ERROR_0;

	/* find the real bus */	
	if (!((xyz_real_adap = i2c_get_adapter(<some id>))) {
		err = -EINVAL;
		goto ERROR_1;
	}

	/* lock all other clients out of it */
	if ((err = i2c_lock_adapter(&xyz_real_adap))
		goto ERROR_2;

	/* build the virtual adapter */
	/* ... */
	if ((err = i2c_add_adapter(&xyz_virt_adap))
		goto ERROR_3;

	return 0;

ERROR_3:
	i2c_unlock_adapter(struct i2c_adapter *);
ERROR_2: 
	i2c_put_adapter(&xyz_real_adap);
ERROR_1:
	i2c_del_driver(&xyz_mux_driver);
ERROR_0:
	return err;
}

So, that would accomodate some useful things:

1) Muxes, obviously, but also...

2) The (hypothetical, mentioned in earlier message) i2c-trace module.

3) Whatever home-grown, out-of-band bus reservation system you have.
E.g. if you have a single I2C bus segment with multiple masters, where
normal I2C bus arbitration isn't good enough -  you could lock the real
bus and attach your clients to the virtual one, which satisfies whatever
bus reservation scheme before/after transactions.

This idea isn't even half-baked yet though...

1) The above carries a built-in assumption: that the mux itself, if it
is controlled by I2C/SMBus, must be a client of the immediate parent
segment.  Does anyone know of a mux that doesn't work that way?  E.g.
a 2x1 mux with a fourth bus connection for mux control only?

2) Doesn't address the sysfs hierarchy.  It would be nice to have a
sysfs structure that is isomorphic to the i2c bus structure... I think
USB is like that so I will look into it.

Any other ideas would be appreciated.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
