From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 14 Jun 2007 18:08:33 +0000
Subject: Re: [lm-sensors] Possible support for the SMSC SCH5317? (found on
Message-Id: <191fb4ca0706141108j63b64bb7y9bd80b0301347a7d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46711ACE.3070809@onelan.co.uk>
In-Reply-To: <46711ACE.3070809@onelan.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simon,

If you feel adventurous, you can add device ID 0x85 to the smsc47b397
driver which also supports the sch5037 chip. You'd have to modify it
as follows:

static int __init smsc47b397_find(unsigned short *addr)
{
        u8 id, rev;

        superio_enter();
        id = superio_inb(SUPERIO_REG_DEVID);

-        if ((id != 0x6f) && (id != 0x81)) {
+        if ((id != 0x6f) && (id != 0x81) && (id != 0x85)) {
                superio_exit();
                return -ENODEV;
        }

In the meantime, I'll try to get some data on the sch5137.

...juerg


On 6/14/07, Simon Farnsworth <simon.farnsworth@onelan.co.uk> wrote:
> Juerg Haefliger wrote:
> > Simon,
> >
> > Could you run sensors-detect and post the output?
> >
> Here you go:
> # sensors-detect
> # sensors-detect revision 4348 (2007-03-18 02:45:21 -0700)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Sorry, no known PCI bus adapters found.
>
> We will now try to load each adapter module in turn.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no): YES
> Module loaded successfully.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: saa7133[0] (i2c-0)
> Do you want to scan it? (YES/no/selectively): YES
> Client found at address 0x4b
> Handled by driver `tuner' (already loaded), chip type `tda8290+75a'
>     (note: this is probably NOT a sensor chip!)
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                No
> Probing for `Maxim MAX6900'...                              No
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): YES
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): YES
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8502
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x8502
> Trying family `VIA/Winbond/Fintek'...                       No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x0b00
> Trying family `VIA/Winbond/Fintek'...                       No
>
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no): YES
> AMD K8 thermal sensors...                                   No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See doc/FAQ,
> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> (FAQ #4.24.3) for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>
> Note that I suspect I've got an SMSC 5137 Super-I/O chip, but I can't
> find information on it.
> --
> Hope this helps,
>
> Simon Farnsworth
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
