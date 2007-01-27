From: mailinglist@welzien.se (Peter Welzien)
Date: Sat, 27 Jan 2007 19:49:13 +0000
Subject: [lm-sensors] sensors-detect hangs while scaning PIIX4
Message-Id: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everyone. I'm having troubles getting lm_sensors to work. My dist is
Gentoo 2006.1, gentoo-kernel 2.6.18-r6, the motherboard is a Gigabyte
GA-6???? something. I can lookup the exact model if you like. lm_sensors
2.10.1

The problems is that the computer hangs if I run sensors-detect and select
to scan the SMBus PIIx4 adapter. It completly stops responding and I have
to reset it.

sensors-detect also reports:
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0xdf0e

If I load the it87 module the computer also hangs.

Below is the output from sensors-detect:

# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks OSB4 South Bridge

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.

Next adapter: SMBus PIIX4 adapter at 0580
Do you want to scan it? (YES/no/selectively): n

Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0xdf0e
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Sorry, no sensors were detected.

lspci:

00:00.0 Host bridge: Broadcom CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: Broadcom CNB20LE Host Bridge (rev 06)
00:05.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg
NIC (rev 01)
00:07.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
00:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
00:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: Broadcom OSB4 IDE Controller
00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04)

Does anybody have an idea what might be wrong?

-- 
/Peter Welzien

