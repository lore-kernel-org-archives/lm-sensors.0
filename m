From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: Fw: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <Pine.LNX.4.58.0503041448180.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> 2. We would need detailed information on what chip we attept to control at
> the port 0x04b9 and how that chip works, and also details on how the
> SMBus is wired.
> => The control signal defined GPIO in this Hance Rapid ICH, and only
> access a method in the SMBus.
>

Some questions to think about...

Hmm but what device it controls? Some multiplexer? or some other black box
doing nasty things ;) ? More likely it is a multiplexer.


> 3. Beside the question 2, we will need the base address of that ISA device,
> also if the base address is not fixed we would need the detection method
> how to get the base address, from some PCI config space maybe?)
> =>The GPIO pin defined to relate with south bridge. If south bridge has
> changed, the GPIO pin has different.


I check this
http://www.intel.com/design/intarch/datashts/30064103.pdf

Page 303/302 nice table. So at least we are able to catch
the base addr.

I have a theory that maybe SMM (system management mode code) is blocking
SMBUS controller for time to time, so thatswhy they are always looking if
the bus is busy or not before writing there Is your windows  driver doing
same?

If my theory is correct you should see in your system long on that
motherboards some entries from "i2c-piix4" (whatever it is its name)
complaing about transaction failure, i2c busy etc...

Jean some other ideas?

Regards

Rudolf
