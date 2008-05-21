From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 May 2008 09:12:14 +0000
Subject: [lm-sensors] lm-sensors snapshots
Message-Id: <20080521111214.0e4bf685@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

I would like to change the locations where the lm-sensors nightly
snapshots are stored. Right now we have:
http://dl.lm-sensors.org/lm-sensors/snapshots/ for lm-sensors 2.10.x snapshots
http://dl.lm-sensors.org/lm-sensors-3/snapshots/ for lm-sensors 3.0.x snapshots
http://dl.lm-sensors.org/lm-sensors/releases/ for all releases

I think it's a bit confusing to have the lm-sensors 3.0.x releases in
one place and the snapshots in another. As lm-sensors 3 has become our
stable branch and version 2 is a legacy branch, I'd rather put the
3.0.x snapshots in the "standard" snapshots directory and put the
2.10.x ones in a subdirectory. Could look like:

http://dl.lm-sensors.org/lm-sensors/snapshots/ for lm-sensors 3.0.x snapshots
http://dl.lm-sensors.org/lm-sensors/snapshots/legacy/ for lm-sensors 2.10.x snapshots
http://dl.lm-sensors.org/lm-sensors/releases/ for all releases

Objections anyone?

I could move the files myself but I don't know where are the scripts
which generate the snapshots, so your help is required.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
