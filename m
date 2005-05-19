From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: parport driver
Message-Id: <4262C6F7.9070307@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi again!
> So I tried to load the following modules: i2c_core, i2c_algo_bit,
> i2c_pport, i2c_dev, i2c_sensor, pcf8574.
> Should I be able to se my pcf8574 chip that is hooked up on my parallel
> port now? Cause I can not! Do I have to consider cables (length and
> others) or have I done anything else wrong? Some hints on trouble shooting
> would be apreciated.

Hello

I used cables like 2 meters but I think they can have much more.

As for trouble shooting. You can try if the driver can force the lines to 0 and
1 so you know it is not "stuck". This can be done via kernel module parameter
for i2c-algobit.

Just do:

modinfo i2c-algobit (or i2c-algo-bit)

There is the parameter called bit_test
 Unload all modules modrobe i2c-algo-bit bit_test=1

modprobe i2c-pport
watch the system log.

If it says line is stuck, something with the parport is wrong.Double check that
you have iobase 0x378 in bios and it is set to "standart" or SPP mode only.
Also be sure no other drivers for parallel port got loaded

Later you need to modprobe the pcf8574 this chip cant be detected so it must be
forced. You can do:

modprobe pcf7485 force=b,0x20,b,0x21

replace b with your bus number
it will be zero if no other i2c-bus modules are loaded
the 0x20 is first chip address 0x21 is second chip address. if you have only one
 just delete the second part.

Then you can watch /sys/bus/i2c/devices/0-0020/read
If you put zero to some PIN the value will change

so likecommand:

 watch cat /sys/bus/i2c/devices/0-0020/read

and with wire connecting some pins of chip to GND...

Regards
Rudolf
