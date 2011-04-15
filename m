From: Natarajan Gurumoorthy <natg@google.com>
Date: Fri, 15 Apr 2011 03:14:32 +0000
Subject: Re: [lm-sensors] [PATCH v6 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTi=t+AgRU47DhKoGOJ2mTa6AVfaPVw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302816996-6345-1-git-send-email-natg@google.com>
	<1302817069-6389-1-git-send-email-natg@google.com>
	<1302821370.26780.585.camel@groeck-laptop>
	<BANLkTin6M0R4d+HMovbRwqthSHowUEKFow@mail.gmail.com>
	<20110415024005.GA21642@ericsson.com>
In-Reply-To: <20110415024005.GA21642@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Thu, Apr 14, 2011 at 7:40 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> Unless I am missing something, the problem is that there is another driver
> calling request_region() instead of request_muxed_region().
>
> w83697hf_check_wdt() (and other drivers doing the same) should call
> request_muxed_region(). Otherwise, the same problem could happen with the
> caller(s) of request_region() - those calls could fail as well.
> Plus, other callers of request_muxed_reason() not implementing
> your retry code could end up with the same problem, ie with spurious failures.
>
> I think we will have to find a solution which does not require retries
> when calling request_muxed_region(). On the other side, others know
> this code much better than I do, so maybe someone has a better solution.
>
Guenter,
    Your conclusion is on the money. request_muxed_region will fail if
someone else called request_region for the same region. The knife cuts
both ways and reguest_region will fail when a request_muxed_region
calll has been made for the same zone.  I am not sure what happens
when the second driver calls request_muxed_region for only part of the
region that has been reserved by another driver. This is of course one
of the problems. The other problem is that there are drivers which
don't call either of those 2 interfaces and just go ahead and clobber
the 0x2e 0x2f zone because they think they own all of it. I created a
list drivers in hwmon and watchdog directories that need to be fixed
in one of my earlier emails. John Delvare replied that are other
drivers in parport that all need fixing. I got started on this because
we use 2 different it87 drivers (hwmon/it87.c and
watchdog/it8712f_wdt.c) concurrently and had to solve this problem.

Regards
Nat


> Thanks,
> Guenter
>



-- 
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
