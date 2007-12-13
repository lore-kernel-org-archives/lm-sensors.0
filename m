From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Thu, 13 Dec 2007 04:47:45 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <4dfa50520712122047s3f302ca6ue19b89e477044a61@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Hi David,
>
> happy 0th day of christmas - on this day I give you 0 patches.
> (not that I can give you 12 by christmas day, I just couldnt leave it alone.)
> .
> A few quick notes.
>
> we dont need 2 superio_inw*'s - mine is wrong (missing a +1), so Ive
> removed it, and renamed yours.

Okay, sounds good.

> Wrt superio_exit, I suspect more critical reviewers will dislike the
> use of exit_seq[] for both values to write, and addresses to write to.
>  Something like it is obviously needed for your ehf chip (or you
> wouldnt have added it).  An exit_addr_seq[] (with offsets from
> gate->sioaddr) would be clearer, and would like method-0, but would
> also be a bit bigger.
>
> Perhaps a callback is better, maybe in a union with enter/exit_seq[]s.
> I wonder what the next device will require.  Im also not thrilled by
> enter-exit-method, it influences only the exit method now, and maybe
> should be a single bit, allowing another for enter-method (if needed
> later).
> Lastly, I think exit_addr_seq[] may obsolete enter-exit-method.

Okay, agreed. A callback would make the most sense, and that's similar
to the way other bus subsystems handle driver-specific code. So I
actually like exit_addr_seq[] except that it is unnecessary for most
of the drivers. I'll think about how to do a union, but I don't know
if that is very common in kernel code, and if it's not it might be
criticized...

> Chances are poor that I'll locate hardware here that I can test upon,
> so Im somewhat limited till mid Jan.

Ok, I'm not rushed... :-)

> thanks again David,
> happy kwanzaa, etc

Happy Hannukah,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
