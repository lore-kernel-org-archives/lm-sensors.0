From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: lmsensor support for laptop
Message-Id: <XKEnRuao.1114591999.4146320.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050427083553.GA28167@aix.meng.auth.gr>
In-Reply-To: <20050427083553.GA28167@aix.meng.auth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Edouard,

> I have a (recent) laptop whose motherboard chipset is
> an intel 855GME, this chipset seems not mentionned
> in the lmsensors web pages,

The 855GME itself is of little use for hardware monitoring, as it is a
graphics and memory controller hub. However, it is typically associated
with another chip such as the I82801DBM (aka ICH4-M), which does contain
an SMBus master, to which hardware monitoring devices may be connected.

The I82801DBM SMBus is supported by our i2c-i801 driver, and listed as
such on our "supported devices" web page.

> could you confirm me that this chipset is not supported, and that it is not
> worth installing lmsensors on my laptop ?

While the I82801DBM chip itself is supported, we cannot promise anything.
First, the SMBus component may not be enabled (most notably Asus, HP and
Toshiba are known to disable them). This can usually be worked around.
Second, there may not be any hardware monitoring device connected to the
SMBus (which may be the reason why the SMBus was disabled in the first
place.) It is rather frequent for laptops not to embed a hardware
monitoring device.

So you should give a try to lm_sensors on your laptop, but keep in mind
that it might require some tinkering, and might not work at all.

--
Jean Delvare
