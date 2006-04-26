From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Apr 2006 18:21:19 +0000
Subject: [lm-sensors] tyan 2891 on RHEL 4 2.6.9-32ELsmp kernel
Message-Id: <20060426202119.ddd964c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <0D6FBA307D01EA42BAC8715725643AA01EDA2B@EXCHG2003.microtech-ks.com>
In-Reply-To: <0D6FBA307D01EA42BAC8715725643AA01EDA2B@EXCHG2003.microtech-ks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brady,

> Hi all, Just need a validation whether RHEL 4 2.6.9-32ELsmp
> does not support nForce4 SMBus. I believe 2.6.9 is pre 2.9.1.

Put that way it sounds a bit strange, but you're right. lm_sensors
2.9.1 was released in April 2005, while linux 2.6.9 was released in
October 2004.

> lspci -v output
> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
>         Subsystem: Tyan Computer: Unknown device 2891
>         Flags: 66Mhz, fast devsel, IRQ 177
>         I/O ports at 1000 [size2]
>         I/O ports at 5000 [sized]
>         I/O ports at 5040 [sized]
>         Capabilities: [44] Power Management version 2

Support for this device was added in linux 2.6.12. Not all is lost
though. All we did was adding the PCI ID for the device, the rest of the
code was unchanged. It is possible to dynamically add supported IDs to
PCI drivers. Try it:

modprobe i2c-nforce2
echo "10de 0052" > /sys/bus/pci/drivers/nForce2_smbus/new_id

This should instanciate two SMBus on your system.

-- 
Jean Delvare

