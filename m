From: Andy Poling <poling@econnectix.com>
Date: Fri, 05 Dec 2008 18:34:47 +0000
Subject: [lm-sensors] sensord exits on any error
Message-Id: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We are using lm-sensors in an embedded system, and have noticed that when
errors occur, sensord exits.

We occasionally encounter SMBus collisions which cause transient errors on
SMBus reads by the sensor chip driver.

We modified the most recent w83793 driver (which is much improved in dealing
with SMBus issues) to return cached data for up to 30 seconds in the case of
SMBus errors, and then to return EAGAIN on the sysfs file read if the SMBus
errors persist.

However sensord exits when it gets EAGAIN.  We have patched sensord not to
exit on errors, but instead to log them and continue.  This seems to us to be
the robust behavior for an important system monitoring daemon - if the error
is transient it rides it out, and if it is permanent it complains to get
attention.  It's about a 2-line change in the main loop of sensord.

I'd like to push these patches upstream, but wanted to first see if it is
acceptable to change the behavior of the w83793 driver and sensord in this
way.

-Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
