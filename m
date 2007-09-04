From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Sep 2007 08:36:02 +0000
Subject: Re: [lm-sensors] [PATCH] update w83791d driver with new sysfs
Message-Id: <20070904103602.01221eab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
In-Reply-To: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 3 Sep 2007 15:21:13 -0700, Charles Spirakis wrote:
> On Sep 3, 2007 3:13 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Mon, 3 Sep 2007 14:49:54 -0700, Charles Spirakis wrote:
> > > I will update. I'm assuming you want me to update all uses in the
> > > driver and not just the new ones?
> >
> > You're assuming wrong ;) Your patch shouldn't mix a new feature with
> > cleanups. If you want to update all the other uses, that's fine with
> > me, but that would be a separate patch. This is completely optional, of
> > course.
>
> Ok. If you don't mind I'll use the old way then so the code is regular
> and then update them all at once in a later patch.

Perfectly fine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
