From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Jun 2009 11:33:02 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/7] sensord: Some cleanups,
Message-Id: <20090608133302.21b427ac@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160001.GA17530@ubuntu>
In-Reply-To: <20090511160001.GA17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Mon, 11 May 2009 18:00:01 +0200, Andre Prendel wrote:
> Hello Jean,
> 
> here is the updated patch series according to your notes. Thanks for
> your careful review.
> 
> There is much work left. I will go on with cleanups in further patches
> (see the note in patch 1/7). I've dropped patch 2/8.
> 
> You can see the changes in the changelog of every patch under "Changes
> in v2".
> 
> Thanks,
> Andre
> ---
>  args.c    |  177 +++++++++++++++++++++-----------------------------------------
>  args.h    |   30 ++++++++++

While you have committed your patches by now, this file is nowhere to
be seen in SVN. I suspect you forgot to "svn add" the file? Please do
now, so that sensord builds again.

>  lib.c     |   74 +++++++++++++------------
>  rrd.c     |  110 +++++++++++++++++++-------------------
>  sense.c   |    6 +-
>  sensord.c |  103 +++++++++++++++++++++---------------
>  sensord.h |   18 ------
>  7 files changed, 246 insertions(+), 272 deletions(-)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
