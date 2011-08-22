From: Kevin Hilman <khilman@ti.com>
Date: Mon, 22 Aug 2011 23:58:32 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <874o19gfrr.fsf@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
	<CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
	<20110811185408.GB15970@legolas.emea.dhcp.ti.com>
	<20110811185558.GC15970@legolas.emea.dhcp.ti.com>
	<4E444B8F.9060908@ti.com> <4E449D65.9000004@ti.com>
In-Reply-To: <4E449D65.9000004@ti.com> (Rajendra Nayak's message of "Fri, 12
	Aug 2011 08:56:29 +0530")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rajendra Nayak <rnayak@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, "J, KEERTHY" <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com

Rajendra Nayak <rnayak@ti.com> writes:

[...]

> FWIK, its a one time requirement to set the clock rate to the
> right rate the device can operate in based on what a platform
> supports. 

Except $SUBJECT patch hard-codes the clock rate for all platforms in the
driver.

If the clock rate is to be platform-specific, it should be done in
platform-specific code.

Kevin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
