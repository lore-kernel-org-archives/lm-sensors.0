From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 27 May 2006 14:20:30 +0000
Subject: [lm-sensors] [PATCH 1/3] i2c: allow i2c core to instantiate
Message-Id: <20060527142030.GA5739@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nathan:

OK, I have finished reviewing this patch in detail.  Note that some
of the comments are just me testing my understanding.

Summary:  the biggest immediate problem here is that i2c_add_client()
leaks a struct i2c_client by design, AFAICT.

I do see that this approach addresses a requirement of embedded systems
and others who know a priori what hardware is present.  It is also nice
that it does not force any changes to current drivers.  

However, I think the i2c_add_client() function is awkward.  You say that
this function could be called by an adapter that knows what devices it
has... but what if the adapter is a generic driver like i2c-i801?  For
the embedded scenario, it would be preferable to further decouple these
two pieces:

	[ adapter driver for bus foo ]
	[ bus foo has devices x, y & z ]

On the other hand, I'm not sure how to do that right now; it will take
more study on my part.

Nonetheless, I'm not completely opposed to merging (something like) this
patch as an interim solution if it will lead to concrete improvements
in the behavior of some v4l drivers.  I would like to see at least one
example of that first.  I don't think the v4l drivers that you did convert
in patch #2 qualify, though they do demonstrate that the conversion itself
is not difficult.

I would argue against a general move to this method for hwmon and others.
There would be no benefit that I can tell; in the long term I would expect
the i2c_add_client() function to disappear anyway.

Finally, the patch itself...

* Nathan Lutchansky <lutchann at litech.org> [2006-04-01 04:11:48 -0500]:
> Add a new function i2c_add_client() which can instantiate and bind i2c
> clients directly by adapter, address and driver ID.  Client drivers can
> support this by implementing the probe() and remove() functions which
> accept a pre-filled i2c_client struct to manage.
> 
> Signed-off-by: Nathan Lutchansky <lutchann at litech.org>
> 
>  drivers/i2c/i2c-core.c |  157 +++++++++++++++++++++++++++++++++++---------
>  include/linux/i2c.h    |    8 ++
>  2 files changed, 136 insertions(+), 29 deletions(-)
> 
> --- linux-i2c-dev.orig/drivers/i2c/i2c-core.c
> +++ linux-i2c-dev/drivers/i2c/i2c-core.c
> @@ -40,10 +40,15 @@ static LIST_HEAD(drivers);
>  static DEFINE_MUTEX(core_lists);
>  static DEFINE_IDR(i2c_adapter_idr);
>  
> -/* match always succeeds, as we want the probe() to tell if we really accept this match */
> +static void i2c_notify_adapter(struct i2c_client *client);
> +static void i2c_register_client(struct i2c_client *client);
> +

The second declaration is unnecessary.

>  static int i2c_device_match(struct device *dev, struct device_driver *drv)
>  {
> -	return 1;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct i2c_driver *driver = to_i2c_driver(drv);
> +
> +	return client->driver_id = driver->id;
>  }

As I mentioned previously - I think this function will ultimately
need to change.  As you have it, it short-circuits the driver model
probing for any client without a specific driver ID.  I understand
that this doesn't matter at the moment.

>  static int i2c_bus_suspend(struct device * dev, pm_message_t state)
> @@ -66,11 +71,31 @@ static int i2c_bus_resume(struct device 
>  
>  static int i2c_device_probe(struct device *dev)
>  {
> -	return -ENODEV;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct i2c_driver *driver = to_i2c_driver(dev->driver);
> +	int error = -ENODEV;
> +
> +	if (driver->probe) {
> +		client->driver = driver;
> +		error = driver->probe(client);
> +		if (error < 0)
> +			client->driver = NULL;
> +		else
> +			i2c_notify_adapter(client);
> +	}
> +	return error < 0 ? error : 0;
>  }

What's wrong with "if (error)" here?  Likewise "return error" at the end?

>  static int i2c_device_remove(struct device *dev)
>  {
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (client->driver) {
> +		if (client->driver->remove)
> +			client->driver->remove(client);
> +		if (client->driver->probe)
> +			client->driver = NULL;
> +	}
>  	return 0;
>  }

I would like to see "struct i2c_driver *driver = client->driver" at the top
of this function... the rest would be more readable.

> @@ -208,6 +233,19 @@ out_unlock:
>  	return res;
>  }

 From here...
