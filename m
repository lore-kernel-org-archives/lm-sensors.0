From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 15:49:35 +0000
Subject: Re: [lm-sensors] Better generic print fault handling
Message-Id: <20070707174935.7d4e56e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Jul 2007 23:03:12 +0200 (CEST), lm-sensors-notify@lm-sensors.org wrote:
>       Author: jwrdegoede
>         Date: Thu Jul  5 23:03:06 2007
> New Revision: 4559
>    Changeset: http://lm-sensors.org/changeset/4559
> 
> Modified:
>    lm-sensors/branches/lm-sensors-3.0.0/prog/sensors/chips.c
>    lm-sensors/branches/lm-sensors-3.0.0/prog/sensors/chips_generic.c
> 
> Log:
> Better generic print fault handling

OK, it works (tested with an ADM1032 in both degrees C and F) but I
can't say I find using HUGE_VAL particularly aesthetic. I have to admit
that this was certainly the quickest way to implement proper
temperature fault handling without changing the temp_print_info()
signature. But OTOH, temp_print_info() is only called once, so changing
its signature wouldn't be a big problem.

I guess that the main problem here is that we have an artificial split
of temp_print_info() outside of the generic temperature printing
function, while we shouldn't. This explains in part why the this
generic temperature printing function doesn't look quite good.

This is something that can be fixed later on though, so I won't be
working on it now. So I've created a new milestone in trac (3.0.1), and
I've created ticket #2231 for this.

Oh, and I also created new components "sensors" and "libsensors" for
trac tickets. The component list we had so far didn't make much sense
to me, I never know what to choose.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
