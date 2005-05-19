From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: help: sensors-detect
Message-Id: <20030724001913.GA13286@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F17172F.4050603@mindspring.com>
In-Reply-To: <3F17172F.4050603@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-07-18 09:29:40 +0200]:
> 
> It says you don't have any supported device. You did not tell us but I
> guess you are using lm_sensors 2.7.0. You should wait for Red Hat to
> package our new 2.8.0 release (could take some weeks) which has support
> for many more devices. When it's ready, update your old package using
> the new one and run sensors-detect again.

You'll be waiting a long time - RedHat still distributes based on 2.6.5.

I've been considering building RPMs, but they would have to be hosted
on the sensors site.  (Phil?)  I've built RPMs before for the use
of myself and my employer... but I need to learn how to sign them
before putting them up for general redistribution.

From recent announcements, it looks like RedHat wants to push packaging
responsibilities upstream anyway.

Regards,

-- 
Mark "must learn not to mention it before actually doing it" Hoffman
mhoffman@lightlink.com
