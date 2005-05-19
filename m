From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: New chip driver development plan to Lm_sensors
Message-Id: <t1yspTR6.1101288551.7321530.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
In-Reply-To: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> I'm writing a new driver for w83792D, which is w83792d.c,using
> w83781d.c as my reference, deleting the codes related with ISA except
> two places, because 792D will only be on I2C.

Sounds good :)

> But I have two questions about w83792d driver now.
> (1) Can I delete the following codes?
> static unsigned int normal_isa[] = { 0x0290, SENSORS_ISA_END };
> static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
> I guess the above two sentences are useless, but I'm not very
> sure about it's function, can you tell me whether I can delete
> them or not?

No you can't. The i2c-core needs them. Simply remove the address and
leave:

static unsigned int normal_isa[] = { SENSORS_ISA_END };
static unsigned int normal_isa_range[] = { SENSORS_ISA_END };

This will let the core know that it should not attempt to use your driver
for the ISA bus. This is what's done in other i2c-only drivers (such as
lm90.c for example).

> (2) When you are free, can you give me some general explanation
> of the member "last_updated" of struct w83792d_data?
>
> What I need to do is just keep all the codes related with
> "w83792d_data->last_updated" in w83781d.c
> Is that right?

Yes, keep it. This is something common to (almost) all drivers.

The idea is to remember when the chip registers where last read, and
force a little delay (typically between 0.5 and 2 seconds depending on
the chip) before the driver is allowed to read them all again. This
leaves some time for the chip to sample the voltages, temperatures etc.
Not all chips do need it, but some chips stop sampling when there is
traffic on the I2C interface so we have to do that. Also, since regular
users can request data from the driver, it is a good safety that this
won't generate I2C traffic each time. If we were really reading the
registers each time, then any user could overflow the I2C bus and
possibly cause trouble to the system (such as alarm conditions not
triggering as needed).

So last_updated stores the last time the registers were updated. It is
set at the end of the update function. At the beginning of the update
function we compare with the current time and if less than the defined
delay (usually expressed as x * HZ where HZ means 1 second) has passed
since the last update, then we do not read the registers and use the
previously read values instead.

Jean
