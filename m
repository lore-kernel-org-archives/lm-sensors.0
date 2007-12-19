From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Dec 2007 14:47:59 +0000
Subject: Re: [lm-sensors] [PATCH] adt7473: New driver for Analog Devices
Message-Id: <20071219154759.7be5025c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071219034116.GM6870@tree.beaverton.ibm.com>
In-Reply-To: <20071219034116.GM6870@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Tue, 18 Dec 2007 19:41:17 -0800, Darrick J. Wong wrote:
> This driver reports voltage, temperature and fan sensor readings
> on an ADT7473 chip.  The ADT7467 chip seems to share some registers
> with this one, so it may be possible to add support for it, though
> the therm_adt746x driver seems to cover it ok on a PPC Mac.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

I've updated the ADT7473 entry on wiki/Devices to point to this post.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
