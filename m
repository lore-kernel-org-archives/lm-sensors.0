From: Wei Ni <wni@nvidia.com>
Date: Wed, 16 Oct 2013 03:20:03 +0000
Subject: Re: [lm-sensors] [PATCH v5 0/3] Add power control for lm90
Message-Id: <525E05E3.4040708@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381137940-22608-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1381137940-22608-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi, Jean

Do you have any comments on this series, or will you take them ?

Thanks.
Wei.

On 10/07/2013 05:25 PM, Wei Ni wrote:
> The device lm90 can be controlled by the vcc rail.
> Add function to power on/off the vcc.
> I will update all .dts files referencing this driver to
> match the new requirement in my next series.
> 
> This series is v5, previous version patches are:
> [v4]: http://www.spinics.net/lists/lm-sensors/msg39583.html
> [v3]: http://www.spinics.net/lists/lm-sensors/msg39503.html
> [v2]: http://www.spinics.net/lists/arm-kernel/msg265373.html
> [v1]: http://www.mail-archive.com/linux-tegra@vger.kernel.org/msg12034.html
> 
> Changes from v4:
> 1. set vcc-supply as required property.
> 
> Changes from v3:
> 1. change to use devm_regulator_get, as per discussion in previous patches.
> 2. just return errors when get error from regulator_get(), Mark's new dummy
> regulator can cope with errors.
> 3. add vendor prefix for GMT
> 3. list manufacturer in the binding doc.
> 
> Changes from v2:
> 1. use devm_regulator_get_optional(), as suggested by Mark.
> 2. remove the lm90_power_control(), enable the regulator in the probe()
> directly, so the codes are more clear, as suggested by Alexander and Guenter.
> 3. change the binding documentation, as per Stephen suggestion.
> 4. couple of changes, as per previous review.
> 
> Changes from v1:
> 1. if get regulator failed, we should continue to run probe function,
> not return fail.
> 2. call regulator_put() in error handler and remove function.
> 3. add LM90 DT binding document.
> 
> Wei Ni (3):
>   hwmon: (lm90) Add power control
>   of: add vendor prefix for GMT
>   Documentation: dt: hwmon: add OF document for LM90
> 
>  Documentation/devicetree/bindings/hwmon/lm90.txt   |   44 ++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/hwmon/lm90.c                               |   19 +++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
