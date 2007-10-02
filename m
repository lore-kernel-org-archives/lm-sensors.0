From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Oct 2007 10:50:55 +0000
Subject: Re: [lm-sensors] [patch 1/1] de-macro w83627hf
Message-Id: <20071002125055.22e8e8c4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
In-Reply-To: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Sun, 30 Sep 2007 12:38:36 -0600, Jim Cromie wrote:
> this patch to drivers/hwmon/w83627hf converts many sysfs items from DEVICE_ATTRs
> to SENSOR_DEVICE_ATTRs, and replaces macros which expand to define redundant
> callbacks, with callbacks which use the SENSOR_DEV.nr to know what to do.
> 
> Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
> ---
> $ diffstat hwmon-w83627hf-demacro.patch
>  w83627hf.c |  695 +++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 335 insertions(+), 360 deletions(-)
> 
> hi Jean,
> I have
> - avoided cosmetic changes
> - left sysfs-beep macros, since simple change didnt shrink driver
> - hoisted most nr-1 offset calcs into declarations
>     I left a few where the callback functions operated differently
> based upon the nr
> - changed callback names to match common naming convention in hwmon/*.c
>     I thought this appropriate, since _reg(s)?_ in the names indicated
> a wrapper/adaptor
>     If I were to keep one of the names in a multi-call-chain, which one ?
> 
> Im attaching, via webmail.  If this gets mangled, Ill resend from
> pop/thunderbird.

Patch is not mangled, however it doesn't apply on top of Mark's tree.
Please make sure that you have the following patches applied:
* hwmon: Allow writing of negative trigger temperatures
* hwmon: Don't export thermistor beta
* hwmon: Convert from class_device to device

You can fetch these patches from:
http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=testing

Once you send a patch that I can apply on top of Mark's tree, I'll
review it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
