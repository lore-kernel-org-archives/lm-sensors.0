From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sat, 20 Oct 2007 19:05:22 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <4dfa50520710201205i1c218afdm8c2eaa158edbde84@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> hi David,   thanks for the very helpful reply.
> sorry for delay responding

Had a laugh about the "laurel resting." Maybe I'm "pushing up
daisies." It's been a while since I posted on LM-Sensors.

>  fixed here, thanks

I realized afterward that the way w83627ehf does it is not "pc87360"
or "w83627ehf" but DEVNAME as a macro. FYI.

> rc is used in commented out code - placemarker for question - pc87360
> spec says that the sio-cmd-port is readable as well as writable, so I
> figured a write,read-back test was minimally risky (low false
> positive).  Turns out the test is nogood (false negative) on w83627hf.
> Ive dropped test here, but am soliciting input/viewpoint/thoughts on it.

Okay, here's my viewpoint: I wish every register supported read/write.
It makes multiplexing access to the registers easy.

I should have (but haven't yet) tested the commented out code in
superio_probe_reserve and figured out what works best for the EHF.
I'll get to it.

Probing and initializing the device is always the hardest part. The
rest of superio_locks.c should be a piece of cake. So it bugs me that
w83627ehf needs a custom superio_exit sequence. I'll fiddle around and
try to scratch that itch.

> nice catch & analysis - ehf is only driver using devid-mask, so its
> the model :-)
> If I drop the tilde, things should work w/o the above change

OK, I'll revert that and continue testing.

> > I don't think that is correct. We should return addr from
>
> ie diff-chunks doing a half-job on a fn-interface-change
>
> They do a 1/2-baked job changing ehf-find() sig and caller interface.
> The part not done is actually returning and assigning the addr.
> Im reverting them for now - maybe redo later as another patch
>
> Im pleased to note your wording above: "return addr from",
> that thinking is how the interface-change crept into the code..

So maybe using addr as a pointer to an int is not the best fn
interface. Returning an address from the function would be OK, since
negative values are obviously error return codes.

I'll wait for an updated patch from you, and work on the
superio_probe_reserve and superio_exit sequences, and maybe change
that function interface for w83627ehf_find(), then send back a patch.

Cheers,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
