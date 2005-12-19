From: hidden@paradise.net.nz (Volker Kuhlmann)
Date: Mon, 19 Dec 2005 16:07:24 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card temperature
Message-Id: <20051219160724.GB7529@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399BE92.9020705@mathematica.scientia.net>
In-Reply-To: <4399BE92.9020705@mathematica.scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > kernel: nvidiafb: cannot request PCI regions

> Look for a conflicting device in /proc/iomem.

Thanks! Now nvidiafb loads without trouble, but I didn't do anything.
Perhaps it has something to do with switching to nvidia's binary-only
geforce driver, or updating the mobo bios to latest. No additional
anything though from either sensors-detect or i2cdetect -l.

For fun, I tried the rivafb module again too, it now also loads without
syslog message, but still doesn't show me any i2c anything on the
graphics card.

I conclude therefore that the card doesn't have any i2c facilities. For
anyone else trying the same, the card is a

Gigabyte GV-NX66256DP 6600 PCIE Video Card
05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2)
05:00.0 Class 0300: 10de:0141 (rev a2)

Thanks for all your help, it's really appreciated. And thanks for some
cool software!

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

