From: Trent Piepho <tpiepho@freescale.com>
Date: Wed, 29 Oct 2008 23:33:19 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <Pine.LNX.4.64.0810291630580.25957@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Oct 2008, Matthew Garrett wrote:
> On Wed, Oct 22, 2008 at 11:48:32AM -0700, Trent Piepho wrote:
>
>> Then you could just call sysfs_show_attribute(hwmondev, "temp2_input", buf) or
>> whatever and get the value in the kernel.  It would would with all drivers
>> without adding a code to them.
>
> Mnf. I'm not convinced general kernel upstream would be enthusiastic.

Any reason for that?

It would solve a lot of problems with trying to use sysfs interfaces from
inside the kernel.  It's not just hwmon where this is an issue, but other
systems have this problem too.  For instance the led subsystem only has a
userspace sysfs interface.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
