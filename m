From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: Hardware sensors problem with 2.4.21 on IBM eServer 335/345
Message-Id: <lVMpTIws.1105694998.9605830.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <9BC242DA-65D6-11D9-9300-003065F94C4C@cs.umass.edu>
In-Reply-To: <9BC242DA-65D6-11D9-9300-003065F94C4C@cs.umass.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Armen,

> I am trying to get hardware sensors (i.e. cpu temp, fan speed, and
> voltage sensors) working on an IBM eServer 335 system that is running
> RedHat (Enterprise edition) with kernel 2.4.21 (2.4.21-27 actually - it
> has lm sensors 2.6.5).
>
> The driver for the sensors chip on this particular mainboard is found
> using sensors-detect:
>
> Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
>
> However, the driver failed to load with the following error:
>
> i2c-core.o: i2c core module
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-piix4.o version 2.6.5 (20020915)
> i2c-piix4.o: Found CSB5 device
> dmi_scan.o version 2.6.5 (20020915)
> dmi_scan.o: SM BIOS found
> i2c-piix4.o: IBM Laptop detected; this module may corrupt
>              your serial eeprom! Refusing to load module!
> i2c-piix4.o: Module insertion failed.
>
> Obviously this machine is not an IBM Laptop!  It is, in fact, a
> rackmount server.

True. Our detection process is a bit loose, mostly due to the fact that
we did not want to take any risk. We also had a report of one non-laptop
made by IBM which supposedly had faulty EEPROMs too. It was long ago and
I don't know how reliable the report was, but it still invited us to an
extreme prudence.

> My question is: is this machine still at risk of
> this EEPROM corruption bug that is present in (what looks like
> exclusively) certain models of IBM Thinkpads?  I can easily comment out
> this logic and recompile, but I really don't want to break my EEPROM!
> Can anyone tell me with reasonable certainty that I won't break my
> machine by forcibly installing this module?

I think that these xSeries servers are known to be safe (see below).

> It looks like the new lm
> sensors logic (like before) just doesn't like this machine because the
> DMI vendor is IBM and the PCI Vendor ID is Intel:
>
> if(dmi_ident[DMI_SYS_VENDOR] != NULL
>         && strncmp(dmi_ident[DMI_SYS_VENDOR], "IBM", 3) = 0)
>                 is_unsafe_smbus = 1;
>
> together with:
>
> if(ibm_dmi_probe() && PIIX4_dev->vendor = PCI_VENDOR_ID_INTEL)

This is the new code. The old code did not do the Intel check and would
blacklist all vendors. As a matter of facts, yours is Serverworks, not
Intel, but is blacklisted in your version (2.6.5).

> Any and all insight is greatly appreciated!

The Intel check was added recently (lm_sensors 2.8.7) by Vojtech Pavlik.
Quote from the log:

"I'm sending you this little obvious patch which should enable i2c-piix
to work on IBM servers with ServerWorks chipsets. It still will treat
any IBM/Intel machine as a laptop and refuse to work, but it's better
than before."

This certainly proves that you are safe adding the Intel check on your
xSeries server so that the driver will load. Most probably Vojtech
Pavlik had the same problem and this is the reason why he added the
Intel check.

--
Jean Delvare
