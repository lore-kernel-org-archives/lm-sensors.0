From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <20050227184837.2563a454.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050226191142.6288b2ef.khali@linux-fr.org>
	<20050227131027.GM25818@edu.joroinen.fi>
In-Reply-To: <20050227131027.GM25818@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

Hi Pasi,

> Do you know about driver for W83627THF watchdog? I'm using Supermicro
> P8SCI motherboard, and I haven't found working driver for it..

Have you tried w83627hf_wdt? I took a quick look at the W83627HF and
W83627THF datasheets and watchdog timer seems to work identically. Since
the driver doesn't seem to identify the chip (it probably should, BTW),
I'd expect it to work.

Hope that helps,
-- 
Jean Delvare
