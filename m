From: jonsmirl@gmail.com (Jon Smirl)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <9e4733910409211039273d5a2f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
	 <41506099.8000307@web.de>
In-Reply-To: <41506099.8000307@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold-ml@web.de>
Cc: Greg KH <greg@kroah.com>, Michael Hunold <hunold@linuxtv.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, sensors@stimpy.netroedge.com

There is a related I2C problem with EEPROMs and DDC monitors. DDC
monitors look just like EEPROMs, the EEPROM driver can even read most
of them. But there are DDC monitors that need special wakeup sequences
before their ROMs will appear.

EEPROM and DDC are both algo_bit clients. When you attach a bus to
algo_bit both clients will run. There is concern that sending the
special DDC wake up sequence down non-DDC buses might mess up the bus.

A proposal was made to implement different classes of algo_bit clients
but this was never implemented. Would a class solution help with the
dvb problem too?


-- 
Jon Smirl
jonsmirl@gmail.com
