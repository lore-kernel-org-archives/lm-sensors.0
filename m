From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 05 Sep 2006 07:50:13 +0000
Subject: [lm-sensors] Random thoughts on fan speed control
Message-Id: <44FD2C35.7030804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060904231231.c7dc7e1f.khali@linux-fr.org>
In-Reply-To: <20060904231231.c7dc7e1f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Just quick snip because I gotta work too ;)

> * Reading the F71805F documentation, I learned that the external
> circuitery needed for PWM fan speed control is completely different
> from the one needed for DC fan speed control. So I wonder if it is a
> good idea to let the user change between the two modes. Clearly the
> BIOS should set it right. I tried to switch to DC mode and it had no
> effect at all on my fan (not even on/off). I wonder if it is possible
> to confuse or even damage the hardware by using the wrong mode?

Yes DC/PWM settings were already removed from W83793 and imho not implemented on 
EHF too.

You need to know what circuits are onboard -> BIOS should do that for you. If 
you want to implement this I would suggest just a kernel param for BIOS fixups.

Rudolf

