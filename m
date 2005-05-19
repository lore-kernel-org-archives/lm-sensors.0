From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Follow up for Ticket 1538
Message-Id: <20040127220030.59b356f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
In-Reply-To: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> thanks a lot for your answer. I've finally choosen not to use the
> PCF8584 for interfacing the i2c bus because I was not able to modprobe
> it whatever the kernel or the i2c-x version (I've been trying for
> around 3 days). However, I'm still interested to know if it has been
> tested and if anybody uses it successfully.

I'm surprised you couldn't get it to work. As far as I know, the driver
is precisely made for people who build a board according to Simon Vogl's
schematics. If you provide details about the failures, we might try to
help.

> Finally I'm using direct parallel port access and everything works
> fine with the i2c-pport driver :-)

Great. Couldn't you do the same with more simple parallel-ports
adapters, such as i2c-philips-par, i2c-elv or i2c-velleman? These have
been ported to Linux 2.6 already, and are supported by my unified driver
too, while i2c-pport hasn't been ported and isn't part of the unified
driver.

Actually I wonder if I will port and/or integrate the i2c-pport logic in
Linux 2.6, because in most cases, the additional complexity shouldn't be
required. But if you really need it, I'll think of it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
