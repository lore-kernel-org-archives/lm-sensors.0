From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 14 Aug 2005 14:42:54 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050814144301.1e39ded9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just committed the extra code libsensors needed to support the
upcoming hwmon class of Linux 2.6. This was the last thing that was
delaying the 2.9.2 release. It seems to work fine for me. I think we are
ready now.

Additionally, I fixed a couple warnings gcc 3.3 was reporting in i2c.
Shouldn't be a problem, these were minor changes only.

I would like us to release i2c 2.9.2 and lm_sensors 2.9.2 by the end of
August, or early September as the last limit. It's over 4 months since
the previous release already, even if the changelog isn't particularly
long. I'll announce that on our news web page.

So, let's decide that CVS is now is a feature freeze state, and only bug
fixes and documentation updates are accepted until the release.

Thanks,
-- 
Jean Delvare
