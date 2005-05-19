From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <1J9Ql3vc.1098175055.7700610.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

>(...) Usage, e.g.:
>
>static struct i2c_adapter *xyz_real_adap;
>static struct i2c_adapter *xyz_virt_adap;
>
>static int __init xyz_mux_init(void)
>{
>
>	int err;
>
>	/* register myself as a driver/client */
>	if ((err = i2c_add_driver(&xyz_mux_driver))
>		goto ERROR_0;

Except that you cannot register the client at this point. If you do,
it'll get kicked as soon as you "lock" the adapter.

>	/* find the real bus */
>	if (!((xyz_real_adap = i2c_get_adapter(<some id>))) {
>		err = -EINVAL;
>		goto ERROR_1;
>	}
>
>	/* lock all other clients out of it */
>	if ((err = i2c_lock_adapter(&xyz_real_adap))
>		goto ERROR_2;

And register the client manually at this point. The mux client is the
only client attached to the real bus.

>	/* build the virtual adapter */
>	/* ... */
>	if ((err = i2c_add_adapter(&xyz_virt_adap))
>		goto ERROR_3;
>
>	return 0;


>1) The above carries a built-in assumption: that the mux itself, if it
>is controlled by I2C/SMBus, must be a client of the immediate parent
>segment.  Does anyone know of a mux that doesn't work that way?  E.g.
>a 2x1 mux with a fourth bus connection for mux control only?

The S4882 itself has an interesting architecture. The Philips PCA9556
itself is not an I2C mux chip. It is an 8-bit I/O. On the S4882 each pin
is used as an output, and the pins control two PCA9516 chips, which are
the real (5-way) I2C muxes. The PCA9516 chips don't show on the I2C bus.

This shows that the multiplexing is highly board-dependant. It also shows
that we could see PCA9556 chips which are not means for bus
multiplexing, or PCA9516 chips which are controled by other means (such
as LPC GPIO chips).

However, I don't see how the model you propose wouldn't cover such
cases. What prevents the virtual busses from doing e.g. ISA I/O to
control the multiplexer(s)?


>2) Doesn't address the sysfs hierarchy.  It would be nice to have a
>sysfs structure that is isomorphic to the i2c bus structure... I think
>USB is like that so I will look into it.

I wonder if it is worth the effort. There aren't that many multiplexed
SMBus systems out there, and we still have to see multilevel muxes. The
problem I see is that a sysfs structure change would most likely require
changes to user-space tools such as i2cdetect. While not impossible to
do, I think we have to think about these changes before taking the
actual move.

Thanks,

--
Jean Delvare
