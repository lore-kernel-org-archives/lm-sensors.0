From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Sat, 21 Mar 2015 05:01:33 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] util_macros.h: add find_closest() macro
Message-Id: <CAAek22EKO9RxTeyQxVzScF0gUUMF-DOQ12y=H-cazujh8P5cqA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426775420-31350-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday, March 20, 2015, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 19 Mar 2015 18:27:41 +0100 Bartosz Golaszewski <
> bgolaszewski@baylibre.com <javascript:;>> wrote:
>
> > Searching for the member of an array closest to 'x' is
> > duplicated in several places.
>
> Linear search is pretty nasty.  lib/bsearch.c could do this
> with a bit of tweaking.  But that's a separate project.


These are short lists, (10 items or less) searched infrequently (perhaps
once or twice) when an lmsensors driver is initialized/configured.

Linear search could be faster under these conditions due to tighter loops
and more predictable memory access pattern with better cache behavior. No?

Phil P.


-- 
Philip Pokorny, RHCE
Chief Technology Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

Changing the world through technical innovation
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
