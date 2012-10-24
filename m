From: Harald Judt <h.judt@gmx.at>
Date: Wed, 24 Oct 2012 18:14:41 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <50883011.9050201@gmx.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Am 24.10.2012 20:05, schrieb Harald Judt:
[...]
> Thank you for your patch. I've applied it on 3.6.2, and it seems to work
> fine. The values are saved and restored correctly, and they also keep
> changing after resume. Further it gave me a little insight in how
> suspend/resume code works.

Sorry, I stand corrected. Not all min/max values have been restored:

Before suspend:
in1:           +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
AVCC:          +3.34 V  (min =  +2.98 V, max =  +3.63 V)
+3.3V:         +3.34 V  (min =  +2.98 V, max =  +3.63 V)
in4:           +1.05 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:           +1.68 V  (min =  +0.00 V, max =  +0.00 V)  ALARM

After resume:
in1:           +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
AVCC:          +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
+3.3V:         +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:           +1.05 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:           +1.68 V  (min =  +0.00 V, max =  +0.00 V)  ALARM

I somehow missed the min/max differences in AVCC and +3.3V, too many 
numbers ;-)

But the rest is fine, double-checked now.

BTW: cpu0_vid is always +0.000 V, am I right assuming this simply isn't 
supported on my board?

Harald

-- 
`Experience is the best teacher.'


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
