From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Oct 2007 18:47:37 +0000
Subject: Re: [lm-sensors] lm_sensors on ASUS M2NPV-VM motherboard using
Message-Id: <20071031194737.4b729bca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46ED7EFC.4030609@Winfirst.Com>
In-Reply-To: <46ED7EFC.4030609@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 28 Oct 2007 13:39:21 -0700, Mark E. Hansen wrote:
> On 10/28/07 07:44, Jean Delvare wrote:
> > * Find working configuration files for boards similar to yours, they
> >   might hold valuable hints.
> 
> But if I understand it correctly, it's not just that they use the same
> chipset and sensor chips, but the resistors they use could easily be
> different (even the type of heat sensor, for example), right?

You are right. But manufacturers have their habits, so two motherboards
from a given manufacturer using the same monitoring chip are likely to
share some settings.

> > This is tricky either way. It took me two years to be able to write
> > custom configuration files with good results, so I don't really expect
> > users to get it right at their first try.
> 
> I can see why. Is it true that I'm the first person to try to get the
> sensors package running on this particular mother board? When I chose
> this board, I had lm-sensors in mind, but I guess I didn't do a good
> enough job. I figured a popular manufacturer like ASUS would surely
> be covered :-)

No, there have been several reports by other users about this
motherboard:
http://www.google.fr/search?q=site%3Alists.lm-sensors.org+M2NPV-VM

> (...)
> If it really is using the IT8716F, then I think I read something somewhere
> that this chip is not really supported yet, and a kernel patch was
> required. Is that right?

Depends on what kernel version you're using. I added support for the
IT8716F in 2.6.19. For 2.6.17 and 2.6.18, there are kernel patches.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
