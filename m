From: Jon Torrey <jonutorrey@gmail.com>
Date: Thu, 05 Mar 2015 16:48:48 +0000
Subject: [lm-sensors] W83627DHG unable to load driver
Message-Id: <CAP1ifE+haCeVp12UPK9kzMeoEV93PgVnFbjoLED2hePgtfg6gg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone,

I am having some serious problems trying to get a sensor to work under
Ubuntu 14.04 with kernel 3.13.11

Below is a link of my post with details.  I did not want to spam the
mailing list with a large message so I am sorry if I broke any rules on
sharing links or re-directing.

http://ubuntuforums.org/showthread.php?t"67869

In a nutshell - my BIOS sees my Super I/O chip but I have been unable to
load the driver.

modprobe w83627ehf returns an error with nothing on dmesg  | tail

modprobe w83627hf returns an error with the following on dmesg | tail -

*[  186.231514] usb 1-1.1: SerialNumber: DEMO00000000*
*[  303.998858] EXT4-fs (sdb2): error count since last fsck: 12*
*[  303.998882] EXT4-fs (sdb2): initial error at time 1424366987:
ext4_journal_check_start:56*
*[  303.998889] EXT4-fs (sdb2): last error at time 1424457489:
ext4_remount:4819*
*[ 1056.137920] w83627hf: Base address not set, skipping*
*[ 1664.413904] ACPI Warning: 0x000000000000f040-0x000000000000f05f
SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1
(20131115/utaddress-251)*
*[ 1664.413923] ACPI: This conflict may cause random problems and system
instability*
*[ 1664.413927] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver*
*[ 1664.413994] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt*
*[ 1664.422417] i2c /dev entries driver*

sensors-detect outputs the following - I will only show the Super I/O
portion since it is quite long.

*Some Super I/O chips contain embedded sensors. We have to write to*
*standard I/O ports to probe them. This is usually safe.*
*Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O
at 0x2e/0x2f*
*Trying family `National Semiconductor/ITE'...               No*
*Trying family `SMSC'...                                     No*
*Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes*
*Found `Winbond W83627HF/F/HG/G Super IO Sensors'            *
*    (but not activated)*
*Probing for Super-I/O at 0x4e/0x4f*
*Trying family `National Semiconductor/ITE'...               No*
*Trying family `SMSC'...                                     No*
*Trying family `VIA/Winbond/Nuvoton/Fintek'...               No*
*Trying family `ITE'...                                      No*

I've tried a numerous amount of things, but in the end it seems that nobody
else has the exact same problem I do.  I haven't ran into any posts that
say people have the *but not activated *after detecting a sensor.

Anything to debug this would be a fantastic help.  Thanks all.

JT
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
