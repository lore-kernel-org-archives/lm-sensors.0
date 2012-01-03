From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 03 Jan 2012 17:26:02 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <1325611562.3996.50.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Tue, 2012-01-03 at 05:32 -0500, Frans Meulenbroeks wrote:
> Hi Guenter,
> 
> Thanks for your replies.
> 
> Let me answer all of your replies in one go:
> 
> lm75.c: will fix
> 
> checkpatch issue: I used checkfile, not checkpatch (actually I was
> unaware of checkpatch -f and without -f it does say it is not a
> unified diff and no other messages)
> checkpatch -f indeed reports errors, I'll give this another stab. 
> 
Where do you get checkfile from ? Doesn't seem to exist, at least not in
the latest kernel.

> lm80 comments:
> 
> 2012/1/2 Guenter Roeck <guenter.roeck@ericsson.com>
> [...]
>  
> 
>         >
>         > +/*
>         > +   Note: safe_lm80_read_value is a helper macro for
>         lm80_update_device
>         > +      It reads a value using lm80_read_value and jumps to
>         abort
>         > +      in case of an error.
>         > +      Due to this jump and because it modifies the first
>         arguement
>         
>         
>                return sprintf(buf, "%d\n",
>         IN_FROM_REG(data->value[nr])); \
>         s/arguement/argument/
>         
>         > +      it has to be a macro
>         
>         
>         This is exactly the reason why it should not be a macro: It
>         uses two variables
>         defined outside the macro, it depends on a label defined
>         outside the macro,
>         and it modifies a variable passed to it. Way too many side
>         effects for a macro,
>         and just asking for trouble later on.
> 
> I am aware of that. That is why I added the comment and kept the macro
> close to the function. 
> 
>         
>         Sure, I understand you want to limit the changes to
>         lm80_update_device, but you'll have
>         to bite the bullet here. Just make it
>         
>                reg = lm80_read_value(client, <reg>);
>                if (reg < 0) {
>                        ret = ERR_PTR(reg);
>                        data->valid = 0;
>                        goto abort;
>                }
>                data-><regstore> = reg;
>         
>         I don't think the dev_dbg is really needed, since the error
>         will now be returned
>         to the user anyway.
> 
> I've thought about that before writing the macro. Issue is that this
> code snippet will be about 16 times in this file. That does not really
> make things better readable and maintainable.
> 
> If something like
> rv = helperfunc(client, reg1, valptr1);
> if (!rv) 
>    rv = helperfunc(client, reg2, valptr2);
> if (!rv) 
>    rv = helperfunc(client, reg3, valptr3);
> 
> is ok, I think I could come up with a small helper func and avoid that
> things become too wieldy and unreadable.
> Is this acceptable wrt coding style.
> (and maybe it has to be if (rv < 0) or so but I hope you get the idea)
> 
How about something like

	rv = helperfunc(client, reg, &val);
	if (rv)
		goto abort;
	...
	goto done;

abort:
	ret = ERR_PTR(rv);
	data->valid = 0;
done:
	mutex_unlock(&data->update_lock);
	return ret;

or

	rv = read(client, reg);
	if (rv < 0)
		goto abort;
	storage = rv;

followed by the rest of the code above, to avoid the helper function.

[ ... ]

> 
>         
>         On a side note, this means the chip will only get
>         (re-)initialized if polled again.
>         Is that ok for your application ? Not that any alternatives
>         would be easy to implement - a cleaner
>         solution would be for your system to detect that the device
>         was pulled, unload the driver if that
>         happens, and reload it once the device is re-inserted. At
>         least this is how we handle it in our
>         systems.
> 
> Hm, yes.
> For our app this is ok. I poll the device every second.
> And as it stands there is not really a mechanism to detect that the
> device was pulled (apart from read operations to the device failing)
> (at least not in our system).
> 
> In our system the LM80 is with the fan unit and if the fan unit is
> removed also the LM80 is disconnected. I2C is of course not hot
> pluggable, and actually we state in the documentation that fans are
> not hot swappable, but we want to be able to properly deal with the
> situation of a user does (as irrespective of what the manual says,
> someone is going to do this anyway).
> 
> If you feel there is a better solution without changing the hardware
> interface, I'd like to hear from you as I am always eager to improve
> things.
> 

Depends on how your polling works. You might do something like

    while (true) {
	error = poll_lm80();
	if (error) {
		scream and log event;
		unload lm80 driver;
		do {
			sleep(1);
			error = read_i2c_register(bus, addr, reg);
			// use i2cget if this is a script
		}  while (error);
		load lm80 driver;
	}
	sleep(1);
    }

Of course that only works if you only have a single lm80 in your system,
and if you build the lm80 driver as module.

Would this work for you ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
