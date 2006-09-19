From: sam@rfc1149.net (Samuel Tardieu)
Date: Tue, 19 Sep 2006 13:11:17 +0000
Subject: [lm-sensors] [RFC-patch 0/3] SuperIO locks coordinator
Message-Id: <87k6402e8a.fsf_-_@willow.rfc1149.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru> <4508FF2F.5020504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org

>>>>> "Jim" = Jim Cromie <jim.cromie at gmail.com> writes:

Jim> The module does *not* guarantee anything, it offers no protection
Jim> against rogue (existing) modules which dont use the superio-locks
Jim> coordinator.  (is anti-rogue protection even possible?  Perhaps,
Jim> IFF modules reserve the 2 superio addresses - semi-rogue?)

I don't think we can prevent bad things from happening if someone
doesn't play the game and uses the device using IO ports directly on a
SMP.

  Sam
-- 
Samuel Tardieu -- sam at rfc1149.net -- http://www.rfc1149.net/


