From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Jul 2005 16:45:32 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <b3U94Vj1.1122043116.4034360.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E04664.3020001@divsol.com>
In-Reply-To: <42E04664.3020001@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi again Jim,

On 2005-07-22, Jim Cromie wrote:
> attached patches allow making with setting in environment.

Oh, BTW, I don't think this is needed. If you want to compile i2c or
lm_sensors for a different kernel than the running one, use:
make LINUX=/path/to/linux

Works fine for me.

Note that this is only needed for Linux 2.4 kernels anyway, which
doesn't seem to be your case.

--
Jean Delvare
