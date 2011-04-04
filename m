From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 04 Apr 2011 16:27:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for MAX16065/MAX16066 System
Message-Id: <20110404162726.GA13536@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300851783-13583-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1300851783-13583-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 03, 2011 at 08:39:40AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 22 Mar 2011 20:43:03 -0700, Guenter Roeck wrote:
> > This patch adds hardware monitoring support for Maxim MAX16065/MAX16066
> > flash-configurable system managers with nonvolatile fault registers.
> >
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/max16065 |   69 ++++
> >  drivers/hwmon/Kconfig        |   10 +
> >  drivers/hwmon/Makefile       |    1 +
> >  drivers/hwmon/max16065.c     |  757 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 837 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/hwmon/max16065
> >  create mode 100644 drivers/hwmon/max16065.c
> 
> Can I get a register dump of one of the supported chips for my
> collection?
> 
Here you are, for MAX16065.

root@groeck-desktop:/sys/class/i2c-adapter/i2c-5# i2cdump -y 5 0x51
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 7d 40 65 40 50 00 3b c0 28 80 15 00 97 00 8e 80    }@e@P.;?(??.?.??
10: 6e 00 50 c0 36 00 1b c0 51 79 40 00 00 00 00 00    n.P?6.??Qy@.....
20: 00 0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .?..............
30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 09 1a ff 18 1a ff 18 1a ff    .......??.??.??.
50: 18 1a ff 18 1a ff 18 1a ff 18 1a ff 18 1a ff 18    ??.??.??.??.??.?
60: 1a ff 18 1a ff 18 1a ff 18 1a ff 18 00 00 00 00    ?.??.??.??.?....
70: 00 00 00 01 1e 00 00 cc cc cc cc cc cc cc 12 34    ...??..????????4
80: 56 78 9a bc 12 34 56 78 9a bc 00 00 02 01 00 00    Vx???4Vx??..??..
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX 00 10 00 00 00 00 00 00 XX XX XX    XXXXX.?......XXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

> Review:
> 
I'll skip most of your feedback. Respective changes will be in the next version
of the driver.

[ ... ]

> > +can be safely used to identify the chip. You will have to instantiate
> > +the devices explicitly. When instantiating the device, you have to specify
> > +its configuration register address.
> 
> "Configuration register address"?
> 
Leftover from another driver, sorry.

[ ... ]
> > +
> > +curr1_input          Current sense input; only if current sensing is enabled
> > +                     Displayed current assumes 0.001 Ohm current sense
> > +                     resistor.
> > +curr1_alarm          Overcurrent alarm
> 
> I'm a little worried about the "assumes 0.001 Ohm (...) resistor".
> Resistors which are external to the chip are normally handled by
> user-space. I understand this is a different case from scaling
> resistor pairs for voltage inputs, but it still feels wrong to assume an
> arbitrary resistor value in the driver. Where does the value come from,
> BTW? I couldn't find it in the datasheet.
> 
I have to say the datasheet isn't really easy to read ;).

Only reason for assuming 0.001 Ohm is that makes adjustments via sensors.conf
easier than, say, 0.005 Ohm or 0.002 Ohm.

The ADC_TO_CURR() calculation is derived from information found in the datasheet,
which I confirmed with the current sense voltage readings on my test board.

> But I also have to admit that we do not have the needed code in place
> yet to handle it differently. This is similar to the problems described
> in:
>   http://www.lm-sensors.org/ticket/2258
> 
> I have another possible implementation idea, I'll post about it
> separately for public discussion.
> 

Problem is that currents are always measured as voltages, and thus depend on
the series resistor value. I have been hitting the same problem with other
chips supporting current measurements. See the ltc4151 and ltc4261 drivers
for examples.

My solution so far is to assume a specific series resistor, and let userspace deal
with adjustments via sensors.conf.

Another option would might be to add platform data for each of the affected chips.
Would that make sense ? But even then I would need a default value in case there is
no platform data.

[ ... ]
> 
> I couldn't find in the datasheet any guarantee that the MSB and the LSB
> belong to the same measurement, but I admit I didn't read it too
> carefully. Is this the case?
> 
No, or at least I did not find it either. Turns out, however, that I can use
16 bit reads since the chip auto-increments the address. I'll do that instead.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
