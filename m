From: mill.tek@verizon.net (MillTek)
Date: Thu, 04 Jan 2007 06:35:49 +0000
Subject: [lm-sensors] Problem with MSI K9N6SGM-V motherboard sensors
Message-Id: <459CA045.7050603@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
Been trying to get the fan speeds etc. from this notherboard the last 
few days.  Kernel is 2.6.19.  Lm_sensors is up-to-date.
Sensors-detect gives the following; (just an extract where I think the 
problem is)

Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0x0541

The only modprobes recommended are;

modprobe eeprom
modprobe k8temp

If I run sensors I get;

sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +26?C
Core1 Temp:
             +26?C


The Bios shows fan speeds etc.  Is there anything I can do???


Jim









