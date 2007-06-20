From: "Goede, J.W.R. de" <j.w.r.degoede@hhs.nl>
Date: Wed, 20 Jun 2007 14:17:08 +0000
Subject: Re: [lm-sensors] initial fintek f71882fg driver, test please
Message-Id: <web-69397055@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4676A4D8.5020706@hhs.nl>
In-Reply-To: <4676A4D8.5020706@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Walt H wrote:
> Compiled and installed fine against a patched 2.6.21
x86_64 kernel .  
> Looks good so far.  I'm displaying sensor values through
gkrellm and the 
> temps and fan values look good.  Vcor1 looks high, and
the voltage 
> inputs need tweaks under gkrellm, but I'm mainly
interested in temp and 
> fan values anyway.  Appreciate everybody's work on this!
 Thanks,
> 
> -Walt

Thanks for the feedback, on what motherboard did you test?
I doubt that vcore 1 is high because vcore usually is
connected without a divider, also since if there is a
scaling problem, its almost aways a missing divider, not a
multiply,  I would expect vcore to be to low, not to high.

Regards,

Hans


p.s. Did you try this with the libsensors 3 branch? I would
be much oblidged you could, then run sensors and update
sensors.conf until things look good and last send the
working snesors.conf to te list.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
