From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Jun 2011 18:57:43 +0000
Subject: [lm-sensors] asus_atk0110 and suspend-to-disk
Message-Id: <20110617205743.28aaf44a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

Since a few days now, my wife has a new system based on an Asus P5QL Pro
motherboard, which uses your asus_atk0110 driver. She noticed that,
with this new board, CPU fan speed bumps to maximum when resuming from
suspend-to-disk (hibernation.) In the BIOS I have set the CPU fan speed
control to silent mode, and apparently system-to-disk loses the
setting, so the fan goes to full speed on resume. Very annoying.

Have you ever heard of this problem?

I understand that the asus_atk0110 driver only reads from the
monitoring device and doesn't attempt to configure it, so I very much
doubt it is related to the problem in any way. But do you think there is any way to
save and restore the settings at suspend/resume through the ATK0110
interface so that they aren't lost?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
