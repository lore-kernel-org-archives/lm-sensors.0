From: leen smit <leen@service2media.com>
Date: Fri, 12 Dec 2008 11:54:29 +0000
Subject: [lm-sensors] hwmon-vid: requested unknown VRM version
Message-Id: <494250F5.2030607@service2media.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Dear all,

Im running lm-sensors on a HP thinclient wich i use as a fileserver.
I first installed from the repositories, but I got a VRM error when 
running sensors. After that i remove the package and compiled the latest 
version from source. Again, with the same error.
THe output of sensors is OK. That is, its show the 
voltages/temperatures.  But what ever I try, I keep getting the vrm 
error on my console. I've been searching through the archives and found 
similair problems but i couldnt get the patches  out of this messages 
(garbled in the archive?)
I've also tried disabling the loaded modules one by one, in the idle 
hope that might make difference.. no success..

Other thing i tried changes some setting in the .conf file again to no 
avail..

im not sure if I can supply more detail for the error. The error as 
mentioned in the title is all I see in my logs

At the moment it workable, but my logs get quite bijg, and working on a 
tty is inpossible because the errors is spammed on all consoles.

Any help would be greatly appreciated!

Leen Smit


debian stable, kernel 2.6.18-6-686
sensors version 3.0.3 with libsensors version 3.0.3
/etc/modules
i2c-ali1563
# Chip drivers
smsc47m192
smsc47m1


CPU: Transmeta Efficeon(tm) Processor TM8000
  System Info: #1
    Manufacturer: "Hewlett-Packard"
    Product: "hp t5000 series"
    Serial: "CNV534052J"
    UUID: undefined, but settable
    Wake-up: 0x06 (Power Switch)
  Board Info: #2
    Manufacturer: "Hewlett-Packard"
    Product: "098Ch"
    Serial: "CNV534052J"

PCI(AGP) 100.0: 0300 VGA compatible controller (VGA)
  Model: "ATI Radeon VE"
  Vendor: pci 0x1002 "ATI Technologies Inc"
  Device: pci 0x5159 "Radeon VE"





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
