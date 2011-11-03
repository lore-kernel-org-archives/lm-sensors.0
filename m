From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Nov 2011 16:38:41 +0000
Subject: Re: [lm-sensors] Hardware running hot and without the fan
Message-Id: <20111103173841.367d4081@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EB1108F.6070009@gmail.com>
	<20111103020301.GA22333@ericsson.com>
	<4EB250FD.3070000@gmail.com>
	<20111103134902.GA26121@ericsson.com>
	<4EB2A46B.8080600@gmail.com>
	<1320332801.2309.60.camel@groeck-laptop>
In-Reply-To: <1320332801.2309.60.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Lars =?ISO-8859-1?B?Tm9vZOlu?= <lars.nooden@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 3 Nov 2011 08:06:41 -0700, Guenter Roeck wrote:
> You should be able to set the fan speed by writing into the fanX_input
> and/or fanX_output sysfs attributes. You find those
> in /sys/class/hwmon/hwmon0/device (assuming there is only one hwmon
> device).

Note that fanX_input is always a read-only file, so writing to it isn't
going to do anything.

fanX_output is not a standard attribute for hwmon devices, it shouldn't
be there in the first place... The applesmc driver doesn't see to
follow the standard interface, so it's probably best to not assume too
much.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
