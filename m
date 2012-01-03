From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 03 Jan 2012 23:27:08 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <1325633228.26706.16.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-03 at 17:17 -0500, Frans Meulenbroeks wrote:
> 
> 
> 2012/1/3 Guenter Roeck <guenter.roeck@ericsson.com>
>         Hi Frans,
>         
>         On Tue, 2012-01-03 at 05:32 -0500, Frans Meulenbroeks wrote:
>         > Hi Guenter,
>         >
>         > Thanks for your replies.
>         >
>         > Let me answer all of your replies in one go:
>         >
>         > lm75.c: will fix
>         >
>         > checkpatch issue: I used checkfile, not checkpatch (actually
>         I was
>         > unaware of checkpatch -f and without -f it does say it is
>         not a
>         > unified diff and no other messages)
>         > checkpatch -f indeed reports errors, I'll give this another
>         stab.
>         >
>         
>         Where do you get checkfile from ? Doesn't seem to exist, at
>         least not in
>         the latest kernel.
> 
> Misremembered the name (and didn't look it up when typing the
> message).
> The script I used was cleanfile not checkfile
> 
> (and apologies for the mistakes, I'm still fairly new at the process
> of submitting patches; thanks for your patience). 
> 
You are doing pretty well ...

>         
>         .
>         >
>         > If something like
>         > rv = helperfunc(client, reg1, valptr1);
>         > if (!rv)
>         >    rv = helperfunc(client, reg2, valptr2);
>         > if (!rv)
>         >    rv = helperfunc(client, reg3, valptr3);
>         >
>         > is ok, I think I could come up with a small helper func and
>         avoid that
>         > things become too wieldy and unreadable.
>         > Is this acceptable wrt coding style.
>         > (and maybe it has to be if (rv < 0) or so but I hope you get
>         the idea)
>         >
>         
>         How about something like
>         
>                rv = helperfunc(client, reg, &val);
>                if (rv)
>                        goto abort;
>                ...
>                goto done;
>         
>         abort:
>                ret = ERR_PTR(rv);
>                data->valid = 0;
>         done:
>                mutex_unlock(&data->update_lock);
>                return ret;
>         
>         or
>         
>                rv = read(client, reg);
>                if (rv < 0)
>                        goto abort;
>                storage = rv;
>         
>         followed by the rest of the code above, to avoid the helper
>         function.
> 
> Yeah, this is probably the simplest. 
> It would requre some temporary vars as there is code form the form
> temp = (read(client, reg1) << 8) | read(client, reg2)
> but that is no problem.
> 
> Having been educated by Edsger "goto considered harmful" Dijkstra, I
> have some internal barriers against the use of goto, but  I think in
> this case I can warrant it for myself.
> 
See CodingStyle, Chapter 7. Or, in other words: When travelling to Rome,
behave like a Roman ;).

>         
>         [ ... ]
>         
>         >
>         >
>         >         On a side note, this means the chip will only get
>         >         (re-)initialized if polled again.
>         >         Is that ok for your application ? Not that any
>         alternatives
>         >         would be easy to implement - a cleaner
>         >         solution would be for your system to detect that the
>         device
>         >         was pulled, unload the driver if that
>         >         happens, and reload it once the device is
>         re-inserted. At
>         >         least this is how we handle it in our
>         >         systems.
>         >
>         > Hm, yes.
>         > For our app this is ok. I poll the device every second.
>         > And as it stands there is not really a mechanism to detect
>         that the
>         > device was pulled (apart from read operations to the device
>         failing)
>         > (at least not in our system).
>         >
>         > In our system the LM80 is with the fan unit and if the fan
>         unit is
>         > removed also the LM80 is disconnected. I2C is of course not
>         hot
>         > pluggable, and actually we state in the documentation that
>         fans are
>         > not hot swappable, but we want to be able to properly deal
>         with the
>         > situation of a user does (as irrespective of what the manual
>         says,
>         > someone is going to do this anyway).
>         >
>         > If you feel there is a better solution without changing the
>         hardware
>         > interface, I'd like to hear from you as I am always eager to
>         improve
>         > things.
>         >
>         
>         
>         Depends on how your polling works. You might do something like
>         
>            while (true) {
>                error = poll_lm80();
>                if (error) {
>                        scream and log event;
>                        unload lm80 driver;
>                        do {
>                                sleep(1);
>                                error = read_i2c_register(bus, addr,
>         reg);
>                                // use i2cget if this is a script
>                        }  while (error);
>                        load lm80 driver;
>                }
>                sleep(1);
>            }
>         
>         Of course that only works if you only have a single lm80 in
>         your system,
>         and if you build the lm80 driver as module.
> 
> I've been pondering about using a module (currnently we don't). Also
> there might (and probably will) be two lm80's in the system.
> 
> solution could be to unload and reload the driver when I detect the
> chip is back again. Then again I'm not 100% sure if read_i2c_register
> works for me, as I am on powerpc having this chip mapped in the device
> tree.
> Haven't tried it with an lm sensor, but noticed that mapped gpio chips
> are locked by the system and cannot be called using i2c-get
> 
i2cget from i2c-tools has a -f option to force reading registers even if
the device is already open.


> 
> As we poll the device anyway, I guess I'm best off leaving things as
> they are. (with reinitialisation if data->valid = 0), taking also
> into account that this is not supposed to happen anyway.
> 
Guess so, only use an error flag instead of data->valid to avoid
initializing the chip multiple times on startup, and remember to explain
the reason.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
