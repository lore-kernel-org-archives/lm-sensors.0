From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Asus A8V Deluxe
Message-Id: <WsmbPSVH.1108545537.4508950.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42120C36.6000107@highlandsun.com>
In-Reply-To: <42120C36.6000107@highlandsun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Howard,

> I think the CPU temp readings are a little low compared to
> what the BIOS reports too, but it's hard to verify.

See FAQ 4.12:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e12

> I also started powernowd, and when the CPU goes into low power mode not
> only does the clock frequency drop from 1.8GHz to 1.0GHz, but VCore also
> drops from 1.75V to 1.41V, which triggers an alarm. I suppose I can just
> set a lower minimum for VCore, but I wonder if that might mask a fault
> somewhere down the road?

No, that's actually what you should do. I don't know exactly how
powernowd works, but if it generates events when the speed and vcore
change, you might use these to reprogram the limits on the fly. That'd
allow you to have one short range for each nominal vcore, instead of one
large range covering both, which somewhat limits the efficiency of the
monitoring.

I have to admit that our current architecture doesn't really cover this
situation, so it's left to you to implement the limts change as a hack
if you think it's worth the effort.

--
Jean Delvare
