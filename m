From: rigid@akatash.de (Daniel Hiepler)
Date: Thu, 18 Aug 2005 17:08:18 +0000
Subject: [lm-sensors] Ticket #: 179 Winbond 83781 is not detected on
Message-Id: <20050818170737.0015895b@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Dear lm_sensors-ppl,

I have the above motherboard running gentoo/vanilla
2.6.12.1/sensors/libsensors 2.9.1

In 1999 there already was a ticket
(http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket9) about this.
Is there a solution/patch yet? The ticket is marked as solved, but it
isn't... there is a winbond on this motherboard. Have you received the
output of sensors-detect?
Please notice me if i can send you any debug-output so i can patch
lm_sensors to support that mb...

- ------------ sensors-detect ---------------------------
sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c/*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to
all questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang
halfway through; we can't really help that. Also, some chips will be
double detected; we choose the one with the highest confidence value in
that case. If you found that the adapter hung after probing a certain
address, you can specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 5000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 5000'
    Busdriver `i2c-piix4', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module for it. If you have the choice, do you want to use the ISA bus or
the I2C/SMBus (ISA/smbus)?

If you want to load the modules at startup, generate a config file
below and make sure lm_sensors gets started; e.g
$ rc-update add lm_sensors default.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is working
properly. Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...

#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/bin/sensors -s # recommended

Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?  (yes/NO/s):

- ----------------------------------------------------------
if you need any more, pls notice me. it's no problem
to do kernel-level debugging as long as there will be support for this
(old) motherboard soon...


thanks very much...

regards
_________________________________________________
rigid

Art is a jealous mistress.
		-- Ralph Waldo Emerson


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBKQ5ppxC7julSnURAqMqAKCXAbCjGUFXcFY5J9kAUHJlTjTTKACdFmaZ
zUi4YAIrJGk/fLajMEr0yP4=enez
-----END PGP SIGNATURE-----
