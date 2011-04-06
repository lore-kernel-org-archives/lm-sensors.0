From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 00:47:15 +0000
Subject: Re: [lm-sensors] [PATCH v5 00/11] hwmon: (w83627ehf) Add support
Message-Id: <20110406004715.GB21882@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 05, 2011 at 08:33:52PM -0400, Michael D Powell wrote:
> 
> Perhaps I'm missing something obvious or simple, but I always get fan
> RPM of zero from lm sensors and can't seem to debug it.  Thanks in
> advance for developing support for the
> nct6775f.
> 
> Here's my setup:
> 
> Intel DH57DD board with core i5-750 cpu

I suspect you have the same problem I have with the DH57JG board: That Intel 
does not use the fan control from the NCT6775F, but their own fan control
implementation in one of the Intel support chips. See if you can find
the technical documentation of your board (should be somewhere on the Intel
web site) and check if it mentions anything about fan control.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
