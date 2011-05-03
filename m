From: Steve Sakoman <sakoman@gmail.com>
Date: Tue, 03 May 2011 15:14:10 +0000
Subject: Re: [lm-sensors] [PATCH 0/2 v5] twl4030-madc driver
Message-Id: <BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298986926-31180-1-git-send-email-j-keerthy@ti.com>
	<20110302101512.GC16181@sortiz-mobl>
In-Reply-To: <20110302101512.GC16181@sortiz-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Mar 2, 2011 at 2:15 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Keerthy,
>
> On Tue, Mar 01, 2011 at 07:12:06PM +0530, Keerthy wrote:
>> MADC(Monitoring ADC) driver enables monitoring analog signals using
>> analog-to-digital conversion (ADC) on the input source.
>> The previous discussion concluded in keeping the generic ADC
>> functionality and the hwmon separate. The discussion can be found here:
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html
> Thanks a lot, I applied those 2 patches.

I'm attempting to use this drive on the Overo platform with 2.6.39-rc5.

Other than enabling the module with CONFIG_SENSORS_TWL4030_MADC=m are
there any board file modifications required other than the below?

I have setup the platform data for the twl4030 madc driver:

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 112dfc9..05dd3eb 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -637,10 +637,15 @@ static struct twl4030_codec_data overo_codec_data = {
 	.audio = &overo_audio_data,
 };

+static struct twl4030_madc_platform_data overo_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
+	.madc		= &overo_madc_data,
 	.usb		= &overo_usb_data,
 	.codec		= &overo_codec_data,
 	.vmmc1		= &overo_vmmc1,

However, I am not seeing the sysfs entry created:

# modprobe twl4030-madc-hwmon
twl4030_madc_hwmon_init entry

# lsmod
Module                  Size  Used by
twl4030_madc_hwmon      2594  0
ipv6                  224256  16
libertas_sdio          14867  0
libertas               92429  1 libertas_sdio
cfg80211              144256  1 libertas
lib80211                5027  1 libertas
firmware_class          5859  2 libertas_sdio,libertas

# ls /sys/class/hwmon/
#

I added a couple of printk's to the driver at the entry points of init
and probe, and as you can see above the init message is printed, but
not the probe.

Am I missing something really obvious here?

Steve

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
