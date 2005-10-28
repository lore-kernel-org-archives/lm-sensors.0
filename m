From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 28 Oct 2005 05:32:43 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch,
Message-Id: <20051028033223.GC3981@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2005-10-21 11:19:13 +0200]:
> As promised some time ago here is a new version of the Abit uGuru 
> driver, this version fully supports the sensor part of the uGuru, that 
> means it supports the following:
> 
> -reading all sensors
> -reading and writing min/max settings for all sensors
> -reading/writing settings for all sensors (enable alarm, beep, shutdown)
> -reading alarms
> -configuring the fan speed control (quiet fan or whatever buzzword)
> 
> I would like to submit the libsensors part here and the driver upstream, 
> so please review.

BTW: "driver upstream" = this same mailing list.

> Thanks,
> 
> Hans
> 
> 
> For some more info I've also written a small readme, see Attachment.

For starters, you should add this readme as a new file in doc/chips in
your lm_sensors2 patch.  Try to use a similar format as the documentation
already there.

> Abit Uguru driver README.
> ============[...]

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

