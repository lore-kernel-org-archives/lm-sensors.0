From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <db7l81l06afri8aficf4oopmvu632f7cv3@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703479bd0c29@mail.gmail.com> <e9iUj0EZ.1116327879.1515720.khali@localhost> <2538186705051704181a70dbbf@mail.gmail.com> <0pik81hjboqvbf2jhgdut861cfpgl7sata@4ax.com> <2538186705051713565d07e66b@mail.gmail.com> <lqrk81degqp2id4sf1f4rjsnithljnibhb@4ax.com> <25381867050517162126d18704@mail.gmail.com>
In-Reply-To: <25381867050517162126d18704@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Yani,
On Tue, 17 May 2005 19:21:41 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:

>Ah..OK, that is probably why, I've put the macros which would be
>expanded in the first level in a separate header because it will
>probably be shared amongst many drivers. Although I still don't see
>where SENSOR_blah is coming from at all at the moment, if you can
>track that down I'd be interested to know if its just something to do
>with the script or a problem with the patch.

Oops, my script, sorry.  I'll fix that.

>> Not singletons, 3 of each (from an intermediate file):
. . .
>
>Well I said mainly singletons :-), some of the attributes don't
>benefit from the dynamic sysfs callbacks simply because they already
>only use one callback for a few different attributes, I believe that's
>the case with the non-singletons in this case.

Not quite that, one sysfs name, one value.  The multiple sysfs names 
that were 'missed' by your changes don't use the usual macro.  Three 
instances of each attribute in the source, instead.

--Grant.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
