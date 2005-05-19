From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Problem with SMbus
Message-Id: <1075984057.402236b9b8eeb@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075981068.15216.14.camel@localhost.localdomain>
In-Reply-To: <1075981068.15216.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the mailing list, not to me.]

Quoting Michal Demin <robots@twincar.sk>:

> I have MB : qdi SinactiX 5EP (82801EP)

There's no such thing as 82801EP as far as I know. According to the
lspci output below, I'd say it is an 82801BA (aka ICH2).

> Here is also lspci
> 00:00.0 Class 0600: 8086:1130 (rev 04)
> 00:01.0 Class 0604: 8086:1131 (rev 04)
> 00:1e.0 Class 0604: 8086:244e (rev 05)
> 00:1f.0 Class 0601: 8086:2440 (rev 05)
> 00:1f.1 Class 0101: 8086:244b (rev 05)
> 00:1f.2 Class 0c03: 8086:2442 (rev 05)
> 00:1f.4 Class 0c03: 8086:2444 (rev 05)
> 00:1f.5 Class 0401: 8086:2445 (rev 05)
> 01:00.0 Class 0300: 10de:0110 (rev b2)
> 02:0e.0 Class 0200: 10ec:8139 (rev 10)
> 
> There is something missing between 2442 and 2444 ..

Hmm, 2443? ;)

> I have SpeedFan under W2k and it recognizes my SMBus well ...
> Is there way how could i make it working ?? 

This is a known problem. BIOS hides the device. See in prog/hotplug,
there's p4b_smbus.c, README.p4b and Makefile.p4b. You need to use this.
Move there, "make -f Makefile.p4b", install and insmod module
p4b_smbus.o. Then you should be able to use the i2c-i801 driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
