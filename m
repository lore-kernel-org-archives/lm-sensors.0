From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Mar 2012 08:03:20 +0000
Subject: [lm-sensors] lm-sensors 3.3.2 has been released!
Message-Id: <20120314090320.44d89eac@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.3.2, almost two months behind the original
schedule, sorry about that.

Most important changes are:
* Support for many subfeatures implemented by new hwmon drivers.
* Fix to support a sysfs implementation change in upcoming kernels.
* Better printing of power sensors in sensors.
* Memory leaks fixed in sensord.
* New chips known by sensors-detect, as usual.

See CHANGES for the details.

Phil, please copy the new release to your mirror as your time permits.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
