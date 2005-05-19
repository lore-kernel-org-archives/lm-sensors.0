From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <1081851462.407bbe4658a0f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I don't insist on particular name, this was just for clarification.
> Will rename it into max6635.c

Fine, thanks :)

> > I don't say that you should skip the test. Just don't make it an
> > error, i.e. exit in silence.
> > (...)
> 
> Ok, I have removed this error path, only warning.

No! Read what I just said. Do not ignore the fact that functionalities
are missing, since it'll break later then. But do not return an error
code and message either, because it isn't necessarily an error (due to
the fact that each chip driver is possibly called for each bus on the
system, and a given bus does not have to support functionalities that
are used by chips on the other busses). So the correct code would be:

if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
I2C_FUNC_SMBUS_WORD_DATA))
{
    printk(KERN_DEBUG "max6635.o: Adapter doesn't support needed
functionalities.\n");
    return 0;
}

BTW it's a common habit to prefix error/debug messages with the module
name, as I did above. I just noticed that you didn't follow it in your
driver.

> > Will you be able to run sensors-detect to test my detection
> > function on your samples?
> 
> Nope. It doesn't have any kind of scripting languages.

OK, I guess I won't add support to sensors-detect at all then.

BTW, what is your system after all? I'm quite surprised to see a
MAX6635
in a modern system, it looks like a rather "old" chip (designed 3 years
ago). The level of support we want to add to our userspace tools
(sensors-detect, libsensors, sensors) mainly depends on how likely it
is that other users will have such a device on a system them just
bought. So far the LM76 was listed as "unlikely to be found in a PC".

> 00: 0004 0005 0002 0003 <- registers
> 
> 00: 000f 0014 000a 0005
> 08: 0000 0000 0000 0000
> 10: 000f 0014 000a 0005
> 18: 0000 0000 0000 0000
> 20: 000f 0014 000a 0005
> 28: 0000 0000 0000 0000
> 30: 000f 0014 000a 0005
> 38: 0000 0000 0000 0000
> 40: 000f 0014 000a 0005
> 48: 0000 0000 0000 0000
> 50: 000f 0014 000a 0005
> 58: 0000 0000 0000 0000
> 60: 000f 0014 000a 0005
> 68: 0000 0000 0000 0000
> 70: 000f 0014 000a 0005
> 78: 0000 0000 0000 0000
> 80: 0000 0000 0000 0000
> 88: 0000 0000 0000 0000
> 90: 0000 0000 0000 0000
> 98: 0000 0000 0000 0000
> a0: 0000 0000 0000 0000
> a8: 0000 0000 0000 0000
> b0: 0000 0000 0000 0000
> b8: 0000 0000 0000 0000
> c0: 0000 0000 0000 0000
> c8: 0000 0000 0000 0000
> d0: 0000 0000 0000 0000
> d8: 0000 0000 0000 0000
> e0: 0000 0000 0000 0000
> e8: 0000 0000 0000 0000
> f0: 0000 0000 0000 0000
> f8: 0000 0000 0000 0000

Which would tend to prove that the pointer register has actually 4 used
bits. Or even 5 if we consider the second half of the dump. That's a
bit surprising, I admit. Still this is enough to improve the chip's
detection function.

> Chip uses two's-complement format with 1LSB corresponding to
> 0.0625 and 1MSB as sign.
> So with this conversation we lose ~0.5 degree.

OK, granted it's acceptable.

> I just don't know how this accuracy should be presented in current
> i2c /proc processing.

You are free to use whatever magnitude you want for exporting values
through procfs. The magnitude is what the callback function answers
when called with operation = SENSORS_PROC_REAL_INFO. If you want
improved accuracy, you can use magnitude of 2, and then export, for
example, value 2481 (instead of 248 now) for a measured temperature of
24.8125.

I agree it doesn't matter much what you decide, reporting temperature
with two decimal places isn't that interesting anyway.

> > You don't need swap_bytes here, if would be faster without it,
> > don't you think?
> 
> It is called only once in load time, and main idea was to store this
> values as cache if they are valid. I think it should be implemented
> in this way, or not?

We usually do not, although I admit we could. Still, it only makes sense
if you read *all* the values so that caching is possible. About this, I
noticed that you don't properly protect your update function. See in
other chip drivers how this is done. You are supposed to cache the read
data for a given amount of time, and there's also a flag that says
whether the values are OK or not (basically clear at driver load time,
and set as soon as the update was called once).

If you want to fill the cache as soon as you start the driver, then you
should simply call the update function and use the "returned" values
for detection. Else you're basically coding the same function twice.

Oh BTW, you don't seem to use  the 4-bit address cycle trick I mentioned
before in your detection function yet. Please do.

And two more comments:

You can use the kernel function swab16() instead of your own swap_bytes
function. I'm going to fix the othe drivers in the same way.

> -MODULE_DESCRIPTION("MAX663x temerature sensor");
> +MODULE_DESCRIPTION("MAX663{5,4,3} temerature sensor");

This is actually the only place where 'x' is accepted, I forgot to tell
you ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
