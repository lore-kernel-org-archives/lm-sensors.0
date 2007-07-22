From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jul 2007 15:07:09 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] Delete sensors_get_label_and_valid()
Message-Id: <46A3729D.3040600@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070722164816.6b8bdd65@hyperion.delvare>
In-Reply-To: <20070722164816.6b8bdd65@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> We no longer need sensors_get_label_and_valid(), as it does hardly
> more than sensors_get_label(). This allows for some cleanups.
> 
> ---
>  prog/sensors/chips.c         |   24 +++++-------------------
>  prog/sensors/chips.h         |    2 --
>  prog/sensors/chips_generic.c |   31 ++++++++++---------------------
>  3 files changed, 15 insertions(+), 42 deletions(-)
> 

Patch looks good.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
