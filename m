From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: AD7418 support
Message-Id: <20040909144801.M48828@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
In-Reply-To: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Togg,

Maybe you could try a visual inspection of the board looking for the hardware
monitoring chip?

You could also use i2cdetect to confirm whether the address is 0x28 or 0x29
(or something different). And while you're at it, you could try to i2cdump the
chip to see what's inside.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
