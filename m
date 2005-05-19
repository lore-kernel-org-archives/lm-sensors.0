From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: Fw: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <UL485nv1.1109946583.4908820.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

> Hmm but what device it controls? Some multiplexer? or some other black box
> doing nasty things ;) ? More likely it is a multiplexer.

Yes, most probably. Philips (and probably others) make I2C multiplexers
that can be controlled using GPIOs.

> I have a theory that maybe SMM (system management mode code) is blocking
> SMBUS controller for time to time, so thatswhy they are always looking if
> the bus is busy or not before writing there Is your windows  driver doing
> same?
>
> If my theory is correct you should see in your system long on that
> motherboards some entries from "i2c-piix4" (whatever it is its name)
> complaing about transaction failure, i2c busy etc...

This is the i2c-i801 driver. I am not sure that this driver properly
handles errors (seems to be a weak point of many drivers in lm_sensors),
so maybe this is something that should be improved to help in this
specific case.

Chunhao, make sure you compile i2c-i801 with debugging enabled, that
might help you understand what happens.

--
Jean Delvare
