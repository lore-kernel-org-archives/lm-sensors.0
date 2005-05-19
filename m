From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: linux 2.6.6 & w83627hf module & Q-Fan
Message-Id: <20040606055641.GA2807@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516101015.GA19126@nospam.com>
In-Reply-To: <20040516101015.GA19126@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again:

> * rutger@nospam.com <rutger@nospam.com> [2004-05-16 12:10:15 +0200]:
> > The problem is I want to be able to read the CPU temperature without
> > disabling Q-Fan. When I insmod the module now, the fan speeds up to
> > maximum speed without reason.

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-06-06 01:03:30 -0400]:
> But I don't see that behaviour here.  Actually, QFAN doesn't seem to do
> much for me whether it's enabled in BIOS or not.  Anyway, I read through
> the driver again keeping your report in mind... I can't see the problem.

Er, now I see it.  If you pass "init=0" when you modprobe the driver,
then QFAN should continue to work normally.  I already had init=0 in
/etc/modprobe.conf so it's no wonder I didn't see this at first.  Let
me know if this doesn't work for you.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
