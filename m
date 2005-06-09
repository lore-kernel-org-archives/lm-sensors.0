From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Jun 2005 10:23:28 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <QsFwGIoa.1118304828.1289040.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

> It does, over time.  I can see the sensor files moving to be class
> attributes instead of device attributes.  But we need to do that so we
> don't break all of the userspace code at the same time :)

I am not sure what attributes are typically found in classes (pointers to
existing implementations would be welcome), but please keep in mind that
no single sysfs file will ever be found in all hwmon clients. The sysfs
interface we defined is about how the files should be named for present
features, but no part of this interface is required for any given driver
(this wouldn't make sense).

Thanks,
--
Jean Delvare
