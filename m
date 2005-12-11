From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 11 Dec 2005 14:52:05 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic
Message-Id: <439C3D15.6020207@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well it already works for me (using the nvidia-settings tool, nvclock
> badly crashes my system), however I thought it would be good to have
> lm_sensors supportet this natively.
> 
> Chris.

You can try:
1) load i2c-rivatv (or whatever driver for the i2c nvidia bus)

Run sensors detect it  should find he w83785

If so blow out the dust from that driver and try it for yourself.
I have no time for this must finish my university studies.
Regards
Rudolf

> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

