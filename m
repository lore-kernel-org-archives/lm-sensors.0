From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 04 May 2006 19:44:23 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new vt1211 driver
Message-Id: <191fb4ca0605041244k6141dcc0n768926112d539b30@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
In-Reply-To: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the review, Rudolf.

> > +/* -------------------------------------------------------------------------
>
> Hmm as Jim already mentioned I dont know if Jean will like it. On the other hand
> this line is on many places in kernel, but bit shorter, like this:
>
> /*-------------------------------------------------------------------------*/

OK, fix the length (or get rid of them alltogether).


> > +             /* voltage (in) registers */
> > +             for (ix = 0; ix <= 6; ix++) {
>
> The ARRAY_SIZE idea sounds good to me too.

Yep it is. Will fix it.


> > +             /* temp registers */
> > +             for (ix = 1; ix <= 7; ix++) {
>
> And Jims proposal for the "get rid of -1" is a good one too. And of course on
> other places too.

Hmm... If you guys feel so strongly about it I'll change it (even
though I still think it's easier to read the way it is now :-).


> > +#define SHOW_TEMP_INPUT              0
> > +#define SHOW_SET_TEMP_MAX    1
> > +#define SHOW_SET_TEMP_MAX_HYST       2
> > +#define SHOW_TEMP_ALARM              3
>
> Jim wrote that he likes the idea, well I'm myself still not convinced.
>
> The classic 2D array grouping is more elegant in term of function, but bit
> strange on the hand of array mapping/dimension.
>
> This case is vice-versa data structures are nice function is bit more
> complicated. I'm not telling you to remove it, but please at least change
> the default case to error and nr to some better name.

OK, I'll fix the default and the nr naming. I still prefer to keep the
combined callbacks, they make the source much smaller and the grouping
of functions for same sensors makes it very easy to read the code.


...juerg

