From: ploujj@gmail.com (Michael P)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <18e5751305032721157566f6c5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325220626.4fdc613c.khali@linux-fr.org>
In-Reply-To: <20050325220626.4fdc613c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

By the way, is there a reason why I can't find my ticket by its number?
http://www2.lm-sensors.nu/~lm78/support2.html?search41&sort=index
leads to an error page with "Sorry, nothing found. Try searching for
something less specific, or 'list all'"

...

I just understood the syntax of /proc/ioports and I see that the
02f8-02ff range is taken by the serial driver or something.
This kind of makes sense after looking at the mobo block diagram from gigabyte:

page 7 of:
http://america.giga-byte.com/MotherBoard/FileList/Manual/manual_k8nxpsli_e.pdf

My IT8712F chip controls the COM port.

o_O

Thanks.
