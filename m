From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: GL520SM driver
Message-Id: <20050127212350.6ee1ee50.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
In-Reply-To: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Maarten,

> It wasn't me, but as that was a while ago and i couldn't find his
> code, i ported this from 2.4 looking how the gl518sm driver was
> ported.

Wow, that's odd. I have a very bad memory, maybe I don't remember
correctly. Anyway, as long as we end up with a valid driver, alright. We
just try to avoid concurrent ports. We already lack resources to port
the drivers and review the new code, so let's not do it twice for each
driver if possible.

> Yes, i think it is automatically configured right. Still, i find
> strange that if i set two_temps to one, the temp sensor was switching
> between two values, and if i set it to zero, the voltage sensors
> switched between at least three values. Is there any clarification for
> this?

This isn't surprising. Voltage measurement doesn't work as temperature
measurement (and there are also different ways to measure the
temperature). When you change the configuation bit, I expect the chip to
switch to a different circuitery, and this explains why you get a
different number of values (one series of which is additionally wrong,
obviously).

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
