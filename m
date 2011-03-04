From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 00:59:00 +0000
Subject: Re: [lm-sensors] [Nouveau]  hwmon API update
Message-Id: <20110304005900.GB31318@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110213171640.GB13323@ericsson.com>
	<20110213230833.0ee2ff16@endymion.delvare>
	<AANLkTindG=m4FhNS202MH8YVBUCoDEADTQLxo-Bf_8qx@mail.gmail.com>
	<20110303152216.GA21667@ericsson.com> <4D6FCFF2.7040604@free.fr>
	<1299185295.2255.13.camel@workstation>
	<1299187158.18605.28.camel@groeck-laptop>
	<1299189416.2255.22.camel@workstation>
	<1299189822.18605.35.camel@groeck-laptop>
	<4D7029E8.4040706@free.fr>
In-Reply-To: <4D7029E8.4040706-GANU6spQydw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Peres <martin.peres-GANU6spQydw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, nouveau <Nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Thu, Mar 03, 2011 at 06:53:12PM -0500, Martin Peres wrote:
[ ... ]
> >>> Guenter
> >> This is a bigger change than we initially aimed for and I didn't dare to
> >> ask for such a heavy modification, but I'm very happy with this solution
> >> if you prefer and support it this way.
> > If done right, it should be much less invasive than the previous
> > approach - meaning existing drivers would not have to be modified and
> > can be converted as time permits.
> The previous solution already permitted that, but anyway, it's good to
> see you welcome change.

It touched all drivers. It did not move anything out of drivers, forcing drivers
supporting the new functions to support both sysfs _and_ the new functions.
Significant difference.

The idea here - at least mine - is to move sysfs attribute management 
into core hwmon code.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
