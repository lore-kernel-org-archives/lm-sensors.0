From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Oct 2012 16:28:48 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriat
Message-Id: <20121031172848.6b14b513@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351624399-22595-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351624399-22595-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Oct 2012 12:13:19 -0700, Guenter Roeck wrote:
> IT8721 and IT8728 support Intel PECI temperature reporting. Each sensor
> can be programmed to display the temperature reported on the PECI interface.
> 
> If configured for Intel PECI, the driver reported the wrong sensor type for
> the respective thermal sensor. Fix the code to correctly report it as
> "Intel PECI (6)".
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I noticed that IT8718 and IT8720 also support PECI, but differently. Does it
> make sense to add those ? That would be a separate patch, though.

If it is supported by the hardware and driver support is can be made
sane, sure we want it.

> v2: "diode connected"  -> diode-connected"
>     Reported type was not necessarily 0 if PECI was selected. Fix description.
>     FEAT_PECI -> FEAT_TEMP_PECI
>     has_peci -> has_temp_peci
>     Introduce flag "peci_mask" to indicate which attributes can be
>     used to report the PECI temperature
>     Reorder code in set_temp_type to check for peci only after checking for
>     other types.
> 
>  Documentation/hwmon/it87 |    3 ++-
>  drivers/hwmon/it87.c     |   20 +++++++++++++++++---
>  2 files changed, 19 insertions(+), 4 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
