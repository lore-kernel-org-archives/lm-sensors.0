From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 29 Aug 2013 15:28:31 +0000
Subject: Re: [lm-sensors] sht15 kernel driver
Message-Id: <20130829152831.GA25021@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <521E7CA7.5060407@snapithd.com>
 <87fvtt4dmt.fsf@jerows.sfl>
 <521EBD9F.7070502@snapithd.com>
 <87ppswh75z.fsf@jerows.sfl>
In-Reply-To: <87ppswh75z.fsf@jerows.sfl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Cc: Chris Rodley <chris@snapithd.com>, kernel@savoirfairelinux.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, Aug 29, 2013 at 11:02:16AM -0400, Jerome Oufella wrote:
> Chris Rodley <chris@snapithd.com> writes:
> 
> > Thanks Jerome!
> >
> > That was just what I needed to know.
> > The device is now set up and is working well - I will have a go at
> > back porting now.
> >
> > Many thanks again for your help!
> > Chris
> 
> Good to know Chris!
> 
> Note, we noticed that the sht15 driver may be sensible to noisy lines,
> we suspect a race condition around the interrupt handling code.
> 
Any proposed fixes ?

Guenter

> If your sensor is populated on the board you shouldn't have problems
> though.
> 
> Jerome
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
