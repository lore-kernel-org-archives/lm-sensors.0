From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: Asus A8V Deluxe
Message-Id: <yqgip7te.1109320118.7708040.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42120C36.6000107@highlandsun.com>
In-Reply-To: <42120C36.6000107@highlandsun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Howard,

> Still using the w83627thf-* config, but there's no -12V supply and
> there's no battery since this is a desktop machine, so I commented out
> label in4 and label in8 and replaced them with "ignore" ...

Desktops do have batteries, typically 3V lithium-ion CR2032, which may or
may not be monitored on any given system. These are small batteries use
to backup the BIOS/CMOS data and keep the clock running when the system
is powered off.

> I hope this helps any other Asus A8V owners out there...

Certainly, thanks for reporting.

--
Jean Delvare
