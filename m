From: Alex Riesen <raa.lkml@gmail.com>
Date: Mon, 17 Aug 2009 08:51:01 +0000
Subject: Re: [lm-sensors] Intel Moorestown Analog Accelerometer driver
Message-Id: <81b0412b0908170151i491553ddja13f48520e3c8d21@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c632a690908130147j55df80fbmc96b5bec6f9927b4@mail.gmail.com>
In-Reply-To: <c632a690908130147j55df80fbmc96b5bec6f9927b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 17, 2009 at 10:07, Agarwal, Ramesh<ramesh.agarwal@intel.com> wrote:
>> Ramesh Agarwal says:
>> > +/* PMIC ADC INTERRUPT REGISTERS */
>> > +#define PMIC_ADC_ACC_REG_ADCINT            0x5F    /*ADC interrupt register
>> */
>>
>> Does the accelerometer itself actually provide an interrupt for the
>> data? Can the interrupt be used?
>>
>> The "ADC interrupt register" seem to hint at that.
>>
>> Forcing people to poll for interactive data (and that seems to be a
>> very common use for accelerometers these days) is not very nice.
> [Agarwal, Ramesh] The accelerometer unfortunately does not have
> any interrupt. It just gives the voltage for the current value of the g
> on the three co-ordinates. The Interrupt being referred to is for
> the ADC. Once the ADC is started it will sample all the channels
> (including others which are used by other analog devices) in a
> round robin fashion. The interrupt is raised when one round of
> sampling completes.

So, the kernel could activate the line, but the interrupt will cause
the ISR be called every sampling cycle irrespective of whether
the measured g-values have changed?
Still, it could be interesting to see how the register is programmed:
maybe someone would like to know the values as soon as possible.
Maybe someone even implements buffering/filtering of them in the driver,
so that the sysfs file can send inotify notifications (or even be polled
with poll(2)).

>> > +static unsigned int analog_accel_read(int offset)
...
>> > +   if (mrst_pmic_ioread(&ipc_data) != 0) {
>> > +           printk(KERN_ERR
>> > +           "mrst_analog_accel:PMIC reg read using IPC failed\n");
>> > +           return -1;
>>
>> You return -1 in a function returning unsigned?
>> And you don't handle the -1 anyway, so maybe a more useful value can
>> be returned (like one you'd return when there is no acceleration).
>> Or you can handle the error more sensibly, and return error (if it's
>> possible) from sysfs' _show().
>>
> [Agarwal, Ramesh] Sending 0xffffffff was kind of my way of indicating an
> error because the values coming out of the ADC are just 10 bits, so

If they are just 10bits, they certainly fit into any int, so you can
use negative
values normally.

> anything larger than that would indicate that there was an error
> reading the values.

It does not match the sprintf pattern you use.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
