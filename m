From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 22:34:18 +0000
Subject: Re: [lm-sensors] [PATCH] f75375s: added Fintek f75387 support
Message-Id: <20111208223418.GA12022@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
In-Reply-To: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bjoern,

On Thu, Dec 08, 2011 at 05:04:54PM -0500, Bjoern Gerhart wrote:
> Hi Guenter,
> 
> so for solving the other issues you mentioned, I'd first apply your
> set of 4 patches on the original f75375s. Then I'd implement my f75387
> related modifications within your latest review proposals, test the
> resulting binary module on my f75387 hardware and then create a fifth
> patch.
> 
> Would that order lead to a valid set of patches?
> 
Yes, that would be the best way to proceed, only it is 5 patches by now.
Did I copy you on the last one ?

If you use git, it should be straightforward to merge your patch on top of mine.
I would have done that, only I had trouble applying yours because it was somehow
corrupted.

Of course, it would also help tremendously if you would fine the time to review
my patches :).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
