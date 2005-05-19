From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: ATXP1 kernel patch
Message-Id: <20050104101653.651140b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > 3* What is this "low_voltage" module parameter?
> It allows setting of 1075mV which is not available on all platforms. 
> Think this is removeable when using i2c-sensor-vid?

1075mV isn't valid under VRM 9.x according to the specs, so I really
wonder how it can work on some plateforms. I would happily see it
removed to keep the code more simple. And i2c-sensor-vid will not
support it anyway.

As a side note, i2c-sensor-vid.c and i2c-vid.h were written with VID pin
*read* in mind, not write, so you might have to improve them a bit for
your own needs.

>  > 8* In the current implementation, atxp1_data.valid is usless (value
>  > is always 0). I also think that you should use restore and use
>  > atxp1_data.last_updated.
> Already fixed that, now using in atxp1_update_device:
> 
> # Update register data if needed
> for(count = 0; count <= 0x0a; count++) {
>      if((data->valid >> count & 1) = 0) {
>          data->reg[count] = i2c_smbus_read_byte_data(client, count);
>          data->valid |= 1 << count;
>      }
> }

Huh. Looks even more complex. Do you really need to read all 10 first
registers, while you were previously only reading 2? What is the benefit
of having a separate "valid" bit for each register since you always read
them all at once anyway?

>  > 9* What's the difference between VID and CPU VID?
> VID is the VID output control, enables or disables VID output control.
> CPU VID are the original VID pins from the CPU.

That would need to be documented in the code. Actually, the whole way
the chip works should be, since there is no public datasheet people can
look at.

>  > 10* You hardcode the VID <-> Vcore translation formula. Depending
>  > on the VRM version, it might or might not be correct. You should
>  > use the functions in i2c-sensor-vid.
> Ok.

Note that you won't be able to support VRM 10 since it uses 6-bit VID,
but all previous versions should work fine.

>  > 12* Why does vcore default to 1.650V in atxp1_storevcore? Why is
>  > vcore arbitrarily kept between 1.075V/1.100V and 1.850V? If trying
>  > to write a value outside of this range is an error, then
>  > atxp1_storevcore should return an error (negative value) when it
>  > happens.
> 1.075V-1.85V is the VRM range that is available on my 8RDA+ board. 
> Greater range isn't possible.

In other words, it uses VRM 9.x. You will need to add validity checkings
based on VRM version instead, providing you actually want to support
other VRM versions.

>  > 14* Care to comment/document the final loops in atxp1_storevcore?
>  > Since atxp1_write is complex, I fear that these loops will be damn
>  > slow. Why are they needed at all?
> Trying to set CPU voltage in greater steps will freeze the CPU 
> immediately (>+/-125mV, less under high CPU load). By in-/decrease
> the voltage in 25mV step the stability is increased. On my PC a
> script controls the CPU frequency and voltage and I do not recongize
> if it switches multiple times between 1125mV and 1650mV in a minute
> for testing. Ok that's subjective but could you define "slow" a
> little bit more please?

OK, that makes sense. Please add a comment explaining this in the code.
By slow I mean that SMBus transfer are slows (the bus is typically
operating at 15kHz), and since atxp1_write does 2 transfers and can be
called a dozen times to change the vid output once, it looked like it
would be slower that needed. However, if there is a good reason to do it
in an incremental way, fine with me. The operation isn't time critical
and we want it to be safe, agreed. But at least this is a good reason to
get rid of the readback test in atxp1_write.

Please note that the trick of increasing the vid value by one to
linearly decrease vcore works with VRM 9.x but wouldn't work with all
VRM 8.x, which are more complex. This might be a sufficient reason not
to support VRM 8.x (since we don't know of any system using both VRM 8.x
and an ATXP1). The fact that you will use i2c-sensor-vid doesn't mean
that you have to support all VRM versions, just that you will avoid code
duplication. You can check the VRM version and abort if it is anything
you don't support (i.e. non-9.x for now).

>  > 16* Sysfs file name should probably be cpu0_vid, not cpu_vid,
>  > although I admit I don't know how to properly handle the case where
>  > more than one device is present.
> Not thought on this, but is there a MP system which uses two of theses
> chips to let the user independently control the CPU core voltages? But
> it should be modified.

I don't know if this exist, but it certainly could. If both CPUs are
handled by an ATXP1 (and thus the same driver), we could have a common
static counter so that the first client creates cpu0_vid and the second
would create cpu1_vid.

> 
>  > 17* Don't set new_client->id to 0 in atxp1_detect, it's useless.
> Ok.
> 
>  > 18* You detection method is too weak and will most likely result in
>  > frequent misdetections. You have to improve it. I know that the
>  > device doesn't have a decidated identification register, nor does
>  > it have many registers to test, but we can certainly do something.
>  > Which registers does the device have exactly? What happens when
>  > reading from non-existent registers? The output of "i2cdump" may
>  > help.
> Yes, that's right. I've attached the dump. Maybe using 0x0b-0x0f
> (shows  all zero), 0x10-0x1a showing same value as 0x00 and >0x20 all
> zero.

Checking that random registers are 0 won't be very efficient because
that's the default value for most chips. However, some specific
registers would be worth checking: 0x3e, 0x3f, 0xfe, 0xff. These are the
locations of device id and manufacturer id registers for most chips, so
checking that they have value 0 is certainly great. It will avoid
attaching to the various temperature sensors that can live at 0x4e.

The fact that registers 0x10-0x1a return the same value as 0x00 will
also be a very efficient check. You don't have to check them all, a few
of them will do (remember that each additional read will slow down the
detection and increase the module load time as a result).

Your original check (CVID > 0) should probably be removed, as it doesn't
seem to be valid (0 is a valid VID value, 1.850V under VRM 9.x).

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