> +static int __i2c_detach_client(struct i2c_client *client)
> +{
> +	struct i2c_driver *driver = client->driver;
> +	int error;
> +
> +	if (driver && driver->detach_client)
> +		return driver->detach_client(client);
> +

[ (!driver) is impossible there, i.e. indicates a bug, no? ]

> +	error = i2c_detach_client(client);
> +	if (error >= 0)
> +		kfree(client);
> +	return error;
> +}
>  
>  int i2c_del_adapter(struct i2c_adapter *adap)
>  {
> @@ -247,7 +285,7 @@ int i2c_del_adapter(struct i2c_adapter *
>  	list_for_each_safe(item, _n, &adap->clients) {
>  		client = list_entry(item, struct i2c_client, list);
>  
> -		if ((res=client->driver->detach_client(client))) {
> +		if ((res=__i2c_detach_client(client))) {
>  			dev_err(&adap->dev, "detach_client failed for client "
>  				"[%s] at address 0x%02x\n", client->name,
>  				client->addr);

... to here you're just making the driver->detach_client() callback
optional.  That's a problem:  I don't see where you're going to
kfree the struct i2c_client that i2c_add_client() allocates.  This might
explain the "can't unload then reload a client driver module" caveat
that you mentioned earlier.

 From here...
> @@ -316,16 +354,13 @@ int i2c_register_driver(struct module *o
>  }
>  EXPORT_SYMBOL(i2c_register_driver);
>  
> -int i2c_del_driver(struct i2c_driver *driver)
> +static int i2c_remove_all_clients(struct i2c_driver *driver)
>  {
>  	struct list_head   *item1, *item2, *_n;
>  	struct i2c_client  *client;
>  	struct i2c_adapter *adap;
> -	
>  	int res = 0;
>  
> -	mutex_lock(&core_lists);
> -
>  	/* Have a look at each adapter, if clients of this driver are still
>  	 * attached. If so, detach them to be able to kill the driver 
>  	 * afterwards.
> @@ -337,7 +372,7 @@ int i2c_del_driver(struct i2c_driver *dr
>  				dev_err(&adap->dev, "detach_adapter failed "
>  					"for driver [%s]\n",
>  					driver->driver.name);
> -				goto out_unlock;
> +				return res;
>  			}
>  		} else {
>  			list_for_each_safe(item2, _n, &adap->clients) {
> @@ -352,19 +387,33 @@ int i2c_del_driver(struct i2c_driver *dr
>  						"failed for client [%s] at "
>  						"0x%02x\n", client->name,
>  						client->addr);
> -					goto out_unlock;
> +					return res;
>  				}
>  			}
>  		}
>  	}
>  
> +	return 0;
> +}
> +
> +int i2c_del_driver(struct i2c_driver *driver)
> +{
> +	int error = 0;
> +
> +	mutex_lock(&core_lists);
> +
> +	if (driver->detach_adapter || driver->detach_client) {
> +		error = i2c_remove_all_clients(driver);
> +		if (error < 0)
> +			goto out_unlock;
> +	}
>  	driver_unregister(&driver->driver);
>  	list_del(&driver->list);
>  	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
>  
>   out_unlock:
>  	mutex_unlock(&core_lists);
> -	return 0;
> +	return error;
>  }

... down to here is a refactoring of i2c_del_driver(), the point of which is
to make driver->detach_client() optional - same problem as above.

I might have refactored further, splitting up the driver->detach_adapter()
bits from the driver->detach_client() bits.

 From here...
>  static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
> @@ -391,7 +440,7 @@ int i2c_check_addr(struct i2c_adapter *a
>  	return rval;
>  }
>  
> -int i2c_attach_client(struct i2c_client *client)
> +static int i2c_add_to_bus(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  
> @@ -402,32 +451,52 @@ int i2c_attach_client(struct i2c_client 
>  	}
>  	list_add_tail(&client->list,&adapter->clients);
>  	mutex_unlock(&adapter->clist_lock);
> -	
> -	if (adapter->client_register)  {
> -		if (adapter->client_register(client))  {
> -			dev_dbg(&adapter->dev, "client_register "
> -				"failed for client [%s] at 0x%02x\n",
> -				client->name, client->addr);
> -		}
> +	return 0;
> +}
> +
> +static void i2c_notify_adapter(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +
> +	if (!adapter->client_register)
> +		return;
> +	if (adapter->client_register(client))  {
> +		dev_dbg(&adapter->dev, "client_register "
> +			"failed for client [%s] at 0x%02x\n",
> +			client->name, client->addr);
>  	}
> +}
>  
> +static void i2c_register_client(struct i2c_client *client)
> +{
>  	client->usage_count = 0;
>  
>  	client->dev.parent = &client->adapter->dev;
> -	client->dev.driver = &client->driver->driver;
>  	client->dev.bus = &i2c_bus_type;
>  	client->dev.release = &i2c_client_release;
>  	
>  	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
> -		"%d-%04x", i2c_adapter_id(adapter), client->addr);
> -	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
> -		client->name, client->dev.bus_id);
> +		"%d-%04x", i2c_adapter_id(client->adapter), client->addr);
> +
> +	dev_dbg(&client->adapter->dev, "client [%s] registered with bus id "
> +		"%s\n", client->name, client->dev.bus_id);
> +
>  	device_register(&client->dev);
>  	device_create_file(&client->dev, &dev_attr_client_name);
> -	
> -	return 0;
>  }
>  
> +int i2c_attach_client(struct i2c_client *client)
> +{
> +	int error;
> +
> +	error = i2c_add_to_bus(client);
> +	if (error)
> +		return error;

[ I prefer "if ((error = i2c_add_to_bus(client)))" here ]

> +	i2c_notify_adapter(client);
> +	client->dev.driver = &client->driver->driver;
> +	i2c_register_client(client);
> +	return 0;
> +}

... down to here is a refactoring of i2c_attach_client(), the point of which
is to reuse pieces of it in i2c_add_client().

>  int i2c_detach_client(struct i2c_client *client)
>  {
> @@ -462,11 +531,37 @@ int i2c_detach_client(struct i2c_client 
>  	return res;
>  }
>  
> -static int i2c_inc_use_client(struct i2c_client *client)
> +int i2c_add_client(struct i2c_adapter *adap, int address,
> +				int driver_id, int kind)
>  {
> +	struct i2c_client *client;
> +	int error;
>  
> -	if (!try_module_get(client->driver->driver.owner))
> -		return -ENODEV;
> +	client = kzalloc(sizeof(*client), GFP_KERNEL);
> +	if (client = NULL)
> +		return -ENOMEM;
> +	client->driver_id = driver_id;
> +	client->addr = address;
> +	client->kind = kind;
> +	client->adapter = adap;
> +	snprintf(client->name, sizeof(client->name) - 1, "device type %x, "
> +			"kind %d", driver_id, kind);
> +
> +	error = i2c_add_to_bus(client);
> +	if (error) {

if ((error = i2c_add_to_bus(client)))

> +		kfree(client);
> +		return error;
> +	}
> +	i2c_register_client(client);
> +
> +	return 0;
> +}
> +
> +static int i2c_inc_use_client(struct i2c_client *client)
> +{
> +	if (client->driver)
> +		if (!try_module_get(client->driver->driver.owner))
> +			return -ENODEV;
>  	if (!try_module_get(client->adapter->owner)) {
>  		module_put(client->driver->driver.owner);
>  		return -ENODEV;
> @@ -477,7 +572,8 @@ static int i2c_inc_use_client(struct i2c
>  
>  static void i2c_dec_use_client(struct i2c_client *client)
>  {
> -	module_put(client->driver->driver.owner);
> +	if (client->driver)
> +		module_put(client->driver->driver.owner);
>  	module_put(client->adapter->owner);
>  }

As Jean Delvare pointed out... !(client->driver) is a bug.  In this
case "BUG_ON" is no better than just leaving it as it was - it will
oops either way.

> @@ -516,6 +612,8 @@ void i2c_clients_command(struct i2c_adap
>  	mutex_lock(&adap->clist_lock);
>  	list_for_each(item,&adap->clients) {
>  		client = list_entry(item, struct i2c_client, list);
> +		if (!client->driver)
> +			continue;
>  		if (!try_module_get(client->driver->driver.owner))
>  			continue;
>  		if (NULL != client->driver->command) {
> @@ -1138,6 +1236,7 @@ EXPORT_SYMBOL(i2c_del_adapter);
>  EXPORT_SYMBOL(i2c_del_driver);
>  EXPORT_SYMBOL(i2c_attach_client);
>  EXPORT_SYMBOL(i2c_detach_client);
> +EXPORT_SYMBOL(i2c_add_client);
>  EXPORT_SYMBOL(i2c_use_client);
>  EXPORT_SYMBOL(i2c_release_client);
>  EXPORT_SYMBOL(i2c_clients_command);
> --- linux-i2c-dev.orig/include/linux/i2c.h
> +++ linux-i2c-dev/include/linux/i2c.h
> @@ -117,6 +117,9 @@ struct i2c_driver {
>  	int id;
>  	unsigned int class;
>  
> +	int (*probe)(struct i2c_client *);   /* new device detected */
> +	void (*remove)(struct i2c_client *); /* device/adapter removed */
> +
>  	/* Notifies the driver that a new bus has appeared. This routine
>  	 * can be used by the driver to test if the bus meets its conditions
>  	 * & seek for the presence of the chip(s) it supports. If found, it 
> @@ -151,10 +154,12 @@ struct i2c_driver {
>   * function is mainly used for lookup & other admin. functions.
>   */
>  struct i2c_client {
> +	int driver_id;			/* match against i2c_driver.id  */
>  	unsigned int flags;		/* div., see below		*/
>  	unsigned short addr;		/* chip address - NOTE: 7bit 	*/
>  					/* addresses are stored in the	*/
>  					/* _LOWER_ 7 bits		*/
> +	int kind;			/* forced chip kind, if needed  */
>  	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
>  	struct i2c_driver *driver;	/* and our access routines	*/
>  	int usage_count;		/* How many accesses currently  */
> @@ -305,6 +310,9 @@ static inline int i2c_add_driver(struct 
>  extern int i2c_attach_client(struct i2c_client *);
>  extern int i2c_detach_client(struct i2c_client *);
>  
> +extern int i2c_add_client(struct i2c_adapter *adap, int address,
> +				int driver_id, int kind);
> +
>  /* Should be used to make sure that client-struct is valid and that it
>     is okay to access the i2c-client.
>     returns -ENODEV if client has gone in the meantime */

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


