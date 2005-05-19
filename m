From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <20040921223325.66b07f78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org>
	<20040921154111.GA13028@kroah.com>
	<41506099.8000307@web.de>
	<9e4733910409211039273d5a2f@mail.gmail.com>
In-Reply-To: <9e4733910409211039273d5a2f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Michael Hunold <hunold-ml@web.de>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

> There is a related I2C problem with EEPROMs and DDC monitors. DDC
> monitors look just like EEPROMs, the EEPROM driver can even read most
> of them. But there are DDC monitors that need special wakeup sequences
> before their ROMs will appear.
> 
> EEPROM and DDC are both algo_bit clients.

Not true. algo-bit refers to i2c bus implementations, not i2c clients.
It happens that all DDC monitors are accessed through bit-banging I2C
busses (real I2C busses, as opposed to SMBus), but other EEPROMs do not.
Most EEPROMs are from memory modules and hang off the motherboard SMBus
(which by definition does not depend on algo-bit).

> When you attach a bus to algo_bit both clients will run.

FYI, there is no ddcmon driver in Linux 2.6 and I believe there won't
be. The eeprom driver should do the job. Converting the EEPROM data to
significant info belongs to user-space.

> There is concern that sending the
> special DDC wake up sequence down non-DDC buses might mess up the bus.

This is however true, and I agree that Michael's proposal could help in
this respect. And I actually believe that his I2C classes implementation
would help more than the "command" callback. After all, you need the DDC
data to identify the monitor, and (in some cases) need to know the
monitor to properly access the DDC data...

(BTW, I am not certain at all that we should add support for these
broken monitors. As far as I can see, they do not support the DDC
standard, too bad for them. I would hate to break standard-compliant
monitors by implementing tricks to support non-standard ones.)

> A proposal was made to implement different classes of algo_bit clients
> but this was never implemented. Would a class solution help with the
> dvb problem too?

As a side note, the classes apply to all I2C adapters, not just
bit-banging ones. And classes apply to the busses purposes (video, ddc,
sensors etc...), not the technical details such as the bus being I2C
compatible or only SMBus.

I have the feeling that we should go on implementing these classes
first, and see what else is needed only after that.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
