From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 04 Jul 2007 14:18:01 +0000
Subject: [lm-sensors] PATCH: hwmon-fscher-individual-alarm-files-v2.patch
Message-Id: <468BAC19.8070003@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468A3045.1010307@hhs.nl>
In-Reply-To: <468A3045.1010307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

This is version 2 (non incremental) of the patch adding individual alarm and
fault files to the fscher driver. This driver uses the status registers for
the alarms instead of the global event register, allowing seperate alarms
for all sensors. Also it makes the _alarm files r/w, writing 0 to them
resets the alarm flag (this is not done automatically be the hardware once an
alarm condition is cleared).

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
