From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 Oct 2014 21:24:50 +0000
Subject: Re: [lm-sensors] systemd integration: Problem with modprobe in lm_sensors.service
Message-Id: <20141009212450.GA20684@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201410081842.s98Igvmj004161@hobgoblin.ariadne.com>
In-Reply-To: <201410081842.s98Igvmj004161@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 09, 2014 at 04:42:18PM -0400, Dale R. Worley wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> 
> > Not sure if there is anything we can do about that; it is a distribution
> > problem, not a lm-sensors problem.
> 
> As long as I know that the lm-sensors people don't maintain the
> lm_sensors.service file and send it to the people who package Fedora,
> I can report it to Fedora.  I just need feedback on who is responsible
> for the file.
> 
I had a look; you are right, the lm-sensors package includes
prog/init/lm_sensors.service; it was added last year.

Jean, any idea how to handle this ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
