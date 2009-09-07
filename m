From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Sep 2009 14:31:13 +0000
Subject: Re: [lm-sensors] asus_atk0110 maintainer
Message-Id: <20090907163113.29fa39f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090907154042.0e0c9aad@hyperion.delvare>
In-Reply-To: <20090907154042.0e0c9aad@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Sep 2009 15:48:25 +0200, Luca Tettamanti wrote:
> On Mon, Sep 07, 2009 at 03:40:42PM +0200, Jean Delvare wrote:
> > Hi Luca,
> > 
> > It was pointed out to me recently that you are not listed in
> > MAINTAINERS for the asus_atk0110 driver. As I expect this driver to get
> > a wider testing coverage in the next few weeks, I think it would be
> > better if users knew who to report their problems to. Could you please
> > send a patch adding an entry in MAINTAINERS for the ATK0110?
> 
> Add myself as asus_atk0110 maintainer.
> 
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> ---
> 
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8dca9d8..2ccc21c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -897,6 +897,12 @@ W:	http://wireless.kernel.org/en/users/Drivers/ar9170
>  S:	Maintained
>  F:	drivers/net/wireless/ath/ar9170/
>  
> +ATK0110 HWMON DRIVER
> +M:	Luca Tettamanti <kronos.it@gmail.com>
> +L:	lm-sensors@lm-sensors.org
> +S:	Maintained
> +F:	drivers/hwmon/asus_atk0110.c
> +
>  ATI_REMOTE2 DRIVER
>  M:	Ville Syrjala <syrjala@sci.fi>
>  S:	Maintained

Excellent, thanks for the quick reply! Applied.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
