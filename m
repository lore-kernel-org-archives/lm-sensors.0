From: dkirk@physics.syr.edu (Dan Kirkpatrick)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors-2.5.1
Message-Id: <5.1.0.14.2.20011114130438.01c562c8@phy.syr.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Trying to install the rpms for RedHat 6.2 and I get:

>[root@weasel lmsensors]# rpm -ivh kernel-i2c-2.5.1smp-1rh62.i386.rpm
>error: failed dependencies:
>         kernel-smp = 2.2.14-5.0 is needed by kernel-i2c-2.5.1smp-1rh62
>[root@weasel lmsensors]# rpm -q kernel-smp
>kernel-smp-2.2.16-3
>[root@weasel lmsensors]#

The update to vanilla RH 6.2 has updated kernel-smp to a newer version.

Suggestions?

Thanks


===========================Dan Kirkpatrick                   dkirk@physics.syr.edu
Computer Systems Manager
Department of Physics
Syracuse University, Syracuse, NY
http://www.physics.syr.edu/help/    Fax:(315) 443-9103
===========================
