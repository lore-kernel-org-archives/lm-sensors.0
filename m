From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 13 Aug 2006 08:18:49 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060813101849.a949b387.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> I've setup snapshots at
> 
> http://dl.lm-sensors.org/{lm-sensors,i2c}/snapshots/
> 
> They are checked daily, but only generated if there is an actual
> change. I'm keeping the last 32 snapshots of both sub-projects.
> 
> I've manually initiated snapshots right now, and the scripts are
> running at 06:00-06:10 CET
> 
> We can tune any parameter you like (cron frequency & time, URLs,
> number of snapshots to keep etc).

It looks like the timestamps are not preserved by the snapshot
operation. Can it be improved?

Thanks,
-- 
Jean Delvare

