From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 21:54:43 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (f75375s) Fix reading of wrong register when initializing the F7
Message-Id: <1328738083.2261.343.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328723771-22163-3-git-send-email-mail@microschulz.de>
In-Reply-To: <1328723771-22163-3-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 16:31 -0500, Nikolaus Schulz wrote:
> On Wed, Feb 08, 2012 at 10:53:51AM -0800, Guenter Roeck wrote:
> > This code was only added for 3.3, so the patch does not apply to stable,
> > only to 3.3-rc.
> 
> Ah, indeed, I missed that.
> 
> Thanks,
> Nikolaus
> 
> PS. Hmm, I don't see my patch emails appear on the lm-sensors list, only
> the introductionary one. I wonder what's wrong?

As far as I know, gmane only stores an email once if it is sent to
multiple lists. Kind of annoying, but happens on a quite regular basis.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
