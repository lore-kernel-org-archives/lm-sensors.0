From: James Cloos <cloos@jhcloos.com>
Date: Wed, 05 Nov 2014 23:34:20 +0000
Subject: Re: [lm-sensors] Kaveri [and Radeon] temps
Message-Id: <m3ppd18bnn.fsf@carbon.jhcloos.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m31tph9wmt.fsf@carbon.jhcloos.org>
	<20141105232155.GA25189@roeck-us.net>
In-Reply-To: <20141105232155.GA25189@roeck-us.net> (Guenter Roeck's message of
	"Wed, 5 Nov 2014 15:21:55 -0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: dri-devel@lists.freedesktop.org

>>>>> "GR" = Guenter Roeck <linux@roeck-us.net> writes:

...
GR> AMD CPUs are known report wildly off temperatures especially at
GR> low temperatures.

Thanks.  After some further digging, I wonder whether Aravind's recent
patch might help?  The apu does have both PCI_DEVICE_ID_AMD_16H_M30H_NB_F3
and PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 and lspci reports no driver for the
F4 device.

GR>  Does the temperature increase with load ?

It seems to max out w/in a kelvin or two of the room's ambient temp.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0x997A9F17ED7DAEA6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
