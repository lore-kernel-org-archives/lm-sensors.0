From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Feb 2012 07:23:42 +0000
Subject: Re: [lm-sensors] dual output buck controller pmbus based
Message-Id: <20120210072342.GA31852@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
In-Reply-To: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2012 at 01:20:25AM -0500, Vivek Bardia wrote:
> Hello,
> 
> I want to know whether does the current pmbus driver support dual output buck
> controller based PMIC?
> 
> Basically for this particular PMIC: http://goo.gl/BFwcu
> 
This is the TI TPS40422. I have not had a chance to test it, so I have no idea
if it will work.

> How do I test the driver for it?
> 
If you know the bus and I2C address, instantiate it with 

echo pmbus <address> > /sys/class/i2c-adapter/i2c-<bus>/new_device

You have to execute the command as root.

Example: Instantiate pmbus device on bus 0, address 0x20:

echo pmbus 0x20 > /sys/class/i2c-adapter/i2c-0/new_device

then execute the "sensors" command and see if you get some output, and if it makes sense.

Looking into the datasheet, the interpretation of the PMBus "page" command is a bit odd.
You might get four sets of registers. If so, the first set would reflect the first channel,
the second set the second channel, the third set is invalid, and the fourth set would reflect 
both channels. But that is just a guess.

Would be great if you can post the results to the list. If it doesn't work, turns out the
evaluation module was just $49, so I ordered one. Which means you'll get support one way
or another.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
