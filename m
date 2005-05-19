From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: lmsensors2 cvs broken
Message-Id: <Pine.OSF.4.50.0301142050230.11865-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301141804.48861.m.c.p@gmx.de>
In-Reply-To: <200301141804.48861.m.c.p@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Jan 2003, Marc-Christian Petersen wrote:
>
> root@codeman:[/usr/src/SENSORS/cvs/lm_sensors2] # mkpatch/mkpatch.pl .
> /usr/src/linux > /tmp/sensors-patch
> Automatic patch generation for `drivers/i2c/i2c-core.c' failed.
> See our home page http://www.lm-sensors.nu for assistance! at
> mkpatch/mkpatch.pl line 1509.
>
> i2c cvs is applied first, sure. Applied to kernel 2.4.20.

We are in process of dropping 2.2 support, and backporting features from
2.5 tree to CVS. A lot of this is already in i2c cvs.
You should get functionally equal i2c code doing

 cvs up -r LATEST-PRE-2-4-9-KERNEL

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
