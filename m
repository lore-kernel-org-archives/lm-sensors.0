From: laurent.pinchart@tbox.biz (Laurent Pinchart)
Date: Tue, 23 May 2006 10:29:55 +0000
Subject: [lm-sensors] How to control GPIOs I2C chips from a separate
Message-Id: <200605231229.55405.laurent.pinchart@tbox.biz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everybody,

I'm facing a small architecture problem on an embedded (MPC8248) design. The 
processor has a hardware I2C bus for which a driver exists in the Denx 
linuxppc kernel tree at rsync://www.denx.de/git/linux-2.6-denx (the driver is 
called i2c-mpc8260, does anyone know if there are plans to integrate it in 
mainline kernels ?).

Our hardware platform has a DSL daughterboard on which a PCA9557 GPIO I2C chip 
is used to control several DSL functions (resetting chipsets, connecting to 
the line, ...). The DSL and PCA9557 chipsets are thus both part of a single 
"device", but are not connected to the same bus (the DSL chipset is a 
platform device, while the PCA9557 is connected on the I2C bus).

I'm developping the DSL chipset driver, and the needed arises to control the 
GPIO lines from inside the driver. I've had a look at some PCI drivers which 
need to control I2C devices, and all of them have the I2C chips connected to 
an I2C bus controlled by the PCI device. Getting a reference to those chips 
is thus quite easy. I'm a bit puzzled regarding how to do the same for my 
design. Could anyone advice me on how to get a reference to the PCA9557 from 
the DSL platform driver in a clean way ?

Best regards,

Laurent Pinchart

