From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Jun 2009 19:13:44 +0000
Subject: [lm-sensors] lm-sensors 3.1.1 has been released!
Message-Id: <20090621211344.6bfa1a2e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.1.1 as planned. This is a maintenance
release with many small bug fixes compared to 3.1.0. All users of
lm-sensors 3.1.0 are encouraged to upgrade.

Most important changes are:
* Multiple configuration file support now works regardless of the
  filesystem in use.
* sensord received a lot of cleanups (thanks Andre!)
* New chips known by sensors-detect, as usual.

Phil, please copy the new release to your mirror when you get some time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
