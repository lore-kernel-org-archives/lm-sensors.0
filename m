From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Dec 2005 20:07:24 +0000
Subject: [lm-sensors] Gigabyte GA-K8NF-9 sensors.conf?
Message-Id: <20051209210724.7cd50f12.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051208234144.GG890@paradise.net.nz>
In-Reply-To: <20051208234144.GG890@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

> Has anyone managed to produce a functional sensors.conf for a Gigabyte
> GA-K8NF-9 board and wouldn't mind sharing it? I'm not sure about some of
> the details.

We did not receive any configuration file, but Fred Riedel and Sam
Elstob (CC'd) have a similar board and may have some information to
share.

> E.g. Vcore1 is 1.42V, Vcore2 2.61V. Is this reasonable for an AMD64 CPU?

1.42V is reasonable as Vcore (most AMD64 CPUs seem to use +1.4V nominal
at full frequency). If the CPU supports "Cool 'n Quiet" it can scale
its voltage down to +1.1V or so. The exact values are model-dependant.

2.61V is not Vcore2 (AMD64 CPUs are not dual-planed AFAIK) but more
likely Vdimm (the memory modules voltage).

> Where is the M/B temp sensor located? I don't believe its 25?C when the
> room temperature is 27?C.

I have an AMD64 motherboard from Gigabyte which has its temperature
stuck at 25 degrees C. I asked Gigabyte about it and they confirmed the
lack of actual motherboard temperature sensor. 25 degrees C being the
equilibrium temperature of most thermistor-based temperature
measurements, I think they soldered two resistors of equal value instead
of one thermistor and one resistor. No idea why they did do that, as
the saved expense is certainly neglectible.

> The CPU temp is about 2?C to low when compared with BIOS.

Mosty likely because your BIOS idle state is less idle that your Linux
idle state. See our FAQ:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e12

Hope that helps,
-- 
Jean Delvare

