From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: AS99127F PWM: how to explore
Message-Id: <427C8604.1040303@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0505070203410.3377@nev.ubzr>
In-Reply-To: <Pine.LNX.4.62.0505070203410.3377@nev.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
> I have recently tried to communicate with ASUS people about this chip
> and the answer was "information is confidential".

Blame them. Ask them that you wont buy it if they wont provide open specs.
Tell it to other people ;)


 I have a couple of
> ASUS motherboards here, so I want to figure out how it works myself. Now
> the question is if there is some simple way to control these registers?
> I am using 2.4.30 kernel with the lm_sensors-2.9.1. Everything works
> fine but PWM and some BEEP flags. Is there a simple script to be run
> from userspace or I should patch the driver to have raw registers
> control? I'm going to connect oscilloscope to fan power pins to see the
> effect. Any advice is appreciated. Yes, I have read doc/chips/w83781d :-)

You can study source code of the chip driver and also you will need
i2cdump
i2cdetect
and i2cset utillity. They have a manpage and you can use them even when driver
is loaded.

Some ideas what you can do:

if you have windows there and asus utility works you can tap i2cBUS and listen
for transactions. (I2c protocol is simple)

Here is the eavesdroping utillity.

http://warmcat.com/milksop/cheapi2c.html
(you just need other computer for this)

For example run asus hw monitor and try to change speed while listening on bus
you will see what happen on the bus. (Also you will need to listen to
comunication while the asus driver loads)

You can also connect internal i2c bus (you can tap it on SDRAM module see
homepage - this is valid if you can see something on 0x50-0x58 addresses try
with i2c-detect 0) via i2c-pport adapter  (other one from above I think) to
other computer and use i2cdump there.

For i2c-pport see doc directory of lm_sensors or i2c package.

Also note that there are two revisions of same chip name. They are different
despite the name on chip is same.

Feel free to ask if any questions. Keep us informed.

Thanks

Good luck.

Regards

Rudolf
