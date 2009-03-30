From: badarbo <badarbo@hotmail.it>
Date: Mon, 30 Mar 2009 09:15:53 +0000
Subject: Re: [lm-sensors] Module it87 not loading
Message-Id: <20090330111553.38dbd314@pantagruel.manuelito.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090330092313.5db8acd2@pantagruel.manuelito.org>
In-Reply-To: <20090330092313.5db8acd2@pantagruel.manuelito.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lun 30/03/09 10:02:56 +0200 Hans de Goede <j.w.r.degoede@hhs.nl> ha scritto:

> On 03/30/2009 09:23 AM, badarbo wrote:
> > Hi,
> > today the module it87, which always loaded and worked without
> > problems, stopped loading giving this message:
> >
> > FATAL: Error inserting it87
> > (/lib/modules/2.6.24-23-generic/kernel/drivers/hwmon/it87.ko): No
> > such device
> >
> > I didn't change anything in my software-hardware setup since
> > yesterday, when it still worked, so I don't have a clue. The only
> > "particular" thing is that today, when turning on the pc, ubuntu
> > (hardy) did a fsck (with no problems). I wonder if manually
> > creating the missing device would solve this, but I dont't know how
> > to do it. Thanks for any suggestions, bye
> 
> What does the output of "dmesg" say?

Nothing.

I don't know if this is important, but doing "sensors-detect" now doesn't even try "it87" (although I don't remember if it said so explicitely before), and suggests using "ipmisensors" (it never did this before --- anyway to have "ipmisensors" requires to patch and build the kernel, and since this system is tested and stable I think I'd rather do without mb temps and tensions, if I could not fix "it87" not loading).

"sensors-detect" output follows...

---------------

# sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies VT8233A/8235 South Bridge

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): yes
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus Via Pro adapter at 5000 (i2c-0)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x4c
Handled by driver `lm90' (already loaded), chip type `lm90'
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      Success!
    (confidence 4, driver `ipmisensors')
Probing for `IPMI BMC SMIC' at 0xca8...                     Success!
    (confidence 4, driver `ipmisensors')

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0xb9b9
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0xb9b9

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no): yes
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `lm90' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x4c
    Chip `lm90' (confidence: 6)

Driver `ipmisensors' (should be inserted):
  Detects correctly:
  * ISA bus, address 0xca0
    Chip `IPMI BMC KCS' (confidence: 4)
  * ISA bus, address 0xca8
    Chip `IPMI BMC SMIC' (confidence: 4)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 

To load everything that is needed, add this to /etc/modules:

#----cut here----
# I2C adapter drivers
i2c-viapro
# You must also install and load the IPMI modules
ipmi-si
# Chip drivers
lm90
# Warning: the required module ipmisensors is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
ipmisensors
#----cut here----

Do you want to add these lines automatically? (yes/NO)no

---------------

Regards

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
