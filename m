From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Wed, 21 May 2008 14:09:27 +0000
Subject: Re: [lm-sensors] Accelerometer,
Message-Id: <20080521140927.GB3677@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <20080520132817.03fb74ea@hyperion.delvare> <20080521093520.ZZRA012@mailhub.coreip.homeip.net>
In-Reply-To: <20080521093520.ZZRA012@mailhub.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <Jonathan.Cameron@gmail.com>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, 21 May 2008, Dmitry Torokhov wrote:
> I don't think that input subsystem woudl be the best choice. While we
> do support the event-driven mechanism for delivering information to
> userspace input is mostly oriented for human interface devices, not
> general data acquisition. If anything input_dev is too fat. Another
> thing is that input layer anonymizes input devices, makes them
> capability-oriented. I.e. we dont really care what model of joystick
> we have, we want something that reports ABS_X, ABS_Y, BTN_FIRE and
> userpsace can use it whether it a simple analog joystick or something
> fancy and USB connected. For your purposes you probably do want to know
> what the device is and what exactly being sampled/measured.
> 
> I'd go with a lean and mean new subsytem.

Agreed.  I have put some thought on it in the past, and while the input
subsystem is the only thing even remotely usable for this *right now*, a
new subsystem for data acquisition would be the best way forward.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
