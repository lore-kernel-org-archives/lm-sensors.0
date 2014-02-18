From: David Anderson <davea42@gmail.com>
Date: Tue, 18 Feb 2014 00:43:57 +0000
Subject: Re: [lm-sensors] sensors command now hangs [update 2]
Message-Id: <5302ACCD.4050108@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <53027C66.60608@gmail.com>
In-Reply-To: <53027C66.60608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Not using Noveau driver at all here.
         lsmod |grep nov
shows nothing.  I just thought it was interesting that someone
else had a hanging sensors command.

On 02/17/2014 03:17 PM, Guenter Roeck wrote:

> I think I already asked this - in your original e-mail,
> you mentioned that the sensors command 'now hangs', and that
> only started happening some time ago. What did you change -
> if anything - in your system before this started to happen ?

The only change I can think of
was to move from Ubuntu 13.04 to
Ubuntu 13.10.

There are two proprietary nvidia drivers
available from Ubuntu for 13.10, and only  the 319.60 one
works reliably.   319.32 driver gets in trouble
and X stops (kernel keeps running, I can ssh in).
319.60 seems to be reliable.  Not that anyone can
do much with this info. Just saying.
Using nvidia drivers so I can do GPU computation for boinc projects
(Seti@home and Einstein).

DavidA.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
