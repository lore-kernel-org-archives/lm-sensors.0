From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Sep 2006 10:21:24 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060901122124.da4e7079.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Back to the mailing-list, as I doubt you replied to me privately on
purpose?

> Patch attached.

Applied, with two minor edits:

* Moved the "Register sysfs hooks" comment back to where it belongs.
* In w83627ehf_detach_client, call hwmon_device_unregister before
w83627ehf_device_remove_files. It probably doesn't matter much as
everything ends up being removed, but it looks less confusing for
userspace that way.

Thanks,
-- 
Jean Delvare

