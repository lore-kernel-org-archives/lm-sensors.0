From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 20 Jul 2007 14:57:59 +0000
Subject: Re: [lm-sensors] sensors trouble
Message-Id: <46A0CD77.30607@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <3azje6yl.fsf@yahoo.com.au>
In-Reply-To: <3azje6yl.fsf@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jonathan Murphy wrote:
> Hi Folks,
> 
> I can't get sensors working. Kernel is 2.6.22.1, lm_sensors-2.10.4. 
> 
> Relevant lspci:
> 
> 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
> 
> Relevant config:
> 
> CONFIG_I2C=y
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI15X3=m
> CONFIG_SENSORS_EEPROM=m
> 
> Output of sensors-detect:
> 
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): y
> Probing for PCI bus adapters...
> Use driver `i2c-ali15x3' for device 0000:00:11.0: Acer Labs 1533/1543
> Use driver `i2c-ali1535' for device 0000:00:11.0: Acer Labs 1535
> 
> We will now try to load each adapter module in turn.
> Load `i2c-ali15x3' (say NO if built into your kernel)? (YES/no): y
> Module loaded successfully.
> Load `i2c-ali1535' (say NO if built into your kernel)? (YES/no): n
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no): y
> Module loaded successfully.
> 
> [....]
> 
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See doc/FAQ,
> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> (FAQ #4.24.3) for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
> 
> 
> However, if I run sensors-detect choosing i2c-ali1535 instead, then I
> get:
> 
> Next adapter: SMBus ALI1535 adapter at 8040 (i2c-0)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Success!
>     (confidence 8, driver `eeprom')
> Probing for `EDID EEPROM'...                                No
> Probing for `Maxim MAX6900'...                              No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Success!
>     (confidence 8, driver `eeprom')
> 
> 

With the first run, where you choose i2c-ali15x3, clearly no i2c bus was found, 
so i2c-ali15x3 is the wrong smbus driver for your motherboard. With the second 
run with the i2c-ali1535 driver, clearly an smbus was found, but without any 
sensors connected.

Did you also say Y to the superio chip probes? Does your motherboard have 
sensor readings in the BIOS and or under windows? What would also help is if 
you could tell use the manufacturer and model of your motherboard.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
