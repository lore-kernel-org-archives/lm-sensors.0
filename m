From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: no i2c device !!!
Message-Id: <20040923205346.4758d3fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040923170611.GA29569@cereve.enpc.fr>
In-Reply-To: <20040923170611.GA29569@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I installed linux on an laptop toshiba-satellite 2140 CDS
> 
> I had also some difficulties in finding the name of ships or buses 
> ( why compiled them all ), hard also to retrive info from toshiba
> itself,
> 
> I compiled the 2.6 kernel, with all i2C devices, bus and chips as
> modules, but when installing lm-sensors, I had no positive answeer
> for bus or ships corresponding ( although all compiled )
> 
> I wonder if it is possible that this laptop has no i2c device ??

Yes, this is highly possible. Most laptops don't have hardware
monitoring chips, and some of them even disable the SMBus entirely.

There is a possibilty though that your SMBus is disabled BUT there are
hardware monitoring chips on it. The reason why manufacturers do that
are not clear.

If your SMBus is disabled (sensors-detect didn't find it) and you know
it's an Intel i801, you may try to forcibly enable it. Follow the
instructions in lm_sensors2/proc/hotplug, and then tweak the
drivers/pci/quirks.c file in Linux 2.6. That's not trivial but if you
are motivated enough you may get it to work.

If on the other hand the bus is enabled and sensors-detect did not find
anything on it, game is over.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
