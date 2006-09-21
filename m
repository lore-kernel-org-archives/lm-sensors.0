From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 20:28:22 +0000
Subject: [lm-sensors] [patch] hwmon/pc87360: update vrm-setting-code to
Message-Id: <20060921222822.76d5eeaf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4512B229.1080901@gmail.com>
In-Reply-To: <4512B229.1080901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> pc87360 currently hardcodes vrm = 90 (2.4 vintage).  Update it to use
> newer code in hwmon-vid which reads cpuid to determine the correct vid.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

Applied, thanks.

-- 
Jean Delvare

