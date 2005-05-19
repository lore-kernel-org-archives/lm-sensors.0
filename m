From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [RFC] driver core support for i2c bus and drivers
Message-Id: <3E7676F7.40209@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030310072337.GJ6512@kroah.com>
In-Reply-To: <20030310072337.GJ6512@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

our userspace tools use the /proc/bus/i2c file and (of course) the entire
tree of exported sysctl info under /proc/sys/dev/sensors
(as implemented in i2c-proc.c).

Does your proposal or Cristoph's recent changes affect these?

mds


Albert Cranford wrote:
> Greg KH wrote:
> 
>>Hi all,
>>
>>Here's a fairly small patch against 2.5.64 that adds initial driver core
>>support for the i2c code.  It only has logic for the i2c bus, i2c bus
>>controllers, and i2c drivers, but it's a start :)
>>
>>As an example, with this patch, the i2c-piix4 driver shows up in the pci
>>bus as (other devices omitted for clarity):
>>
>>[greg@desk sys]$ tree bus/pci
>>bus/pci/
>>|-- devices
>>|   |-- 00:07.3 -> ../../../devices/pci0/00:07.3
>>`-- drivers
>>    |-- piix4 smbus
>>    |   `-- 00:07.3 -> ../../../../devices/pci0/00:07.3
>>
>>And within that device, the first i2c bus is located:
>>
>>[greg@desk sys]$ tree devices/pci0/00:07.3
>>devices/pci0/00:07.3
>>|-- i2c-0
>>|   |-- name
>>|   `-- power
>>
>>And the i2c bus looks like:
>>
>>[greg@desk sys]$ tree bus/i2c/
>>bus/i2c/
>>|-- devices
>>`-- drivers
>>    `-- EEPROM READER
>>
>>I'll move on to adding i2c device support to the core, but that will be
>>a bit more work.  Comments on this patch are appreciated.
>>
>>thanks,
>>
>>greg k-h
>>
>>p.s. Yes, I added the i2c-piix4 and i2c-ali15x3 and i2c-i801 drivers to
>>my kernel tree, from the i2c CVS tree, and tweaked them to actually work
>>properly.  If someone wants those patches right now, please let me know.
>>
> 
> I like.  The proc/bus directory was geting cluttered.
> I think the driver model would be a good for i2c/sensors.
> Do you have any input for isa already in your bag of
> goodies?
> Albert
> 
