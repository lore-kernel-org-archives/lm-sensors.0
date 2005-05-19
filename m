From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: TI TMP101 driver
Message-Id: <20050219174619.3792f2e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050218154856.GA14189@home.fluff.org>
In-Reply-To: <20050218154856.GA14189@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben, hi Mark,

> > isn't this chip compatible with the LM75 and its driver?
> > what's different about it if anything?
> 
> configuration register is different, the temperature
> comparison is also different (tmp101 has low/high range)

Configuration is extended but compatible. Your driver doesn't seem to
make use of the extra configuration bits (only raises OS/ALERT, which is
already set by default).

I also see no difference in the comparison mechanism. Tlow and Thigh are
misnomers, if you look at the output transfer functions diagrams (page 6
of the datasheet) you see that it really is a high limit with an
hysteresis, just like the LM75 has.

I agree with Mark, your driver is essentially redundant with the lm75
driver. I invite you to test the lm75 driver on your device. You might
need to use the force parameter (the detection method is quite tricky)
but otherwise I'd expect it to work just fine. If it does, we might
simply need to tweak the detection function (once more) to recognize the
TMP101.

See this thread for a previous discussion on this same topic:
http://archives.andrew.net.au/lm-sensors/msg26681.html

(Side question, where do you have such a chip? Seems to be quite rarely
used.)

Thanks,
-- 
Jean Delvare
