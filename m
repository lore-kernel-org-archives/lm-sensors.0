From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <200406251423.i5PEN7L4024320@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[please remember to CC the mailing list on reply]

>Would a 2.4 patch be acceptable that merely returns a read or write error
>to the thing trying to read the sensor information.

The drivers architecture will hardly let you implement this. I dont think
you even have the possibility to return a non-zero error code in procfs
(callback functions return void IIRC). In 2.6 it's better since
callback functions can return an error value. However, in both cases
(2.4 and 2.6) the registers are read all at once in a different function
(mainly to ensure that the chip will get some rest from times to times)
so if an error occurs, it occurs in that common update function, *not*
in the reader callback function, so you cannot just return -1 and
consider that the read failed. The register which failed may not be the
one you are reading at that moment. You would have to keep track of
whether each register read succeeded or failed. Although not unfeasable,
this would be a very important change and I don't think it's
acceptable in 2.4/CVS. I'm not even sure I would like this in 2.6...

So all in all the only case (for now) where we could easily notify errors
to the caller is when writing to sysfs files. For now we only notify
input errors (requested value not acceptable for the given feature) but
write errors could be notified that way too.

> The reason I ask is
>because for the short term I still have to live with 2.4, and in two
>places I am going to see these sort of errors.  The first is conjecture,
>but one type of system gets spurious (like once a day) really off values
>from sensors (like even the thresholds it reads back change) and then
>it corrects itself after about 30 seconds.  This is likely after perusing
>the I2C stuff a bug in our hardware, which when this system I can't get
>changed.  My work around was to cache sensors output and if the thresholds
>changed from one reading to the next, I keep the old readings (an utterly
>abysmal hack I know).  In the other case we have an I2C mux that will
>allow occasional on demand access to the I2C mux by another device.  The
>hope was rather than getting sensors to support the PCA9541 (which really
>doesn't support arbitration anyway) we would simply allow for errors
>on the bus during those brief periods (once in 3 months) that someone
>might access the I2C bus from this other device.
>
>In both cases, I would rather simply get read/write errors when accessing
>the sensors proc stuff, and make the users space software respond to the
>error.

As said above, I doubt you'll be able to do that, at least easily. But
let me know if you see a way I missed. Like Greg, I can be convinced
with patches ;)

>When we move to 2.6 I would be more than willing at looking at the retry
>approach.  For now though in 2.4 I would be happy if I could just have the
>error propagated down.  Also, at some point one has to give up retrying
>and pass an error back, so it would not be totally wasted work.
>
>Does this seem like an acceptable approach to a patch to the LM87 chip
>driver?

Actually I would consider the retry method in 2.4 as well (because I
don't see any other easy way). As you noticed, there's a moment
you'll have to give up, and the only way I can think of is returning
the old value (if it exists, and probably 0 if it doesn't). That's
what the w83l785ts driver does IIRC. And fill the logs with endless
screams, of course.

Thanks,
Jean Delvare
