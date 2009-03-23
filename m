From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Mar 2009 08:44:26 +0000
Subject: Re: [lm-sensors] new driver for adt746x.. need some hints
Message-Id: <20090323094426.203fc544@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7b71803f0903221448m56cf985ev977bb1892e6c5702@mail.gmail.com>
In-Reply-To: <7b71803f0903221448m56cf985ev977bb1892e6c5702@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Mar 2009 22:48:13 +0100, DaNiMoTh wrote:
> Hello to the list,
> 
> this is the first time that I write on it.
> 
> I have written a new driver for the adt746x monitor chip, used in Mac
> iBook and Powerbook G4. I referred to the official documentation ( and
> new sysfs interface ) and the adt7470 module.

This driver already exists: see drivers/macintosh/therm_adt746x.c.

> Now I can read the temperature, read/set the high/low temperature
> limit and read the fan speed (RPM) from lm-sensors.
> The others functionality ( like using an automatic fan speed control,
> or setting the temperature over that the fans start) are in
> /sys/class/hwmon/hwmon0/device/ , but I can't control these with a
> sensors.
> 
> So, I have a question:
> 
> There is a way to edit these options ?
> I tried echo, but it don't work ( permission denied ).

I have a question too: how are we supposed to guess what is wrong
with you giving us _zero_ technical information? No source code, and
only a vague explanation of what you did. What do you think we are
doing here, cartomancy?

That's pointless anyway. Just use the driver that already exists, or
improve it if it needs to be.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
