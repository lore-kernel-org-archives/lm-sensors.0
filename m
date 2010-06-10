From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 10 Jun 2010 08:26:07 +0000
Subject: Re: [lm-sensors] control f71889fg pwm on 2.6.34
Message-Id: <4C10A19F.7000602@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimzIutXVn2W2ZE1LQ-dXbNEMfuUfJ4G1733cFsM@mail.gmail.com>
In-Reply-To: <AANLkTimzIutXVn2W2ZE1LQ-dXbNEMfuUfJ4G1733cFsM@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 06/02/2010 06:57 PM, Roman Evstifeev wrote:
> Hi. I have Mainboard* with F71889FG-based controller.
> * - MSI P41T-C31 (
> http://www.msi.com/index.php?func=proddesc&maincat_no=1&prod_no92
> <http://www.msi.com/index.php?func=proddesc&maincat_no=1&prod_no92> )
>
> After f71882fg module loaded - it creates bunch of the sysfs entries,
> and i can succesfully read temperature and fan speed values from it. But
> i can't control the pwm with it.
> I tried pwmconfig utility as well as writing to sysfs files directly.
> sysfs values get changed, but actual fan speed does not.
>

Chances are the pwm outputs are not hooked up (yes manufacturers do that),
or that the fan you're trying to control is controlled by a different
pwm then pwm3 (yes vendors do that too).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
