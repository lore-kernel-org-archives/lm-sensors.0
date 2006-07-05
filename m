From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Jul 2006 07:59:06 +0000
Subject: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS,
Message-Id: <20060705095906.bf61fef8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060703124823.GA18821@khazad-dum.debian.net>
	<20060704075950.GA13073@elf.ucw.cz>
	<20060704162346.GE9447@khazad-dum.debian.net>
	<20060704235717.GD11872@elf.ucw.cz>
In-Reply-To: <20060704235717.GD11872@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@suse.cz>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>, Michael Hanselmann <linux-kernel@hansmi.ch>, hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Stelian Pop <stelian@popies.net>, vojtech@suse.cz

(Does this conversation really need to happen on 3 different mailing
lists at once?)

> > 3. Control of accelerometer parameters:
> >    3a. Report of accelerometer type (hdaps, ams, etc) and other metadata
> >        (name, location, what it is measuring (system accel, hd-bay 
> >        accel...))
> 
> Well, if your system is accelerating at different speed than hd-bay,
> then your machine is either _way_ too big, or you are in bad trouble.

Not necessarily. If the system is spinning, each point has its own
acceleration vector. Having two accelerometers in a system would be a
convenient way to detect that kind of movement, and I wouldn't be
surprised to see it happen.

-- 
Jean Delvare

