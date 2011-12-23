From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Dec 2011 16:23:17 +0000
Subject: Re: [lm-sensors] i2c errors while updating sensors
Message-Id: <20111223162317.GA2730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACW_hTZsv2LQmjDYWoU715cmodvdyx2Nkem18GuN+WPvFRRbUw@mail.gmail.com>
In-Reply-To: <CACW_hTZsv2LQmjDYWoU715cmodvdyx2Nkem18GuN+WPvFRRbUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Fri, Dec 23, 2011 at 09:44:35AM -0500, Frans Meulenbroeks wrote:
> I was peeking at lm75/lm80 i2c error message handing.
> 
> The problem I am facing is that I am using lm75 for temperature monitoring and
> lm80 for temperature and fan tacho monitoring.
> This is an embedded (powerpc) system using a 2.6.38 kernel, and accessing the
> sensors through the sysfs interface.
> 
> The customer wants to be able to detect if someone accidently disconnects the
> fan (or the monitoring chip dies).
> I know i2c is not hot pluggable, but would have expected to be able to detect
> this error condition
> 
> However, from peeking at the sources, it seems I am not.
> 
> 
> lm75.c says (function lm75_update_device)
>         for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
>             int status;
> 
>             status = lm75_read_value(client, LM75_REG_TEMP[i]);
>             if (status < 0)
>                 dev_dbg(&client->dev, "reg %d, err %d\n",
>                         LM75_REG_TEMP[i], status);
>             else
>                 data->temp[i] = status;
>         }
>         data->last_updated = jiffies;
>         data->valid = 1;
> So there is an error message if dbg is on, but a user will still get the old
> data as temp[i] is not updated.
> 
> Wouldn't it be nice to e.g. add a (bool) attribute data-valid or or so and drop
> that to 0 on a read fail (or maybe 3 subsequent read fails)?

data->valid typically already exists.

> Or is there a better way do detect such a problem in user space (e.g. by
> putting an "error" value in the var)
> 
> I've also peeked at lm80.c
> Here the situation seems to be a little bit worse.
> E.g. I see:
> 
> static int lm80_read_value(struct i2c_client *client, u8 reg)
> {
>     return i2c_smbus_read_byte_data(client, reg);
> }
> 
> ...
> 
>         data->temp >             (lm80_read_value(client, LM80_REG_TEMP) << 8) |
>             (lm80_read_value(client, LM80_REG_RES) & 0xf0);
> 
> but i2c_smbus_read_byte_data may return a negative value upon error.
> To me it seems this is not going to return a sensible value in case the read
> fails (and also not e.g. something like -1)
> 
> Is this desired? Should this be fixed? Or is there a better way to do so?

No, yes, and yes.

Note that returning -1 is not a good idea; one should pass on the error code. 

> If needed, I can have a stab at the code to fix it, but in that case I would
> appreciate some guidance in the direction of the preferred solution (so my work
> is not rejected because it was felt a faulty solution).
> 
There are multiple options. The easiest would be to set data->valid to 0 and return
the error from the _update_device() function. So you would have

	if (status < 0) {
		data->valid = 0;
		return status;
	}

in the update_device() function, and 

	struct lm75_data *data = lm75_update_device(dev);

	if (IS_ERR(data))
		return PTR_ERR(data);

	...

in the _get() function.

Downside is that each read will return an error, even if the read failed on an attribute
which is not currently read. ltc4261.c is an example for this kind of handling.

Another approach would be to store the actual error in the temp[] array, and make it an int
instead of u16/u8.

	int temp[3];

	...

	data->temp[i] = lm75_read_value(client, LM75_REG_TEMP[i]);

	...

	int temp = LM75_TEMP_FROM_REG(data->temp[attr->index]);

	if (temp < 0)
		return temp;
	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(temp));

More effort and more code, but more accurately reports errors. With this approach,
you would have to make sure that u8/u16 <-> int conversions don't introduce errors;
the arithmetic in some drivers depends on the type of the storage variable.
Example for this kind of solution is max16065.c.

Which approach to use really depends on the chip and on the amount of effort one wants
to make. I typically select the first approach for simple chips, and use the second
approach if there is a possibility that the chip returns an error on one read but not
on others. The latter is mostly a concern for microcontroller based i2c devices.

For lm75, the first method should be ok. For lm80, you could use both, depending how much
time you want to spend on it. If there is a chance that one read returns an error while
other reads don't, the second approach would be much better.

If you want to start playing with the lm80 driver, it would be nice if you could also
fix the checkpatch errors and warnings. That should be a separate patch, though.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
