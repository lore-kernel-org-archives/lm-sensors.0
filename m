From: "fabio.antonini@kaskonetworks.it" <fabio.antonini@kaskonetworks.it>
Date: Mon, 29 Mar 2010 14:50:32 +0000
Subject: [lm-sensors] Support for W83627DHG
Message-Id: <4BB0BE38.2090502@kaskonetworks.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear all
I'm working on a board based on a ATOM Z530. The CPU module is called 
MSC_Q7 US15W and the mother board is named Q7-MB-RP.
At the moment I have succesfully booted a Ubuntu 9.10 distribution. All 
drivers seem to be
working except the SuperIO W83627. The chip is rightly detected but it's 
not loaded because the
driver (w83627ehf) claims that (from dmesg)

"Refusing to enable a Super-I/O device with a base I/O port 0"

The section of the driver involved on this step is

     /* We have a known chip, find the HWM I/O address */
     superio_select(sioaddr, W83627EHF_LD_HWM);
     val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
         | superio_inb(sioaddr, SIO_REG_ADDR + 1);
     *addr = val & IOREGION_ALIGNMENT;
     if (*addr = 0) {
         printk(KERN_ERR DRVNAME ": Refusing to enable a Super-I/O "
                "device with a base I/O port 0.\n");
         superio_exit(sioaddr);
         return -ENODEV;
     }

My feeling is that the SIO_REG_ADDR contains a 0x0 instead of a real
address. Who should set this address? Do I need another kernel module
that sets this address?


The output of sensors-detect is

root@ws-mythtv-9:~# sensors-detect
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no supported PCI bus adapters found.

If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627DHG Super IO Sensors'
     (but no address specified)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Sorry, no sensors were detected.
Either your sensors are not supported, or they are connected to an
I2C or SMBus adapter that is not supported. See
http://www.lm-sensors.org/wiki/FAQ/Chapter3 for further information.
If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.
root@ws-mythtv-9:~#


As you can see the chip has been detected but no address has been 
specified:

Found `Winbond W83627DHG Super IO Sensors'
     (but no address specified)

Where can I set this address? What's missing? Has this driver been 
tested before on this board on Ubuntu 9.10? Do I need to enable anything 
in the BIOS? Do I need load the driver passing any parameter?

Any help will appreciated.
best regards

fabio antonini

-- 
Fabio Antonini PhD
SW Designer
Kasko Networks srl
Loc.Boschetto, zona ind.le di Pile
67100 L'Aquila


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
