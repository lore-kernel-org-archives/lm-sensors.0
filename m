From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Mar 2012 06:52:38 +0000
Subject: Re: [lm-sensors] Incorrect Temperature Readings
Message-Id: <20120327085238.64295c11@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT120-W272CB289017CB6E4F875EC87440@phx.gbl>
	<20120325152311.GA6544@ericsson.com>
	<SNT120-W14AE6F1D312CD041BCB3E787450@phx.gbl>
In-Reply-To: <SNT120-W14AE6F1D312CD041BCB3E787450@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Ondercin <sgo542@hotmail.com>
Cc: lm-sensors@lm-sensors.org, dri-devel@lists.freedesktop.org, guenter.roeck@ericsson.com

Hi Scott,

Please don't top-post.

On Mon, 26 Mar 2012 15:59:56 -0400, Scott Ondercin wrote:
> -I've been running the computer for over an hour currently and it feels perfectly fine.  Even the hard drive feels only mildly warm.  Nonetheless, I'm getting 96C readings for my PCI Adapter.
> 
> Is there a way to modify my /etc/sensors.conf file to change the input levels or high/crit temps for the adapter?  I may not be looking properly, but I can't find its chip name.

This default configuration file only deals with a limited number of
chips for which a generic configuration is possible. In your case,
please create a new configuration file under /etc/sensors.d and add
your statements here, starting with

chip "nouveau-pci-0100"

statement. You should indeed be able to adjust the thermal thresholds
of your graphics adapter with the nouveau driver. That being said...
Either you trust the temperature value and you should be worried and
not adjust the thresholds, or you don't trust it and it will be
difficult to decide what values to set the thresholds to.

Anyway, you said that you had to replace the fan a few months ago. Do
you remember the temperatures you got before that? Usually there is a
common cooling system for CPU and GPU in laptops, so I suspect that
your broke cooling for the GPU when changing the fan. It's really easy
to break, if the heatsink is no longer in straight contact with the
GPU, cooling become totally inefficient.

You could temporarily try the binary driver from nvidia to have a
comparison point. If it returns a value much lower than nouveau is
reporting, that would be a bug in nouveau. If it returns the same value
then your hardware is really in danger.

> Also, is there a way to run "module-init-tools" without getting "stop/waiting"?

This is a completely unrelated question and I don't even understand it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
