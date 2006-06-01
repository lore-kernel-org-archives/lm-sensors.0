From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 01 Jun 2006 12:02:54 +0000
Subject: [lm-sensors] [PATCH 1/3] i2c: allow i2c core to instantiate
Message-Id: <20060601120254.GD5739@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060527142030.GA5739@jupiter.solarsys.private>
In-Reply-To: <20060527142030.GA5739@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nathan:

* Nathan Lutchansky <lutchann at litech.org> [2006-05-31 01:49:25 -0400]:
> I was hoping I'd have more time to finish this up, but it's becoming
> apparent that it's not going to fit anywhere in my schedule.  I'm sorry I
> have to drop this in a really unfinished state, but ignoring your emails
> isn't helping anything.

Hrm, I hope I haven't put you off somehow.

> I'll try to address your major questions below, though:
> 
> On Sat, 27 May 2006, Mark M. Hoffman wrote:
> 
> > Summary:  the biggest immediate problem here is that i2c_add_client()
> > leaks a struct i2c_client by design, AFAICT.
> 
> Right, clients added with i2c_add_client() remain present until the bus is 
> removed from the system, even if the driver for that client is removed.  
> This is the behavior you would expect from i2c buses with a fixed, known 
> list of clients present.  However, for auto-probed clients, it is a change 
> in behavior that users probably would not appreciate.

I meant leak literally... as in never kfree'ed.  But now I see that it would
get kfree'ed from within i2c_del_adapter().  I'm not sure how I missed that.

> > I do see that this approach addresses a requirement of embedded systems
> > and others who know a priori what hardware is present.  It is also nice
> > that it does not force any changes to current drivers.  
> > 
> > However, I think the i2c_add_client() function is awkward.  You say that
> > this function could be called by an adapter that knows what devices it
> > has... but what if the adapter is a generic driver like i2c-i801?  For
> > the embedded scenario, it would be preferable to further decouple these
> > two pieces:
> > 
> > 	[ adapter driver for bus foo ]
> > 	[ bus foo has devices x, y & z ]
> 
> Yes, it would be nice to be able to pass a list of attached devices to
> some adapter drivers.  Possibly this could be passed in as a module
> parameter or as a field in the platform data structure for platform 
> devices.  However, this list might be dependent upon the contents of an 
> EEPROM device located on that bus, so it would be good to leave this part 
> as flexible as possible.

In the embedded scenario, would it be appropriate to pass such a list
from platform_notify()?  That looks like the right place to me.

> > I would argue against a general move to this method for hwmon and others.
> > There would be no benefit that I can tell; in the long term I would expect
> > the i2c_add_client() function to disappear anyway.
> 
> What do you expect would be a more suitable method for hwmon to
> instantiate clients?  The current i2c_probe() mechanism is rather lacking;  
> requiring users to pass arcane module parameters to each chip module is
> not ideal,

It may not be ideal, but it's rarely necessary for hwmon at any rate.
[see below for an answer to "what do you expect..."]

> and is completely impossible to use where the client drivers
> are compiled directly into the kernel.

Documentation/kernel-parameters.txt: 3rd paragraph

> I suspect you'll eventually need
> to go to a system where drivers can be bound at runtime to specific
> addresses using sysfs, similar to the SCSI subsystem where new devices can
> be probed by echoing "scsi add-single-device 4 0 6 0" to /proc/scsi/scsi.  
> Such a mechanism would probably use something like i2c_add_client on the
> backend.

There are some i2c devices that are 100% not detectable by probing.  This
would be a good alternative for those.

> > >  static int i2c_device_match(struct device *dev, struct device_driver *drv)
> > >  {
> > > -	return 1;
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct i2c_driver *driver = to_i2c_driver(drv);
> > > +
> > > +	return client->driver_id = driver->id;
> > >  }
> > 
> > As I mentioned previously - I think this function will ultimately
> > need to change.  As you have it, it short-circuits the driver model
> > probing for any client without a specific driver ID.  I understand
> > that this doesn't matter at the moment.
> 
> I'm still not sure I understand why some drivers would not have IDs
> assigned.  For embedded systems or V4L devices, where there is a fixed
> list of clients known to be present, how else would the proper client
> driver for each address be specified?

