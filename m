From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Feb 2015 20:51:25 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] kernel.h: add find_closest() macro
Message-Id: <20150224205125.GB18025@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424799734-2170-1-git-send-email-bgolaszewski@baylibre.com>
 <1424799734-2170-2-git-send-email-bgolaszewski@baylibre.com>
 <CAAek22F3JzWRVqwf=QdaoowjTSkfHAiUP6orpHpcdt_gicaT=A@mail.gmail.com>
In-Reply-To: <CAAek22F3JzWRVqwf=QdaoowjTSkfHAiUP6orpHpcdt_gicaT=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Pokorny <ppokorny@penguincomputing.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Tue, Feb 24, 2015 at 12:33:06PM -0800, Phil Pokorny wrote:
> On Tue, Feb 24, 2015 at 9:42 AM, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> >
> > Searching for the member of an array closest to 'x' is
> > duplicated in several places.
> >
> > Add two macros that implement this algorithm for arrays
> > sorted both in ascending and descending order.
> 
> I don't see the point here.  You're not saving any code because your
> macros create functions at each invocation site.  And your macro is
> more complicated than the code it replaces because it has all the
> syntactic cruft to make it adaptable to the different datatypes and
> sort orders.
> 
> Certainly it is easy to make an off by one mistake in a loop like this
> so there might be some small value there, but I'm not sure the
> complication is worth that savings for the small number of use points.
> Particularly because you're not saving any code.
> 
I think the lm85 conversion actually introduces a bug with such an
off-by-one mistake. And if it doesn't, there is still a unexplained
and not easy to understand '-1' in one of the calls to find_closest().

So the question is if the new code really improves the situation in that
respect.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
