From: "Bart van Kuik" <lmsensors@vankuik.nl>
Date: Fri, 06 Jul 2007 16:12:29 +0000
Subject: Re: [lm-sensors] Sensors working on DL360?
Message-Id: <38183.83.87.167.242.1183738349.squirrel@webmail4.transip.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <57849.83.87.167.242.1183707511.squirrel@webmail4.transip.nl>
In-Reply-To: <57849.83.87.167.242.1183707511.squirrel@webmail4.transip.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please post the output of lspci. Also, use the SVN version of
> sensors-detect and post that output too. Your server most likely
> requires the ipmisensors driver which the SVN version of
> sensors-detect should correctly identify.

Full output of SVN version of sensors-detect:

# sensors-detect revision 4561 (2007-07-06 11:52:32 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks OSB4 South Bridge

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

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
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0xffbf
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Sorry, no sensors were detected.
Either your sensors are not supported, or they are connected to an
I2C or SMBus adapter that is not supported. See doc/FAQ,
doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
(FAQ #4.24.3) for further information.
If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.



Full output of lspci:

00:00.0 Host bridge: Broadcom CNB20LE Host Bridge (rev 05)
00:00.1 Host bridge: Broadcom CNB20LE Host Bridge (rev 05)
00:01.0 RAID bus controller: LSI Logic / Symbios Logic 53C1510 (rev 02)
00:03.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC
[Mach64 GT IIC] (rev 7a)
00:04.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: Broadcom OSB4 IDE Controller
03:04.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
03:05.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