I will try to answer this and "What do you expect ..." above at the same
time, but it probably takes a patch to make it clear.

If we're going to better integrate the i2c subsystem with the driver model,
I think the i2c core has to instantiate all client structs.  It would 
enumerate through the i2c address space looking to match (i2c_device_match)
at each address.  The client->driver_id may or may not be filled in at
that point; depends on whether the adapter has a known list of devices.
If the client does have a driver_id, that will serve the purpose of
*ruling out* all other devices.  That is why I suggested (the equivalent
to) this earlier:

	if (client->driver_id) 
		return client->driver_id = driver->id;

If we make it past that, we look for a match with the driver's address
data.  Assuming that's good, we'll do i2c_device_probe() much as you
have it.  We would continue to use adapter->class to restrict or modify
probing behavior, but we might be able to reduce it to PROBE and NOPROBE.
At least for the embedded scenario, there should be an I2C_CLASS_NONE.

That's my vision for now.  I will send patches as soon as I can.

> > >  static int i2c_device_probe(struct device *dev)
> > >  {
> > > -	return -ENODEV;
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct i2c_driver *driver = to_i2c_driver(dev->driver);
> > > +	int error = -ENODEV;
> > > +
> > > +	if (driver->probe) {
> > > +		client->driver = driver;
> > > +		error = driver->probe(client);
> > > +		if (error < 0)
> > > +			client->driver = NULL;
> > > +		else
> > > +			i2c_notify_adapter(client);
> > > +	}
> > > +	return error < 0 ? error : 0;
> > >  }
> > 
> > What's wrong with "if (error)" here?  Likewise "return error" at the end?
> 
> I believe I intended for the driver->probe() function to return either 0 
> or a positive value on success, although I don't remember what those would 
> have indicated.  But i2c_device_probe() would always need to return only 0 
> on success, which is why the strange comparisons are there.
> 
> > > +static int __i2c_detach_client(struct i2c_client *client)
> > > +{
> > > +	struct i2c_driver *driver = client->driver;
> > > +	int error;
> > > +
> > > +	if (driver && driver->detach_client)
> > > +		return driver->detach_client(client);
> > > +
> > 
> > [ (!driver) is impossible there, i.e. indicates a bug, no? ]
> 
> No, it's perfectly fine for a client to exist on a bus with no associated 
> client driver.  This will happen if a client is instantiated with 
> i2c_add_client() and the indicated driver ID does not correspond to an 
> existing driver, perhaps because a module is not loaded or the driver is 
> not compiled into the kernel.  Allowing driverless clients to exist was 
> the point of the patch, really...

OK, thanks.  Your second patch had no examples of calling i2c_add_client()
from an adapter rather than from a driver, so I didn't consider that case.

> > ... to here you're just making the driver->detach_client() callback
> > optional.  That's a problem:  I don't see where you're going to
> > kfree the struct i2c_client that i2c_add_client() allocates.  This might
> > explain the "can't unload then reload a client driver module" caveat
> > that you mentioned earlier.
> 
> Right, yes.  Any i2c_client struct created by i2c_add_client() will only 
> ever get destroyed by i2c_del_adapter(), as discussed above.
> 
> > > +	error = i2c_add_to_bus(client);
> > > +	if (error)
> > > +		return error;
> > 
> > [ I prefer "if ((error = i2c_add_to_bus(client)))" here ]
> 
> I'm not fond of hiding assignments in if() statements, but I think that's 
> just personal style.
> 
> > > -	module_put(client->driver->driver.owner);
> > > +	if (client->driver)
> > > +		module_put(client->driver->driver.owner);
> > 
> > As Jean Delvare pointed out... !(client->driver) is a bug.  In this
> > case "BUG_ON" is no better than just leaving it as it was - it will
> > oops either way.
> 
> Yeah, I didn't think about the module reference counting, it definitely 
> needs to be fixed.
> 
> Again, I'm really sorry to have to drop this, but I have too much going on 
> at the moment.  I'd still be interested in following future discussion on 
> the topic, though.  -Nathan

No problem.  I'm sorry it took so long to review as well.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


