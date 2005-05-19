From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: ATXP1 kernel patch
Message-Id: <vUyBEGbe.1106216487.5706100.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sebastian,

> I want to add two things to my last message:
>
> - The VRM check in atxp1_detect was moved above i2c_attach_client.

Good idea. It's better not to register anything if we are giving it all
up in the end. However, you forgot to free the memory you allocated.

> - I've channged the detection method, because
> ..
> temp = i2c_smbus_read_byte_data(new_client, ATXP1_VID);
> if(!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
>     (i2c_smbus_read_byte_data(new_client, 0x11) = temp)
> ...
>
> the register 0x10,0x11 aren't the same as 0x00 all time (the dump say
> it, but I think that's because the device is dumped from 0x00 upwards).
> If you directly read 0x10, 0x11 they are also zero.

You are right that what addresses 0x10 and 0x11 return depend on what was
previously read from the chip, because these address don't map to
physical registers. However this is precisely a very good way to detect
exotic chips such as the ATXP1. Please do some tests to understand what
exactly determines the values being returned. Usually this is the last
"real" value read, but in your case this seems to be different.

At the very least you can check that both addresses (0x10 and 0x11)
return the same value, whatever this is, right?

I really think we need to use this, or the detection will be possibly
unreliable (although we are lucky that the ATXP1 uses uncommon
addresses).

> Instead I'm checking register 0x05, bit 7. It is always set:
> ..
> if(!(i2c_smbus_read_byte_data(new_client, 0x05) & 0x80))
> ..

I don't know how you do know that, but if it works, fine with me.

Now answering your previous post:

> Something like in the attached patch? I've not added the other VRMs yet,
> first need to know if the ATXP1 is used with other VRMs.

Yes, something like that.

> > Huh. Looks even more complex. Do you really need to read all 10 first
> > registers, while you were previously only reading 2? What is the benefit
> > of having a separate "valid" bit for each register since you always read
> > them all at once anyway?
> 
> For future versions, which are using more (all registers). For general
> purpose IOs (used to control other voltages, extra functions) and
> watchdog timer.

We don't much care about future versions at this point. There might
never be any future version. If there is, you'll be able to do all the
required changes at that time. The code you will submit for the first
version of your driver has to make sense per se. Please only read the
registers you need.

> Also a register variable gets only updated at start or when a value was
> written.

Right, I did not understand what you were doing in the first place,
because it differs from what the other i2c client drivers do.

The reason why i2c clients have an update function is to centralize and
control i2c traffic that can be triggered by regular users. Remember
that regular users can read from sysfs files your driver exports. In
order to prevent possible bus saturation by regular users, all client
drivers have a timer in their update function, which prevent register
updates more frequent than (typically) one second. Your driver doesn't.
Please see in e.g. lm90.c how this has to be done, and do the same.

Having individual validity bits then becomes useless. The only driver
which has that is eeprom.c, but only because it has a very large number
of "registers" (256 as opposed to less than 30 for most drivers) and a
very long cache timeout (5 minutes instead of 1 second). For your driver
it doesn't make sense. You should NOT suppose that register values
never change, this is dangerous.

So please:
1* Add a timer check in your update function. 1 second (HZ) should be
fine.
2* Only read registers you need.
3* Have a single valid bit for them all.

> I don't know if the ATXP1 is used on boards with < 9.0 at all. Would be
> interesting if somebody knows.

I have no idea, sorry. I see no reason why it wouldn't be technically
possible, but it doesn't mean that any motherboard manufacturer
actually did it.

Random comments on your code now:

> #include <linux/moduleparam.h>

You don't need this.

> static int atxp1_write(struct i2c_client *client, unsigned char adr, unsigned char data)
> {
> 	int ret = -1;
> 
> 	ret = i2c_smbus_write_byte_data(client, adr, data);
> 
> 	if(ret < 0) {
> 		dev_err(&client->dev, "Write failed.\n");
> 		return -1;
> 	}
> 
> 	return 0;
> }

Two D to "address" in english. Initialization of ret to -1 is usless.
You better propagate the error value than arbitrary return -1 on error.
You could also change the error message to indicate which address you
were trying to read, that might help analyzing problems later.

BTW, you never check the return value whan calling this function.

> 	if(data->vrm != 90) {
> 		dev_err(&new_client->dev, "Not supporting VRM %d\n", data->vrm);
> 		return 0;
> 	}

Why don't use %d.%d with /10 and %10 like you do in case of success?

> static int atxp1_detach_client(struct i2c_client * client)
> {
> 	int err;
> 
> 	err = i2c_detach_client(client);
> 
> 	if (err)
> 		dev_err(&client->dev, "Failed to detach client.\n");
> 	else
> 		kfree(i2c_get_clientdata(client));
> 
> 	return 0;
> };

You better propagate the error instead of returning 0 if it occurs.

> static int __init atxp1_init(void)
> {
> 	i2c_add_driver(&atxp1_driver);
> 
> 	return 0;
> };

Ditto. i2c_add_driver may fail.

Thanks,
--
Jean Delvare
