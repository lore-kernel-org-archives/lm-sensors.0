From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Oct 2010 14:33:19 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <20101007143319.GC20342@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 07, 2010 at 08:55:46AM -0400, Fred . wrote:
> http://www.lm-sensors.org/ticket/2370
> Ticket says the interface definition is now upstream.
> 
It is.

> http://www.lm-sensors.org/wiki/ProjectInformation
> However the Project Information page says it still is not standardized yet.
> 
> Why is this? Which is right? Perhaps the Project Information page
> isn't updated? Or am I missing something?
> 
> Also, has there been any more progress.
> 
> Since the interface definition is upstreams, why have not support been
> added to libsensors and sensors?
> 
Browsing through the drivers, it seems that none have been converted
to use the new interface. I would guess that until that has been done,
it does not make sense to add untestable support for it to libsensors.

Please keep in mind that most of the work done in the linux kernel is voluntary.
Especially work like this, which is a bit out of mainstream. You are always
invited to make a contribution yourself, modify the drivers as needed, and
submit your patches. Including, of course, libsensors.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
