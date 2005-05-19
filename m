From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: sensors conf update for asrock k7vt4a+ mainboard, patch
Message-Id: <20050219093218.06b874a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4216BEAC.70909@gmx.de>
In-Reply-To: <4216BEAC.70909@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> new mb ;)
> 
> patch attached.
> 
> verified with multimeter and bios.

Thanks for the contribution! We really need an online repository for
motherboard-specific info...

+#    compute in2 (-(1/400)+1)*@ ,  @/(-(1/400)+1)

Hmm, I'm sure this one would be just fine without any compute line.

-- 
Jean Delvare
