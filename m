From: Volker Kuhlmann <list0570@paradise.net.nz>
Date: Sun, 25 Jan 2009 02:01:04 +0000
Subject: Re: [lm-sensors] fancontrol init script for ubuntu +
Message-Id: <20090125020104.GD16739@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <000101c97b90$15a03de0$3001a8c0@cw8xp>
In-Reply-To: <000101c97b90$15a03de0$3001a8c0@cw8xp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat 24 Jan 2009 08:59:40 NZDT +1300, Mark Nienberg wrote:

> Does anyone have a similar init script for fancontrol on redhat/centos/fedora?

Yes there is. /etc/init.d/lm_sensors on openSUSE loads the necessary
modules, and also starts the fancontrol script if /etc/fancontrol (the
fancontrol config file) exists. The script may not run directly on
redhat, but if you transplant the few lines of code into
/etc/init.d/skeleton.compat it will run on any chkconfig system.

The files are in these packages:
/etc/init.d/lm_sensors		sensors
/etc/init.d/skeleton.compat	aaa_base
Available from download.opensuse.org.

You can replace /usr/sbin/fancontrol with any script of your choice
(there are several on offer).

HTH,

Volker

-- 
Volker Kuhlmann			is list0570 with the domain in header
http://volker.dnsalias.net/	Please do not CC list postings to me.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
