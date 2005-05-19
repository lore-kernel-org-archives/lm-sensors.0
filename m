From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040202230632.55c82335.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It seems, that you've used the latest driver file, I've sent, where
> all occurances of simple_stroul() put their result into a variable of
> type 'unsigned long' (instead of int) and where set_fan_div() outputs
> this message
> 
> 	dev_info(&client->adapter->dev, "fan_div value %ld not
> 	supported. Choose one of 2, 4 or 8!\n", v);
> 
> when it is called with an unsupported div value.

You mean that I have *not* being using it. Shame on me. I'll reintegrate
these changes into my version, sorry. Nice catching by the way. I'm glad
to see you're keeping a serious eye on me.

> > I committed a change to libsensors so that it finds fan_rippleX
> > files from the 2.6 driver. There are still a few matchings missing
> > (rev, control and wdog_*) but I don't think sensors uses them, does
> > it?
> 
> We've already discussed about that and I'd like to add them, but I
> still do not know, how to access those values.

Basically you can refer to them by their item names (see lib/chips.c) in
sensors.conf and access them with their ID in sensors. The thing is, I
don't think you want to do that since these are not things you want to
display in sensors' output nor write to with "sensors -s".

This is the reason I didn't bother supporting them in libsensors for the
2.6 version. But if you think it's better, I can do.

How are you using these files at the moment? How would you want to use
these values if you can't do that now? My impression is that rev is
mainly decorative, and that wdog would more likely be accessed directly
using shell scripts. I don't know about control - what is it for?

> Both drivers work as expected. The conversion formula returns correct
> values. But sensors gives the following output on 2.6.1:
> 
> fscher-i2c-1-73
> Adapter: SMBus I801 adapter at 2000
> Temp1/CPU:      failed
> Temp2/MB:       failed
> Temp3/AUX:      failed
> ERROR: Can't get FAN1 data!
> ERROR: Can't get FAN2 data!
> ERROR: Can't get FAN3 data!
> +12V:           +11.79 V
> +5V:             +5.05 V
> Battery:         +3.04 V

Is is libsensors from CVS? If if is, then I have not hacked in
correctly. Will take a look tomorrow.

> sensors-detect works for both kernels, both times considers fscher as
> 'todo'.

My bad, I forgot to update that by the time you commited the original
driver. Fixed in CVS.

> How can I set pwm* with 'sensors -s', as it gives me
> 
> Error: Line 1589: Unknown feature name
> Error: Line 1590: Unknown feature name
> Error: Line 1591: Unknown feature name
> 
> when I enable those lines in 'sensors.conf'.

This is also a libsensors hacking issue. I must really have missed
something.

I hope to fix everything by tomorrow.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
