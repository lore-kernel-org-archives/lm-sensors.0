From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Add class definition to the elektor bus driver
Message-Id: <20050225233146.44f85ca9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050225211155.0d258af2.khali@linux-fr.org>
In-Reply-To: <20050225211155.0d258af2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

> The patch works BUT...
> The PCF8584 device is a bridge, not a hardware monitor. One of the
> other  I2C device types could very well be behind it such as a sound
> chip.  Maybe we could add a BRIDGE type or have it as a I2C_CLASS_ALL
> device.  This is just a suggestion - like I said, the patch works for
> me.

The PCF8584 is an I2C master, as I understand it. It's as much of a
bridge as every other I2C or SMBus master is. The idea of a bridge class
doesn't make any sense to me. A class is meant to isolate chip drivers
from bus drivers. As such, class definitions are carried by bus drivers
and checked by chip drivers. This doesn't leave any room for a bridge
class unless I'm missing something obvious.

Setting class to I2C_CLASS_ALL would somehow defeat our attempt to
isolate different types of I2C busses. It's better to add classes when
it is found that we actually need them.

That being said, I don't know exactly where the PCF8584 is found and
what the Elektor is. Care to tell me what kind of hardware your are
playing with?

Thanks,
-- 
Jean Delvare
