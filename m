From: nsx@rm-f.net (john)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: as99127f chipset calculations
Message-Id: <20020624165647.A11309@your default hostname>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On the computer I've tested the lm_sensors package on, I have an asus a7a266
motherboard which has the as99127f hardware sensor chip.  Many of the
calculations in the example sensors.conf file provided are obviously
inaccurate.  The two which I have seemingly been able to improve are the cpu
temperature and cpu fan speed.  As simple as these calculations are, they
definitely coincide with the bios's readings, throughout a broader range
of temperatures and fan rpms.

compute fan1 @ - 3000 , @ + 3000
compute temp2 @ + 30 , @ - 30

Once again, just as you state in the example conf, it's guess work, but this
sure does seem to be a lot more accurate than the computations that were
thrown in there.  Hope this helps.

					-- John
