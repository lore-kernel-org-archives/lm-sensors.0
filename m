From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] PATCH lm_sensors: add adm9240 example to
Message-Id: <pCcs2cyF.1116316114.0897500.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> This patch adds a sensors.conf example for adm9240 on Intel
> SE440BX-2 mainboard.

I am personally not in favor of adding board-specific configurations to
sensors.conf.eg (although I know there are a couple of them in there
already). I think it's better to distribute separate files for them.
This is what I did recently for my new Gigabyte K8V Ultra-939
motherboard. The configuration file is available from my web site:

http://khali.linux-fr.org/devel/lm-sensors/sensors-Gigabyte-K8V-Ultra-939.conf

I'd suggest you do the same for your motherboard.

Ultimately, we should have an online repository for these files, where
everyone could contribute its configuration file. There was a project to
do so some times ago, but I don't think it actually happened.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
