From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: robustified adm1021
Message-Id: <Pine.OSF.4.50.0301110634230.16971-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E173681.3050806@paradyne.com>
In-Reply-To: <3E173681.3050806@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Jan 2003, Mark Studebaker wrote:

> actually I meant alarms = chip | fail.
> So the 'sensors' program would say "ALARM" if the read failed -
> no changes to 'sensors' required.

Cannot think of anything to argue there, for a single reader case.
Maybe add retry in the i2c read part, in case chip inserts wait
states the host does not accept. A retry from /proc is not effective for
some seconds.

Is there a reason why limits are read from chip in update? Seems to be
the case with most drivers.

If a measurement goes out of limits and returns chip's ALARM status is
set and cleared on /proc update. With two or more unsynchronised
readers, a reader may miss this update and transient failures.
Maybe I could write a reader daemon to handle chip access and have
libsensors talk with it.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
