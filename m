From: Jakub.Narebski@fuw.edu.pl (Jakub Narebski)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket #780, SysV compliant init script
Message-Id: <Pine.LNX.4.33.0201051711560.31857-100000@front.fuw.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 5 Jan 2002, Mark D. Studebaker wrote:

> On ticket 780, thanks for the contribution.
> Do you have a proposal for where we should put it?

In the sources directory? In progs probably. One should install it into
/etc/rc.d/init.d/

> Also, can you give us a little more background
> on the need for 'SySV compliant init scripts',
> I'm not really familiar with them.

You put it into /etc/rc.d/init.d/, you make symlink (probably using
chkconfig, ntsysv, tksysv or serviceconf program) named S95xxx and K05xxx
into /etc/rc#.d (where # is the number of runlevel), and sensors service
(which starts lm_sensors modules, runs sensors -s and starts sensord)
will be started automatically at startup/reboot and stopped at shutdown.
One could also start/stop service manually.

> Also is there any problem with calling it 'sensors'
> when we already have a 'sensors' program?

No, the /etc/rc.d/init.d/ is not [normally] in path.

-- 
Jakub Nar?bski
   Poland
