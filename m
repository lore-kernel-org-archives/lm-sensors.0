From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 23 May 2006 02:27:06 +0000
Subject: [lm-sensors] [PATCH 0/3] i2c: move i2c core to the device model
Message-Id: <20060523022706.GA3338@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Nathan Lutchansky <lutchann at litech.org> [2006-05-21 17:52:40 -0400]:
> On Sat, 20 May 2006, Mark M. Hoffman wrote:
> 
> > > With this addition, the match() and probe() functions for the
> > > i2c_bus_type can be implemented.  The match() function simply compares
> > > the i2c_client.driver_id field with the i2c_driver.id field and returns
> > > true if they match.
> > 
> > Your patch has this (drivers/i2c/i2c-core.c):
> > 
> > 46 static int i2c_device_match(struct device *dev, struct device_driver *drv)
> > 47 {
> > 48         struct i2c_client *client = to_i2c_client(dev);
> > 49         struct i2c_driver *driver = to_i2c_driver(drv);
> > 50
> > 51         return client->driver_id = driver->id;
> > 52 }
> > 
> > This precludes using i2c_device_probe() in the future for hwmon drivers.
> > I think the match function will need to be default permissive... e.g.:
> > 
> > 	return driver->id ? (client->driver_id = driver->id) : 1;
> 
> What do you mean?  This would always return a match for the first driver
> found in the list with no ID, which couldn't be useful.  Are you
> suggesting this because some drivers do not have a driver ID assigned?

Sorry, this is what I meant:

	return client->driver_id ? (client->driver_id = driver->id) : 1;

The thought is: if an adapter already knows it wants driver foo, it will
instantiate the client with that ID.  Then i2c_device_match() would prevent
all drivers !foo from probing.  But if it's a plain unspecified client,
generic/hwmon probing could continue from within the driver model.

If you look at drivers/base/dd.c::driver_probe_device() ... if that first
bus->match is successful you move on to do more probing.  I imagine that
this is where the generic/hwmon probing will happen.

This seems (to me) to be what Greg KH had in mind when he first ported this
code to 2.6, with the existing i2c_device_match() returning 1 always.

> > > Like the new client probe() function, there is also a new function to
> > > handle disconnecting the client driver from the i2c_client object, which
> > > is similar to the old detach_client() client function but does not free
> > > the i2c_client memory:
> > > 
> > >     void (*remove)(struct i2c_client *); /* device/adapter removed */
> > > 
> > > So far, so good.  Now the I2C driver binding mechanism is much closer to
> > > how other buses work.
> > 
> > But only for adapters that know exactly what their clients are.
> 
> Clients that are detected by probing also go through this matching
> process when they are attached to the bus object.

AFAICT, no they won't.  Specifically: new clients without a matching driver
ID will never make it as far as i2c_device_probe().

> > > In cases where we need to continue probing (i.e. nearly every driver in
> > > use today), I've left the probing mechanism based on i2c_probe()
> > > completely intact.  That means there's no need to cut over the entire
> > > set of existing I2C drivers--in fact, using this new API is completely
> > > optional for now, and all in-kernel drivers will continue to operate as
> > > they always have.
> > 
> > I understand this patchset wasn't intended to solve all scenarios at
> > once.  Nonetheless... if you have an idea in mind for how to do probing
> > (such as hwmon needs) from within the driver model instead of outside
> > of it, please describe it now.  It looks like these patches carry some
> > implicit vision of what that future will look like - I want to be sure
> > I understand it.
> 
> I'm not sure there's much more we can do--the device model probing 
> mechanism assumes that we can enumerate all devices on the bus, as well as 
> all their configuration information, and then use that information to 
> match devices to drivers.  In I2C that can't be done because we have no 
> way of enumerating all the devices on the bus, nor is there any way to 
> extract identification information from any device in a uniform fashion.
> 
> The probing method could probably be moved more into the core I2C code by 
> attaching the address data to the main i2c_driver struct like Jean's 
> patches did, so as to eliminate most drivers' attach_adapter functions, 
> but I see no reason to force that change immediately.

Sure, we don't need to get it all done at once.  OTOH, if possible I would
like to avoid putting in a new mechanism only to rip it up during 2.6.20-ish.

So, we can't precisely enumerate I2C devices on a bus... but we can enumerate
through the list of valid I2C addresses easily enough.  If the client address
lists are part of the i2c_driver struct (as you and Jean suggest) then
i2c_device_match() is the logical place to make those matches.  When the
match is found, we move on to probing.  The I2C address space is just small
enough that such a brute force enumeration (looking for matches between each
address and each drivers' address list) is not too awful.  And until we get
a match, there would be no actual bus transactions.

I think the idea above can exist alongside the idea of your first patch: when
an adapter already *knows* what driver it wants, much of the above would get
short-circuited.

Before I speculate any more, I should probably put together a patch myself.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


