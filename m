From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 11 Oct 2005 02:03:32 +0000
Subject: [lm-sensors] lm_sensors in an embedded environment
Message-Id: <20051011000311.GA26894@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <6db3e120510101405xdbb6920wfdf863ba55896477@mail.gmail.com>
In-Reply-To: <6db3e120510101405xdbb6920wfdf863ba55896477@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Robert:

* Robert Teel <rob.teel@gmail.com> [2005-10-10 15:05:17 -0600]:
> I am curious if anyone has tried to use the lm_sensor software in an embedded
> environment.  I would like to get uClinux up on an FPGA or small micro, and run
> lm_sensors on top of that to monitor other rack mount processor boards.

I don't remember anyone mentioning it on this list, sorry.

> In other words, I want to a small embedded linux disto to monitor and alert the
> maintenance personnel when there are chassis over heat / over voltage
> situation.  Has this
> type of thing been done?  I'm not concerned with the temperature of
> the small micro, only the temps of chassis.

Keep in mind, lm_sensors consists of kernel drivers + userspace libs/apps.
If your embedded system is very resource constrained, you could ignore the
userspace bits and access the kernel drivers directly through /proc files
(kernel 2.4.x) or /sys files (kernel 2.6.x).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

