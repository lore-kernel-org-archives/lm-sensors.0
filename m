From: floeff@arcor.de (Florian Effenberger)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <41D91C58.8020302@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Yes, this is a bug, that will affect almost all users. My bad :(

No problem, thanks for confirming it so fast. :-)

> Which chip is this?

via686a-isa-0c00 (according to sensors). The modules I load are

	i2c-viapro
	i2c-isa
	via686a

> Did you run "sensors -s"?

Yes.

> Does the alarm wear off if you run "sensors" again?

No, it stays at this very high RPM value.

> You might simply need to set the min RPM count through the
> /etc/sensors.conf file and run "sensors -s" afterwards.

I have not changed sensors.conf for quite a while and the problems 
started to appear in 2.9.0. In 2.8.x, everything was fine.

I have checked on another system that had the some compile problems I 
fixed the same way (copying *.h to /usr/local/include/linux). It has 
w83627hf-isa-0290 as chip and also some weird values:

fan1:     5720 RPM  (min = 21093 RPM, div = 2)
fan2:        0 RPM  (min = 84375 RPM, div = 2)

What could that be? Maybe I shall erase the sensors.conf and let it 
re-install it?

Thanks
Florian
