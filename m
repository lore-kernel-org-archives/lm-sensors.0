From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH 2.6] Add class definition to the elektor bus driver
Message-Id: <20050305114003.1c7055f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050225211155.0d258af2.khali@linux-fr.org>
In-Reply-To: <20050225211155.0d258af2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

Sorry for the delay.

> I understand and agree with your comments about isolating chip
> drivers from bus drivers. My point is since the Elektor is just a bus
> master, it does not know what class of chips might be placed on its
> bus just that they are I2C.

Same is true of all I2C and SMBus masters.

> The only analogy I can think of is saying a PCI Bridge/Master chip is
> of class "video" because there is a video device on its bus. There
> may also be an ethernet device, sound device, etc.

The analogy doesn't fly IMHO. The PCI specification handles the classes
natively, and additionally supports identification of devices through
unique IDs. The I2C bus (or SMBus which builts on top of it) doesn't
have anything like that. The only way we can find out what a chip on
such a bus is, is by probing it manually, and recognize a register map we
already know of. There is no way to find out the class of a given chip.

This is the reason why classes were introduced. I still agree with you
that in theory, any type of chip could be connected to every bus. But it
happens not to be true in the real world. So classes let us skip a
number of probes we know cannot succeed, and at the same time probes
that could have confused some chips. Sure this isn't a perfect solution,
but there's hardly more we can do.

> This is where my comment comes from that the use of the Elektor 
> driver/module does not define that only hardware monitor
> chips/devices are located on the bus. Yes is capable of communicating
> with hardware monitor chips but it can also communicate with other
> classes such as eeprom and sound.

Agreed. If this ever really happens, we'll update the class definition
accordingly.

Note that the way things are done, it is possible to alter the class of
a bus driver depending on the running system. If a given bus driver
never hosts a given class of chips except on one given system, the class
can by dynamically altered for this one system, so that the behavior for
the other systems will be left untouched. I don't think this has ever
been done, but this should be remembered.

Thanks,
-- 
Jean Delvare
