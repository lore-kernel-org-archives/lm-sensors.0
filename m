From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: New SMSC Super-I/O driver
Message-Id: <20041126060830.GH5231@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <c6FuDL1Y.1101289916.2974810.khali@gcu.info>
In-Reply-To: <c6FuDL1Y.1101289916.2974810.khali@gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-11-24 10:51:56 +0100]:
> 
> Hi Mark (Hoffman),
> 
> Did you verify if the new driver you wrote for the SMSC LPC47B397 would
> be suitable for the 47M15x and 47M192 chips? These are also compatible
> with the 47M10x, 47M13x and 47M14x series for the fan part and have
> additional temp (& voltage?) channels, just like the 47B397.

AFAICS, the register access functions of the 47b397 are different from
the rest... they are one level further indirected.  At any rate, I have
always thought it preferable to have only *very* closely related chips
supported by the same driver.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
