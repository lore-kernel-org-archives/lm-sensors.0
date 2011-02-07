From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 14:39:56 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207143956.GA1682@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 07, 2011 at 02:40:00AM -0500, Jean Delvare wrote:
> On Sun, 6 Feb 2011 20:50:05 -0800, Guenter Roeck wrote:
> > On Sun, Feb 06, 2011 at 10:50:02PM -0500, Andy Lutomirski wrote:
> > > 2. PWM control doesn't seem to have any effect.  (The BIOS PWM control
> > > settings definitely work.)
> >
> > Ok, I'll look into it.
> 
> I had already noticed that the W83667HG was more complex than the
> previous chips in this respect, and had even started writing a patch to
> address the problem (which was never tested and is maybe not even
> finished, I can't remember.) I don't know if the W83677HG-I is similar
> in this respect, or even worse. Here is what I had back then (June
> 2009!) if it is of any interest to you:
> 
> ---
>  drivers/hwmon/w83627ehf.c |   87 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 74 insertions(+), 13 deletions(-)
> 
> --- linux-2.6.31-rc1.orig/drivers/hwmon/w83627ehf.c	2009-06-25 09:32:17.000000000 +0200
> +++ linux-2.6.31-rc1/drivers/hwmon/w83627ehf.c	2009-06-25 15:22:18.000000000 +0200
> @@ -198,6 +198,10 @@ static const u8 W83627EHF_REG_TOLERANCE[
>  static const u8 W83627EHF_REG_FAN_MIN_OUTPUT[] = { 0x08, 0x09, 0x15, 0x64 };
>  static const u8 W83627EHF_REG_FAN_STOP_TIME[] = { 0x0C, 0x0D, 0x17, 0x66 };
>  
> +/* W83667HG-specific fan controller routing */
> +#define W83667HG_REG_FANCTRL2_SEL	0x62
> +#define W83667HG_REG_FANCTRL4_SEL	0x7C
> +
Unfortunately, both registers are no longer defined in nct665/nct6776.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
