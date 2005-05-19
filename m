From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: Query: fscpos and fscher fan speed reading
Message-Id: <92po61ptt5abdve2vmos6ikfkpr9nuqmup@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

As part of sorting sysfs naming and documentation I would like 
somebody with either these chips to confirm changing fanX_div 
(fscher) or fanX_ripple (fscpos) has little effect on fan speed 
reading or does the change double/halve fan speed reading?

The datasheet is not clear, but one of these drivers is wrong 
and should be fixed -- which? :)

One driver has fanX_ripple, the other fanX_div...

Ripple is described as pulses (ripples) per revolution of the 
fan, being 2, 4 or 8.

Thanks,
--Grant.
