From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: RFC: test results for adm9240 auto fan clock divider
Message-Id: <20050419192950.373e8915.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
In-Reply-To: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > > automatic fan clock divider
> > > ````````````````````````````
> > >     * User sets 0 to fan_min limit
> > >       - low speed alarm is disabled
> > >       - fan clock divider not changed
> > >       - auto fan clock adjuster disabled
> >
> > Why would we want to disable the auto fan clock adjuster in this
> > case?
>
> Oops, I just posted new driver...  Bad timing -- I'll need to check, 
> this implies enabling bidirectional fan adjustment to do it right?

No, it doesn't.

> > You also missed one case, which is the main reason why the whole
> > thing is (IMHO) needed:
> >
> >      * User doesn't set any limit
> >        - auto fan clock adjuster enabled
> 
> Again, this implies bidirectional adjustment (...)

Again, it doesn't.

Automatic fan clock adjustment is really automatic fan divider
increment, in order to prevent zero speed readings when the fan actually
spins. Decreasing would only possibly improve accuracy, and that's not
our problem when the user did not set a proper limit.

-- 
Jean Delvare
