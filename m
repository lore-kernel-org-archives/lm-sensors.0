From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jul 2007 15:09:28 +0000
Subject: Re: [lm-sensors] [PATCh 4/4] Speed up sensors_get_ignored()
Message-Id: <46A37328.5000106@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070722165337.20c91514@hyperion.delvare>
In-Reply-To: <20070722165337.20c91514@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Now that sensors_get_ignored() is an internal function, we can change
> its prototype to suit our needs better.
> 
> * Pass the chip name by address.
> * Pass the feature directly rather than its number.
> * Switch to a sane convention for the returned value.
> * Don't check for errors that can't happen.
> 
> ---
>  lib/access.c |   41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 

And once more the patch looks good.

Regards,

Hans


p.s.

Let me know when this all lands, then I'll run another round of tests.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
