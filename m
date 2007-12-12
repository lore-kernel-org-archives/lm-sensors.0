From: "Jim Cromie" <jim.cromie@gmail.com>
Date: Wed, 12 Dec 2007 22:13:42 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <cfe85dfa0712121413k52e59f39o54c50602f7b424fe@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Nov 29, 2007 2:27 PM, David Hubbard <david.c.hubbard@gmail.com> wrote:
> Hi Jim,
>
> Good to hear from you! Merry Christmas, Joyous Noel, whatever ... you
> get patches for your holidays this year.
>
> I'm excited for the possibilities these patches open up ... especially
> for w83627ehf.
>
> Take care,
> David
>
>
> On Nov 29, 2007 2:01 PM, Jim Cromie <jim.cromie@gmail.com> wrote:
> > David Hubbard wrote:
> > > Hi Jim,
> > >
> > > I pulled the w83627ehf.c patch out of patch #5, so patch #5 is
> > > (mostly) unchanged, and then put some of the superio-locks.c changes
> > > in patch #1 to support changes to w83627ehf. So w83627ehf changes are
> > > in my patch #6, where I did the things we have talked about.
> > >
> > >


Hi David,

happy 0th day of christmas - on this day I give you 0 patches.
(not that I can give you 12 by christmas day, I just couldnt leave it alone.)
.
A few quick notes.

we dont need 2 superio_inw*'s - mine is wrong (missing a +1), so Ive
removed it, and renamed yours.

Wrt superio_exit, I suspect more critical reviewers will dislike the
use of exit_seq[] for both values to write, and addresses to write to.
 Something like it is obviously needed for your ehf chip (or you
wouldnt have added it).  An exit_addr_seq[] (with offsets from
gate->sioaddr) would be clearer, and would like method-0, but would
also be a bit bigger.

Perhaps a callback is better, maybe in a union with enter/exit_seq[]s.
I wonder what the next device will require.  Im also not thrilled by
enter-exit-method, it influences only the exit method now, and maybe
should be a single bit, allowing another for enter-method (if needed
later).
Lastly, I think exit_addr_seq[] may obsolete enter-exit-method.

Chances are poor that I'll locate hardware here that I can test upon,
so Im somewhat limited till mid Jan.

thanks again David,
happy kwanzaa, etc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
