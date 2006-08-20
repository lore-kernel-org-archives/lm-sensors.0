From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 20 Aug 2006 11:07:57 +0000
Subject: [lm-sensors] IBM eServer xSeries 335 and sensors-detect problem
Message-Id: <44E8428D.6020008@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello David,

> I'm having problems using sensors-detect: it cannot load i2c_piix4, and
> does not detect any chips (see below).  The module i2c_piix4 is indeed not
> available (the available ones are i2c-dev.ko, i2c-core.ko, i2c-parport.ko,
> i2c-algo-pcf.ko and i2c-algo-bit.ko).

It refuses to load because IBM thinkpads has a eeprom that is known to have
hardware flaw that will corrupt it content and render notebook unusable.

There is a check for IBM, and this is the reason why it refuses to load.
I think some people already removed that for a server and this eeprom was not
there. But you better check if there is no 24RF08 eeprom anywhere.

To remove the protection and load the driver you need to change the source code
of i2c-piix4 driver. Which you will find in linux/drivers/i2c/busses directory

find this code:
        /* Don't access SMBus on IBM systems which get corrupted eeproms */
        if (dmi_check_system(piix4_dmi_table) &&
                        PIIX4_dev->vendor = PCI_VENDOR_ID_INTEL) {
                dev_err(&PIIX4_dev->dev, "IBM system detected; this module "
                        "may corrupt your serial eeprom! Refusing to load "
                        "module!\n");
                return -EPERM;
        }

remove the line
return -EPERM;

And recompile, now it will allow to load the driver. Please be sure to use
latest version of lm-sensors  2.10.0.

Then you may run sensors-detect again. I'm only afraid that it wont find any
sensors. Maybe you should try the IMPI and impitools instead of lm-sensors? (the
sensors-detect should tell - but I cannot see the IMPI)

To sum it. If the eeprom 24RF08 is not there is safe to do what I recommend. If
it is there, then with latest version of lm-sensors nothing bad should happen.
Some people did it for IBM servers and it was ok. So I would say risk should be
minimal. Of course it is on your own risk ;)

Regards
Rudolf

