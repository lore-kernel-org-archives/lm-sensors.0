From: Alessandro Di Marco <dmr@c0nc3pt.com>
Date: Tue, 03 Mar 2009 11:35:50 +0000
Subject: [lm-sensors] dme1737 0-002e: Read from register 0xXX failed! Please
Message-Id: <8a34a7335f9130187e31e88e4b8b9d25@imap.c0nc3pt.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi guys,



after plugging a Tyan M3290 IPMI card into my Tyan Tomcat K8E

(S2865AG2NRF), the syslog keeps reporting as follows:



i2c-adapter i2c-0: Found a DME1737 chip at 0x2e (rev 0x89).

dme1737 0-002e: Optional features: pwm3=yes, pwm5=no, pwm6=no, fan3=yes,

fan4=yes, fan5=no, fan6=no.

i2c-adapter i2c-1: Found a DME1737 chip at 0x2e (rev 0x89).

dme1737 1-002e: Optional features: pwm3=yes, pwm5=no, pwm6=no, fan3=yes,

fan4=yes, fan5=no, fan6=no.

dme1737 0-002e: Read from register 0x21 failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x68 failed! Please report to the driver

maintainer.

wifi0: ath_bstuck_tasklet: Stuck beacon; resetting (beacon miss count: 11)

usb 1-1: new low speed USB device using ohci_hcd and address 2

usb 1-1: configuration #1 chosen from 1 choice

input: USB Mouse as

/devices/pci0000:00/0000:00:02.0/usb1/1-1/1-1:1.0/input/input4

generic-usb 0003:15D9:0A37.0001: input,hidraw0: USB HID v1.10 Mouse [USB

Mouse] on usb-0000:00:02.0-1/input0

usb 1-1: New USB device found, idVendord9, idProduct
37

usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0

usb 1-1: Product: USB Mouse

dme1737 0-002e: Read from register 0x58 failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x6d failed! Please report to the driver

maintainer.

i2c /dev entries driver

dme1737 0-002e: Read from register 0x4f failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x6a failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x88 failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x88 failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x27 failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x6b failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x5f failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x2a failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x50 failed! Please report to the driver

maintainer.

dme1737 0-002e: Read from register 0x69 failed! Please report to the driver

maintainer.



Regards,

Alessandro



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
