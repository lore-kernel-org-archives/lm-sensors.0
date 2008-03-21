From: Grant Coady <grant_lkml@dodo.com.au>
Date: Fri, 21 Mar 2008 01:40:41 +0000
Subject: Re: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions,
Message-Id: <dq36u31toq9a5fumhptjn95s43rr6ej6oj@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080304145440.GE2892@jupiter.solarsys.private>
In-Reply-To: <20080304145440.GE2892@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 20 Mar 2008 09:32:38 -0400, "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:

>Hi all:
>
> adm1026.c |   22 ++++++++++++++--------
> adm1029.c |   30 +++++++++++++++++++-----------
> adm1031.c |   20 +++++++++++++++-----
> adm9240.c |   20 ++++++++++++++------
> adt7470.c |   40 ++++++++++++++++++++++++----------------
> adt7473.c |   54 +++++++++++++++++++++++++++++++-----------------------
> asb100.c  |   16 ++++++++++++----
> 7 files changed, 129 insertions(+), 73 deletions(-)
>
>commit 3c798b55145f42725c54d64ac7d69062a5d62bad
>Author: Mark M. Hoffman <mhoffman@lightlink.com>
>Date:   Mon Mar 3 23:35:52 2008 -0500
>
>    hwmon: fix common race conditions, batch 1
>    
>    Most hwmon drivers have one or more race conditions that could cause the driver
>    to display incorrect data; in the absolute worst case, these races could allow
>    divide-by-zero/OOPS.  The most common of these involves a race between setting
>    a fan divider and displaying the fan data (RPMs).  This patch fixes these race
>    conditions by taking the update lock (or equivalent) as necessary.
>    
>    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

adm9240 tested on 2.6.25-rc6 and lm-sensors 3.0.0, no problems noticed, 
no observed breakage ;)  I doubt there's a possible div0/oops involved.

Grant.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
