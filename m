From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 19:06:04 +0000
Subject: Re: [lm-sensors] 5VSB computing on it87
Message-Id: <20090512210604.35ba4f16@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
In-Reply-To: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 12 May 2009 19:55:10 +0200, Mr. Tux wrote:
> 
> Thank you Jean
> 
> So, this sensor is not assigned correctly, I could life with that for the moment, but my problem
> is the alarm flag this sensors is causing, since the value for some reason is saturated.
> 
> I'd like to put this sensor on ignore for the moment, but I don't know how to do that:
> 
> *) ignore in7 - only prevents the sensor to be listed using the 'sensors' command

Not just the "sensors" command, but all problems using libsensors. And
all monitoring programs should use it.

> *) comment every line mentioning in7 in sensors3.conf - makes it appear under
> /sys/devices/plattform/[...]/ anyway ! With the alarm flag in "in7_alarm" set to 1 - I need to get rid
> of that...

This doesn't make any sense. Statements mentioning in7 for other chips
you do not have on your board have no effect for you in the first place.

> *) trying to set in7 to value 0 (= unused): 'set in7_type  0' causes a parse error with 'sensors -s'

You can't invent symbols like that. Only a few sensors have a
selectable type, thermal sensors mostly.

> *) trying to raise the max_value barrier switching on the alarm: 'set in7_max    7 * 1.05'
> this does not have an effect - the max limit stays at 6,.85, triggering the alarm!

Some chips to strict comparisons on limits and some do loose
comparisons. Apparently the IT87xxF chips do loose comparisons on upper
limits, so you're doomed. That's the reason why chip manufacturer
recommend to connect unused voltage inputs to the ground, a
recommendation your motherboard vendor did not follow - blame them!

> What else can I try? I need the alarm flag in /sys/devices/plattform/[...]/in7_alarm to
> be set to '0' - since I'm writing a small daemon who will parse for alarm values
> only, starting a speaker beep when a alarm is discovered.

Your small daemon should link with libsensors and use it's API, instead
of accessing /sys files directly. That way you can ignore faulty inputs
through /etc/sensors3.conf.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
