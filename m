From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: NCLV-D SMBus - proposal to a solution
Message-Id: <4263D1BE.3060509@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4262C492.10808@sh.cvut.cz>
In-Reply-To: <4262C492.10808@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hello,

> 
> 2) Some kind of multiplexing bus driver that will allow us to "see" both of
> memory EEPROMs and monitoring chip.


> 
> Ad 2)
> Thank you for information there are very helpful. We agreed with Jean that most
> clean solution to a problem would be a "multiplexing bus driver" (users can use
> until this is done the isaset trick). As you might noticed the multiplexer just
> switches the intel SMBus host between four busses. We are interrested in bus 0
> and bus 1. One is with SPD EEPROMs and second contain 792 chip. We have already
> similar driver in kernel for this that is called i2c-amd756-s4882.c.
> 
> Your driver will be very similar except that the multiplexer itself is not
> on the smbus but you need to do same trick as with isaset command. Generally
> you would need to register the PCI device to your multiplexing driver, get the
> GPIO base addr (same as my hide and seek patch) and switch it to 0x0 or 0x08
> when you have request from bus 0 or bus 1...
> 
> How is the multiplexed bus concept working:
> 
> It creates more busses from i2c core point of view. When there is some request
> to read or write from a driver it will go to this virtual bus driver,
> this driver will switch the bus and call the original driver. So it just create
> handlers for "xfer" function that is the transmission function.
> 
> When it is done you will have more virtual busses.
> 
> modprobe i2c-i801
> modprobe your multiplex driver
> 
> so if you will do
> i2cdetect 0
> It will switch the multiplexer and you will see only SPD eeproms here
> if you will do:
> i2cdetect 1
> You will see addresses with 792 chip.
> 
> Later you just modprobe eeprom and modprobe w83792 and all will work as expected
> . You will see in sensors command both eeproms and chip data.
> 
> The existing driver has 200 lines and I guess yours would have like 300 so it is
> not so difficult to write it. Unfortunalely I'm quite busy these days and Jean
> has a lot of work too so I cant write it for you but of course I will help you.
> 

This is a good time to bring up the i2c-virtual driver as an alternative to the -s4882.c
style of multiplexing driver. I believe this is a cleaner and more general approach to
bus multiplexing.

The i2c-virtual driver is checked in to sensors but the small changes required to i2c-core.c
are not checked in. I held off late last year because 2.9.0 was coming out soon.
Now that 2.9.1 is out it's  time to look at it again.
I have to rework the i2c-core changes because they conflicted with
other recent changes to i2c-core.

attached are the proposed changes to i2c-core for comment.

mds
-------------- next part --------------
88a89,91
>  *
>  * i2c_add_adapter_nolock does the actual work.  It is split
>  * out so it can be called externally by i2c-virtual.c without deadlocking.
90c93
< int i2c_add_adapter(struct i2c_adapter *adap)
---
> int i2c_add_adapter_nolock(struct i2c_adapter *adap)
94d96
< 	down(&core_lists);
129a132,140
> 	return res;
> }
> 
> int i2c_add_adapter(struct i2c_adapter *adap)
> {
> 	int res;
> 
> 	down(&core_lists);
>         res = i2c_add_adapter_nolock(adap);
130a142
> 
135c147,154
< int i2c_del_adapter(struct i2c_adapter *adap)
---
> /*
>  * i2c_del_adapter is the corresponding function to detach all clients
>  * for a bus/adapter and then deregister it.
>  *
>  * i2c_del_adapter_nolock does the actual work.  It is split
>  * out so it can be called externally by i2c-virtual.c without deadlocking.
>  */
> int i2c_del_adapter_nolock(struct i2c_adapter *adap)
139d157
< 	down(&core_lists);
188a207,215
> 	return res;
> }
> 
> int i2c_del_adapter(struct i2c_adapter *adap)
> {
> 	int res;
> 
> 	down(&core_lists);
>         res = i2c_del_adapter_nolock(adap);
189a217
> 
313c341,349
< 	for (i = 0; i < I2C_CLIENT_MAX ; i++) 
---
> 
> #if defined(CONFIG_I2C_VIRTUAL) || defined(CONFIG_I2C_VIRTUAL_MODULE)
> 	/* Must check for aliasing on i2c-multiplexed busses since a virt
>          * bus will always appear to have its own mux as an address.  Without
>          * this check we can get infinite recursion during bus scans.
>          */
> 	for ( ; adapter; adapter = i2c_virt_parent(adapter))
> #endif
>             for (i = 0; i < I2C_CLIENT_MAX ; i++) {
316c352
< 
---
>             }
1480a1517,1518
> EXPORT_SYMBOL(i2c_add_adapter_nolock);
> EXPORT_SYMBOL(i2c_del_adapter_nolock);
