From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <Pine.LNX.4.58.0502081257520.7839@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> * One additional voltage input.

Which one?
It has 6 analog inputs as HF has too. ( I looked to PIN assigment table)

> * 8mV LSB for voltages instead of 16mV.=> yes
> * Two additional fan inputs. => I can see only one
> * I2C interface, but no subclients? => undocumented?
> * One additional fan control output. => I can see two
> * Fan control can optionally operate in DC mode. => yes

Some pins are shared, what happen if they are used for other function?
They will return zero? Or bogus?

>
> I'd like someone else to read the datasheet and confirm/complete this
> list. Once we know exactly what the differences are, we can decide
> whether it is better to add support to an existing driver or create a
> new one. Some of the additional features would be trivial to add (such
> as the additional voltage input), but some are more tricky (VID for
> example).

Also one interresting bit changed to reserved

Address Register (Port x5h)
Bit7: Read Only

The logical 1 indicates the device is busy because of a Serial Bus
transaction or another LPC bus
transaction. With checking this bit, multiple LPC drivers can use W83627HF
hardware monitor without
interfering with each other or a Serial Bus driver.
It is the user's responsibility not to have a Serial Bus and LPC bus
operations at the same time.
This bit is:

Set: with a write to Port x5h or when a Serial Bus transaction is in
progress.
Reset: with a write or read from Port x6h if it is set by a write to Port
x5h, or when the Serial Bus
transaction is finished.

Regards

Rudolf
