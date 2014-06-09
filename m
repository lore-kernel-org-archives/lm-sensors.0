From: Doug Anderson <dianders@chromium.org>
Date: Mon, 09 Jun 2014 20:45:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ntc_thermistor) Fix OF device ID mapping
Message-Id: <CAD=FV=UmX2th=SQMN4XtYxFs=FK8v_yiWYy_=+3UxVjvj12B0A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

On Wed, May 21, 2014 at 5:58 AM, Jean Delvare <jdelvare@suse.de> wrote:
> The mapping from OF device IDs to platform device IDs is wrong.
> TYPE_NCPXXWB473 is 0, TYPE_NCPXXWL333 is 1, so
> ntc_thermistor_id[TYPE_NCPXXWB473] is { "ncp15wb473", TYPE_NCPXXWB473 }
> while
> ntc_thermistor_id[TYPE_NCPXXWL333] is { "ncp18wb473", TYPE_NCPXXWB473 }.
>
> So the name is wrong for all but the "ntc,ncp15wb473" entry, and the
> type is wrong for the "ntc,ncp15wl333" entry.
>
> So map the entries by index, it is neither elegant nor robust but at
> least it is correct.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 9e8269de hwmon: (ntc_thermistor) Add DT with IIO support to NTC thermistor driver
> Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
> Again this is a candidate for stable, but maybe we don't really care
> because the only in-tree user is for the only device for which the
> mapping wasn't broken.
>
>  drivers/hwmon/ntc_thermistor.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

You caught me on vacation and then this was lost in the backlog.  I
see it's already applied, but better late than never, I guess.

We only have a "ncp15wb473" in our systems, which is probably why this
was never caught.

Thank you for fixing, though!

-Doug

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
