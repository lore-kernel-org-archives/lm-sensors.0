From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [michaelpiest@gmx.de: Sensors Problem]
Message-Id: <20040821093551.2632e562.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i use sensors on my Asus A7V Motherboard.
> Everything works fine, but the Fan3 (Power-Fan) does not show rpm
> until i ran "mbmon" 2 or more times.
> I can't find an answer with google or in any forum/mailinglist.
> 
> The divisor is set to 4 and works correct (after running mbmon...).
> 
> Hope, you can help me :)

No immediate idea. You may look at mbmon's code and see what it is doing
we are not. However, the fact that you need to run it "twice or more"
isn't encouraging, since it makes it sound like random is involved.

Asus refused to release a datasheet for the AS99127F chip, which your
motherboard is using. This prevent us from handling it properly in a few
cases. We will not be spending time on undocumented chips anymore.

Next time you buy a motherboard, make sure it doesn't rely on
undocumented hardware monitoring chips. Same advice applies to me as
well, since I also have an AS99127F on my system.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
