From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jun 2008 14:45:59 +0000
Subject: Re: [lm-sensors] [patch 2.6.26-rc1 v7+] lm75: add new-style driver
Message-Id: <20080608144559.GB6807@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805031933.16057.david-b@pacbell.net>
In-Reply-To: <200805031933.16057.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

* David Brownell <david-b@pacbell.net> [2008-05-03 19:33:15 -0700]:
> More LM75 updates:
> 
>  - Teach the LM75 driver to use new-style driver binding:
> 
>      * Create a second driver struct, using new-style driver binding
>        methods cribbed from the legacy code.
> 
>      * Add a MODULE_DEVICE_TABLE (for "newER-style binding")
> 
>      * The legacy probe logic delegates its work to this new code.
> 
>      * The legacy driver now uses the name "lm75_legacy".
> 
>  - More careful initialization.  Chips are put into 9-bit mode so
>    the current interconversion routines will never fail.
> 
>  - Save the original chip configuration, and restore it on exit.
>    (Among other things, this normally turns off the mode where
>    the chip is constantly sampling ... and thus saves power.)
> 
> So the new-style code should catch all chips that boards declare,
> while the legacy code catches others.  This particular coexistence
> strategy may need some work yet ... legacy modes might best be set
> up explicitly by some tool not unlike "sensors-detect".  (Or else
> completely eradicated...)
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Goes on top of the other stuff.  Addresess one more round of
> comments from Jean.
> 
>  drivers/hwmon/Kconfig |    7 +
>  drivers/hwmon/lm75.c  |  206 ++++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 165 insertions(+), 48 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
