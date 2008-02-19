From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2008 09:52:10 +0000
Subject: Re: [lm-sensors] [PATCH] adt7473: New driver for Analog Devices
Message-Id: <20080219105210.2b8b0960@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071219034116.GM6870@tree.beaverton.ibm.com>
	<20071219154759.7be5025c@hyperion.delvare>
	<20071219231437.GR6870@tree.beaverton.ibm.com>
	<20080217200250.GD2916@jupiter.solarsys.private>
	<20080218213234.GC5784@tree.beaverton.ibm.com>
In-Reply-To: <20080218213234.GC5784@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Mon, 18 Feb 2008 13:32:34 -0800, Darrick J. Wong wrote:
> Ok.  I wonder if the nouveau people have any intention to
> reverse-engineer the i2c controller?

There's probably not much to reverse-engineer, the nvidiafb driver has
been supporting the I2C controllers (using software-driven bit-banging)
for a long time now. Maybe the hardware can do better but it's probably
not a big deal as I2C access on a graphics adapter isn't performance
critical.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
