From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (almost solved)
Message-Id: <20030727233434.568d9d4c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Not bad, but it's not perfect yet. VCCP is bad (I don't know what it
> > is) and +12V is very bad too. The temperatures look correct.
> 
> I know, what I "needed" was CPU temperature. 
> Temperatures are really correct, memory (+2.5), +3.3V, +5.5V too.
> 
> IMHO VCCP looks like "CPU Core (+1.5 V)" from intel Active Monitor
> 
> Nominal Value       1,500
> Current Value       1,447
> Upper Threshold     2,300
> Lower Threshold     0,700.

These guys are crazy. They accept a deviation of over 50% on VCore. We
tolerate 5%...

> value "+12V" isn't in Active Monitor, maybe simply isn't(?) on my
> chip.

I read the datasheet and this one is tricky. The pin that reports +12V
is shared with another function, so depending on how your chip is
hardwired, you have +12V or not. Obviously you don't have it. Our driver
doesn't support this possibility yet. This may also explain your wrong
limits for VCCP, but I'd like you to try some things to be sure.

I suspect you have an old config file at /etc/sensors.conf, with no
section for the adm1025. If I'm right, you should copy the new one
(etc/sensors.conf.eg from lm_sensors-2.8.0) to /etc/sensors.conf, run
"sensors -s" and run "sensors" again. You should at least see VCCP
labeled VCore. Maybe the limits will change too. Please let me know what
they are.

In the meantime, I'll fix our driver to support your configuration. I
have an idea on how to do that, I'll think of it while sleeping.

BTW, is the data at address Ox44 on your I2C bus still the same? ;) Just
curious.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
