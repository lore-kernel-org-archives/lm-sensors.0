From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: NCLV-D SMBus - proposal to a solution
Message-Id: <4262C492.10808@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here I would like to propose some solution and "to be done" list to asus board
types.

1) Patch to kernel that adds io region allocation for ICH4 in /proc/ioports

2) Some kind of multiplexing bus driver that will allow us to "see" both of
memory EEPROMs and monitoring chip.

3) Some other ASUS server boards considerations.

Ad 1)
Remember we could not see the region in /proc/ioports for GPIO ports? I will
create the patch that will fix this. (It is just one line to quirks.c)

Ad 2)
Thank you for information there are very helpful. We agreed with Jean that most
clean solution to a problem would be a "multiplexing bus driver" (users can use
until this is done the isaset trick). As you might noticed the multiplexer just
switches the intel SMBus host between four busses. We are interrested in bus 0
and bus 1. One is with SPD EEPROMs and second contain 792 chip. We have already
similar driver in kernel for this that is called i2c-amd756-s4882.c.

Your driver will be very similar except that the multiplexer itself is not
on the smbus but you need to do same trick as with isaset command. Generally
you would need to register the PCI device to your multiplexing driver, get the
GPIO base addr (same as my hide and seek patch) and switch it to 0x0 or 0x08
when you have request from bus 0 or bus 1...

How is the multiplexed bus concept working:

It creates more busses from i2c core point of view. When there is some request
to read or write from a driver it will go to this virtual bus driver,
this driver will switch the bus and call the original driver. So it just create
handlers for "xfer" function that is the transmission function.

When it is done you will have more virtual busses.

modprobe i2c-i801
modprobe your multiplex driver

so if you will do
i2cdetect 0
It will switch the multiplexer and you will see only SPD eeproms here
if you will do:
i2cdetect 1
You will see addresses with 792 chip.

Later you just modprobe eeprom and modprobe w83792 and all will work as expected
. You will see in sensors command both eeproms and chip data.

The existing driver has 200 lines and I guess yours would have like 300 so it is
not so difficult to write it. Unfortunalely I'm quite busy these days and Jean
has a lot of work too so I cant write it for you but of course I will help you.

Ad 3)
Maybe it will be wise to check if other asus motherboards are done same way
so we can extend this concept to more motherboards with winbond chips. We have
already a user with 792 chip on ASUS mb but also hidden. His board is
ASUS NCL-DS. Please can you ask Asus, about this motherboard? (similar way we
did this time, also great would be the SMBUS schematics)

Maybe you should extend the question like: What ASUS motherboards that use our
chips needs multiplexer switching? How this switch needs to be done?

Because I think they will use similar approach so than it would be very easy
to add the functionality or create diffrent driver very quickly.

I also would like to hear comments from others if any.

Regards

Rudolf
