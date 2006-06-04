From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 15:27:03 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <20060604172703.13f28cb3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> It looks like I've discover yet another feature of the uguru, a bit in
> the fan bank which seemed to be sometimes 1 sometimes 0 actually seems
> to indicate whether a fan is present or not. I'm not 100% sure, but I'm
> starting to see a pattern and sofar it holds in 100% of the cases I
> have. I'll buy myself an extra 3 wire fan and put it on the aux fan
> connectors then I'll know for sure soon enough.
> 
> Which brings me to the question, do we want to export this to userspace
> (I guess we do) and if we do how. May I suggest a readonly boolean
> fan[1-x]_present?

Sure, why not. fan[1-*]_present sounds like a good idea. I wonder how
this works physically. It would be great if other chips could implement
this feature, that would make autoconfig easier for fans. If you
implement this feature in the abituguru driver, just include a patch to
Documentation/hwmon/sysfs-interface describing this new interface file.

-- 
Jean Delvare

