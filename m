From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave
Message-Id: <20040114193040.6606813f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
	<20040112014840.GE17845@matchmail.com>
In-Reply-To: <20040112014840.GE17845@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

> How about some patches to add some more sensors to the 2.4 kernel,
> like the ones already in 2.6?

The 2.4 kernel has reached a maintainance-only point so there is no way
lm_sensors could be officially merged into it now, especially since the
i2c layer itself would have to be significantly reworked before.

So your options are either to patch your 2.4 tree using the i2c patch
and additional drivers we provide, or to jump to Linux 2.6.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
