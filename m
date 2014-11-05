From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Nov 2014 23:50:22 +0000
Subject: Re: [lm-sensors] Kaveri [and Radeon] temps
Message-Id: <20141105235022.GA26085@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <m31tph9wmt.fsf@carbon.jhcloos.org>
	<20141105232155.GA25189@roeck-us.net>
	<m3ppd18bnn.fsf@carbon.jhcloos.org>
In-Reply-To: <m3ppd18bnn.fsf@carbon.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Cloos <cloos@jhcloos.com>
Cc: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>, dri-devel@lists.freedesktop.org, lm-sensors@lm-sensors.org

On Wed, Nov 05, 2014 at 06:34:20PM -0500, James Cloos wrote:
> >>>>> "GR" = Guenter Roeck <linux@roeck-us.net> writes:
> 
> ...
> GR> AMD CPUs are known report wildly off temperatures especially at
> GR> low temperatures.
> 
> Thanks.  After some further digging, I wonder whether Aravind's recent
> patch might help?  The apu does have both PCI_DEVICE_ID_AMD_16H_M30H_NB_F3
> and PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 and lspci reports no driver for the
> F4 device.
> 
Aravind would have to comment; my understanding is that the F4 device
reports the power, not the temperature. You could try to apply the patch
and see if it makes a difference. Worst case there will be no change ;-).

> GR>  Does the temperature increase with load ?
> 
> It seems to max out w/in a kelvin or two of the room's ambient temp.
> 
Even under load ? Sounds weird. Question of course is if the chip really
reports a useful temperature in the first place; this is something I can
not answer, since I have neither a datasheet nor a system with that CPU.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
