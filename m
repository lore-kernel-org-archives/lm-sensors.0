From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 29 Jan 2008 13:09:56 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] adm1031 updates
Message-Id: <20080129130956.GJ29892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-12-02 23:27:27 +0100]:
> Hi all,
> 
> Here comes a 4-piece patchset updating the adm1031 driver:
> * Fix register overwrite in set_fan_div()
> * Various cleanups
> * Get rid of macro-generated wrappers
> * Add individual alarm and fault files
> 
> Alexandre, I would appreciate if you could test these patches. My
> ADM1031 evaluation board behaves weirdly so I can't really use it to
> test the changes I made to the driver.

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
