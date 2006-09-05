From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 05 Sep 2006 15:01:13 +0000
Subject: [lm-sensors] Random thoughts on fan speed control
Message-Id: <4dfa50520609050801g14accaf2t42f109987ac6a2c5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060904231231.c7dc7e1f.khali@linux-fr.org>
In-Reply-To: <20060904231231.c7dc7e1f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,

> > Yes DC/PWM settings were already removed from W83793 and imho not
> > implemented on EHF too.

I haven't used a scope to trace the signal, but a little testing shows
that when I change the w83627ehf from PWM to DC mode, I get a
different response from the fan. The w83627ehf does support PWM and DC
mode. It defaults to PWM mode on my motherboard.

David

