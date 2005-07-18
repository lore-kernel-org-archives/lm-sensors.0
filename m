From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 18 Jul 2005 21:12:25 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050718211159.43ccf5ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:
> Could we plan a 2.9.2 release by the end of the month? It's three
> months ago since the previous release already. The list of changes
> isn't very long, but there are a few things people could be interested
> in: a new driver (i2c-ali2563), Linux 2.6 support for decode-dimms.pl
> and rrd, and a few improvements to sensors-detect which may help our
> support work.

On second thought, and let alone the fact that I obviously meant
i2c-ali1563, we probably want 2.9.2 to have a libsensors which supports
/sys/class/hwmon, as this paves the way to the true separation or
ISA-only hardware monitoring drivers from the i2c core.

Thanks,
-- 
Jean Delvare
