From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 01 May 2008 04:08:41 +0000
Subject: Re: [lm-sensors] [PATCH 01/10] hwmon: (lm85) Fix function
Message-Id: <191fb4ca0804302108s5fb65438t34279e71f6b7e8a9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48169F4D.8090508@gmail.com>
In-Reply-To: <48169F4D.8090508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


> Hi Juerg,
>
>
>
>  On Mon, 28 Apr 2008 21:08:45 -0700, Juerg Haefliger wrote:
>  > > Function RANGE_TO_REG() is broken. For a requested range of 2000 (2
>  > > degrees C), it will return an index value of 15, i.e. 80.0 degrees C,
>  > > instead of the expected index value of 0. All other values are handled
>  > > properly, just 2000 isn't.
>  > >
>  > > The bug was introduced back in November 2004 by this patch:
>  > > http://git.kernel.org/?p=linux/kernel/git/tglx/history.git;a=commit;h28d80f1992240373099d863e4996cdd5d646d0
>  > >
>  > > While this can be fixed easily with the current code, I'd rather
>  > > rewrite the whole function in a way which is more obviously correct.
>  > >
>  > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
>  > > Cc: Justin Thiessen <jthiessen@penguincomputing.com>
>  > > ---
>  > > Note: this is the same patch as I already sent on April 3rd.
>  > >
>  > >  drivers/hwmon/lm85.c |   25 +++++++++++--------------
>  > >  1 file changed, 11 insertions(+), 14 deletions(-)
>  > >
>  > > --- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c      2008-04-02 22:20:01.000000000 +0200
>  > > +++ linux-2.6.25-rc8/drivers/hwmon/lm85.c   2008-04-02 23:10:16.000000000 +0200
>  > > @@ -192,23 +192,20 @@ static int RANGE_TO_REG( int range )
>  > >  {
>  > >     int i;
>  > >
>  > > -   if ( range < lm85_range_map[0] ) {
>  > > -           return 0 ;
>  > > -   } else if ( range > lm85_range_map[15] ) {
>  > > +   if (range >= lm85_range_map[15])
>  > >             return 15 ;
>  > > -   } else {  /* find closest match */
>  > > -           for ( i = 14 ; i >= 0 ; --i ) {
>  > > -                   if ( range > lm85_range_map[i] ) { /* range bracketed */
>  > > -                           if ((lm85_range_map[i+1] - range) <
>  > > -                                   (range - lm85_range_map[i])) {
>  > > -                                   i++;
>  > > -                                   break;
>  > > -                           }
>  > > -                           break;
>  > > -                   }
>  > > +
>  > > +   /* Find the closest match */
>  > > +   for (i = 14; i >= 0; --i) {
>  > > +           if (range >= lm85_range_map[i]) {
>  > > +                   if ((lm85_range_map[i + 1] - range) <
>  > > +                                   (range - lm85_range_map[i]))
>  > > +                           return i + 1;
>  > > +                   return i;
>  > >             }
>  > >     }
>  > > -   return( i & 0x0f );
>  > > +
>  > > +   return 0;
>  > >  }
>  > >  #define RANGE_FROM_REG(val) (lm85_range_map[(val)&0x0f])
>  > >
>  >
>  > This works but is less efficient compared to the original code for range
>  > values < 2000.
>
>  But it is slightly more efficient for all values between 2000 and
>  80000. The average efficiency is exactly the same as those of the
>  original code.
>
>
>  > Is there a reason not to check for < 2000 before looping?
>
>  Code size. The < 2000 case is handled just fine by the for loop, so I
>  don't see the point of making the code bigger.
>
>  Note that performance is hardly an issue here anyway, users aren't
>  going to change this parameter very often.

True.

Acked-by: Juerg Haefliger <juergh at gmail.com>


>  --
>  Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
