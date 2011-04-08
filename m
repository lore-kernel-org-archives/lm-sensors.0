From: Natarajan Gurumoorthy <natg@google.com>
Date: Fri, 08 Apr 2011 04:58:05 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/3] Make all it87 drivers SMP safe.
Message-Id: <BANLkTimsB9EoOVq1fojcazU4GCFyqPmF=w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302211560-8052-1-git-send-email-natg@google.com>
	<20110408003742.GD3942@ericsson.com>
In-Reply-To: <20110408003742.GD3942@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

Guenter,
      Comments are below

On Thu, Apr 7, 2011 at 5:37 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
>
> Did you consider naming this file include/linux/it87.h as suggested ?
> I thought that was a goodd idea.
>
This does seem to be a good idea. I had some other thoughts about
where to place the
it87_lock.c file. One thought was to move the lock into the
drivers/mfd directory and
completely decouple the lock from the watchdog or the hwmon
directories. The mfd/Kconfig
would contain the IT87_LOCK.

> When you send out new versions of your patch set, it would be prudent
> to list the patch version, as well as the changes made compared to previous
I am new at this. Exactly where do you list the patch version. I put
v2 in the subject line.
The only difference between the 2 patch sets was that each of the patches has a
more verbose body section explaining the contents of the patch and
each of the sub patch
Subject line reflected what was happening in that sub patch. I also
made sure I had the
"In-Reply-To" entry in the patches.

Where in the patch do you discuss the changes made with respect to the
previous patch.

When I send out the next set of patches do I have to send out the
entire patch set marked as v3.

> versions of your patch. See Documents/SubmittingPatches, rule #2.
>
> Thanks,
> Guenter



--
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
