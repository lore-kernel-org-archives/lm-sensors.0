From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Sep 2013 09:20:09 +0000
Subject: Re: [lm-sensors] Trouble with sensors-detect probing ASUS 1015E-DS03 laptop
Message-Id: <20130905112009.20196ae5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADO8fxbc7H6y32vm28GV3+ye7O+WnfpcvQQKMom5_CmbAQYbZg@mail.gmail.com>
In-Reply-To: <CADO8fxbc7H6y32vm28GV3+ye7O+WnfpcvQQKMom5_CmbAQYbZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Larry,

On Wed, 4 Sep 2013 20:17:41 -0500, Larry Lade wrote:
> Thank you Jean and Guenter for taking the time to reply.
> 
> Since it was still new, I decided to work with the retailer to replace the
> device.

I think it was the best move, indeed. Not only for you, but it will
also show the hardware vendor that they probably should go for a more
robust design.

> I have an suspicion there's a EEPROM in this device that is shipping
> without write-protection set, and the sensors-detect probe rakes over it at
> random before eventually eventually setting the chip into read-only mode.

This is a possibility, yes. But there are many other possibilities and
we are pretty clueless at the moment :(

> If that's the case, then it's probably a lost cause. But EEPROM programming
> is all very much over my head! I'm happy to not solve the mystery if I
> don't have to.

I understand.

> Perhaps the thing to do is file a bug with Ubuntu to push out a more
> up-to-date version of lm-sensors to their long-term support release.

Yes, this should be fixed by distributions. I have added a note about
that on the main page of lm-sensors.org:

http://www.lm-sensors.org/wiki

Distributions don't have to upgrade to lm-sensors 3.3.3+, but they
should at least backport the two critical fixes that were added to
3.3.3 to avoid further hardware breakage:
  http://www.lm-sensors.org/changeset/6040
  http://www.lm-sensors.org/changeset/6084
So if you can get Ubuntu to backport these to affected products still
under maintenance, that would be great. I'll do the same for openSUSE.

I also have plans to make sensors-detect even safer by default, I'll
discuss these on this list in a separate thread.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
