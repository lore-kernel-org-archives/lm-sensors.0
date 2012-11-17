From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 17 Nov 2012 16:34:39 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <20121117173439.19953612@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 17 Nov 2012 10:10:31 -0600, Leslie Rhorer wrote:
> OK, this works:
> 
> mail -a "Content-Type: text/plain; charset=UTF-8" -a From:sensor_monitor -s
> "RAID-Server Sensor Event Notification" ...
> 
> Would you guys be interested in me posting the script for future reference?

Sure, why not. Our reference script is:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/daemon/healthd.sh
but it assumes the chip and driver report alarms on out-of-bounds
conditions.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
