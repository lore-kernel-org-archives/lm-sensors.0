From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 May 2008 12:14:26 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <20080509141426.40a5d666@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Achim,

On Fri, 09 May 2008 13:51:30 +0200, achim wrote:
> I tried the patch here. The 1-register chips got detected.

Great! Thanks for testing :)

> There still seem to be other chips causing the smbus master to stop
> working after the sensors-detect run. I tried to exclude the chips
> I could not i2cdump correct (0x47 (some oncpu device) ,0x6e (pcie) and
> 0x70(sensors chip?) ) and also added 0x52, 0x53 amd 0x57 but still no
> luck. After the sensors-detect i can not i2dump chips till a new cold
> start.

For 0x47 you can apply this patch which is already in SVN:
http://www.lm-sensors.org/changeset/5235

> The detection program hangs for a few (2-3) seconds at the LM75 probing 
> line on chip at 0x4e (cpu's thermal interface).

The LM75 detection is complex because the LM75 has no identification
register so we have to use a costly heuristic to identify it reliably.
So I am not surprised that it takes some time and it appears to hang
for a few seconds.

I don't know what device on the SMBus is causing the problem. Can you
please try excluding _all_ the addresses which i2cdetect shows as used?

Note that i2cdump, by default, uses byte transactions, while some
detections in sensors-detect make use of word transactions. It could be
that one of your chips is happy with byte transactions but chokes on
word transactions and then keeps the bus in a busy state. You could use
the "w" mode of i2cdump to test this theory.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
