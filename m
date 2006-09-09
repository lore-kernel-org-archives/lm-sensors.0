From: sam@rfc1149.net (Samuel Tardieu)
Date: Sat, 09 Sep 2006 18:35:19 +0000
Subject: [lm-sensors] [PATCH] watchdog: add support for w83697hg chip
Message-Id: <2006-09-09-20-35-21+trackit+sam@rfc1149.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru>
In-Reply-To: <20060909220256.d4486a4f.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

>>>>> "Sergey" = Sergey Vlasov <vsu at altlinux.ru> writes:

Sergey> Actually the situation is worse.  This driver pokes at SuperIO
Sergey> configuration registers, which are shared by all logical
Sergey> devices of the SuperIO chip.

Exactly (this is something we discussed on a French
mailing-list). However, in our case (dedibox.fr hardware), that was
not an issue because we only use single-core boards, no other parts
of the SuperIO are used at the same time and every existing code sets
the logical device number to use each time it needs to access it.

Also note that this situation exists with any Winbond SuperIO already
in the kernel, this is not specific to this one.

A SuperIO subsystem would be the cleanest solution IMO, even if at the
beginning it only provides lock/unlock functionality. Then it could be
extended as to factor common operation (selecting a logical device and
reading/writing registers) and to allow access to the device from
userland.

On an unrelated subject, the whole watchdog subsystem would benefit
from a refactoring; the code looking for a 'V' in a write() operation
is present at least 35 times.

  Sam
-- 
Samuel Tardieu -- sam at rfc1149.net -- http://www.rfc1149.net/


