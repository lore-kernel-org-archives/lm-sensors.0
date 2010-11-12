From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Fri, 12 Nov 2010 21:53:50 +0000
Subject: Re: [lm-sensors] Location for thermal drivers
Message-Id: <AANLkTimERGh2yGGX_E_N4ajxg_-0QTFS54QSKj2+AAfF@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289594026.22931.388.camel@groeck-laptop>
In-Reply-To: <1289594026.22931.388.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, lm-sensors@lm-sensors.org

On Fri, Nov 12, 2010 at 12:33 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> I think a better location for the driver would be drivers/thermal.
> drivers/hwmon is not really a good fit, since hwmon support for thermal
> drivers is optional. Potential problem with drivers/thermal is that
> there are no thermal drivers in there (yet), and there does not seem to
> be a maintainer.

What is the difference between a "thermal" sensor and a "temperature"
sensor?  Aren't they the same thing?

Why does drivers/thermal exist if there are no drivers in it and no maintainer?

Phil P.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
