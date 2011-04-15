From: Natarajan Gurumoorthy <natg@google.com>
Date: Fri, 15 Apr 2011 01:18:57 +0000
Subject: Re: [lm-sensors] [PATCH v6 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTin6M0R4d+HMovbRwqthSHowUEKFow@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302816996-6345-1-git-send-email-natg@google.com>
	<1302817069-6389-1-git-send-email-natg@google.com>
	<1302821370.26780.585.camel@groeck-laptop>
In-Reply-To: <1302821370.26780.585.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Thu, Apr 14, 2011 at 3:49 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> This is way too complicated. Just return an error if
> request_muxed_region fails, like all other callers of
> request_muxed_region do.
>
Guenter,
      This maybe a little complicated but it is a solution that will
correctly deal with the following scenario:
      Hardware: it8712f
      cpu: Multicore
      kernel: smp
      Modules being loaded during initialization: it8712f_wtd and w83697hf

The problem is one of the cores is halfway through initializing
it8712f_wdt and another core is just starting to run the
"w83697hf_check_wdt" which is going to call "request_region" to
reserve 0x2e 0x2f region. Just after that call on the other core
it8712f_wdt_init calls it8712f_wdt_disable which calls superio_enter
which will call "request_muxed_region" for the exact same region. This
is  guaranteed to fail because as of now w83697hf is one of the many
non compliant drivers who are calling "request_region". The w83697hf
will do the probe and conclude there is no w83697hf chip in the system
and abort rest of the driver initialization. Meanwhile the it8712f_wtd
driver initialization will fail. This will be one of those
intermittent failures that make most kernel device driver writers
prematurely bald :-).

The way I have reworked the driver will survive the above scenario.

Regards
Nat

> Guenter
>
>
>



-- 
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
