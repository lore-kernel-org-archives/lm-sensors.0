From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 04 Mar 2012 06:42:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] sensord: Fix memory leaks revealed by valgrind
Message-Id: <20120304064219.GA32671@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120303222536.10db6cae@endymion.delvare>
In-Reply-To: <20120303222536.10db6cae@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 03, 2012 at 04:25:36PM -0500, Jean Delvare wrote:
> The leak in daemonize() is harmless, we're about to exit anyway. Fix
> it still to make valgrind happy.
> 
> The leak in do_features() is real, as the function is called
> periodically by the daemon, for all actions. If the intervals at set
> low and the system has many sensors, the leak could be significant,
> maybe 150 kB/day.
> ---
>  prog/sensord/sense.c   |   22 +++++++++++++---------
>  prog/sensord/sensord.c |    6 +++++-
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
Nice catch series looks good.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
