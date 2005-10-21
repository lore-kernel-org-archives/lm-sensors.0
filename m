From: ch@westend.com (Christian Hammers)
Date: Fri, 21 Oct 2005 10:37:36 +0000
Subject: [lm-sensors] [Ticket #2078] sensor values are sometimes wrong
Message-Id: <20051021083606.GB19748@westend.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

It seems to be related to the above mentioned bug number but the FAQ was
a bit unclear how to include the ticket number in the subject :)

My problem is that sensors sometimes reports confusing values i.e.
- it prints ALERT although the corresponding values are fine, the ALERT
  then vanished in the next read
- sensor values give suddenly 0 or arbitrary values
- configured limits are 0 for one or two reads and then go back to the
  defined value
- chassis intrusion is set just for a couple of seconds

This makes it absolutely unusable for monitoring in production use.
I had have this before on several other mainboards, too. It can be
circumvented by reading the sensors output trice and only alert if you
get an alert in all three readings but this should not be the task of
the user :) On this mainboard here it is worse than ever though.

bye,

-christian-

Data for this mainboard although the problem is more general and
experienced on several other models and brands, too:

# lsmod
Module                  Size  Used by
i2c_dev                10880  0 
eeprom                  7944  0 
asb100                 23872  0 
i2c_sensor              3104  2 eeprom,asb100
i2c_i801                8400  0 
i2c_core               24576  5 i2c_dev,eeprom,asb100,i2c_sensor,i2c_i801
...

# lspci -n
0000:00:00.0 0600: 8086:2560 (rev 02)
0000:00:01.0 0604: 8086:2561 (rev 02)
0000:00:1d.0 0c03: 8086:24c2 (rev 02)
0000:00:1d.1 0c03: 8086:24c4 (rev 02)
0000:00:1d.2 0c03: 8086:24c7 (rev 02)
0000:00:1d.7 0c03: 8086:24cd (rev 02)
0000:00:1e.0 0604: 8086:244e (rev 82)
0000:00:1f.0 0601: 8086:24c0 (rev 02)
0000:00:1f.1 0101: 8086:24cb (rev 02)
0000:00:1f.3 0c05: 8086:24c3 (rev 02)
0000:00:1f.5 0401: 8086:24c5 (rev 02)
0000:01:00.0 0300: 10de:002c (rev 15)
0000:02:03.0 0c00: 1106:3044 (rev 80)
0000:02:04.0 0104: 105a:3376 (rev 02)
0000:02:05.0 0200: 14e4:16a6 (rev 02)
0000:02:0a.0 0200: 8086:1076
0000:02:0b.0 0200: 10b7:9055 (rev 30)
0000:02:0c.0 0100: 1000:000f (rev 03)

# lspci 
0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82) 0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta LT] (rev 15)
0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
0000:02:04.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
0000:02:05.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X Gigabit Ethernet (rev 02)
0000:02:0a.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
0000:02:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
0000:02:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 03)

  Installed I2C busses:
    i2c-0       unknown         SMBus I801 adapter at e800
Algorithm unavailable
root@netflow:/home/ch# i2cdetect 0    
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX 
30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX 44 XX XX XX UU UU XX XX XX XX XX XX 
50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX                


# dmidecode

	# dmidecode 2.6
	SMBIOS 2.3 present.

        BIOS Information
                Vendor: Award Software, Inc.
                Version: ASUS P4PE ACPI BIOS Revision 1002
                Release Date: 10/28/2002

        Base Board Information
                Manufacturer: ASUSTeK Computer INC.
                Product Name: P4PE    
                Version: REV 1.xx


# sensors -v
sensors version 2.9.1 with libsensors version 2.9.1

# uname -r
2.6.8-2-686-smp


-- 
Christian Hammers             WESTEND GmbH  |  Internet-Business-Provider
Technik                       CISCO Systems Partner - Authorized Reseller
                              L?tticher Stra?e 10      Tel 0241/701333-11
ch@westend.com                D-52064 Aachen              Fax 0241/911879

