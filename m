From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sun, 23 Apr 2006 18:19:39 +0000
Subject: [lm-sensors] Kernel fault from ACPI when using W83627EHG
Message-Id: <4dfa50520604231119q2e776654s42403c066680dfae@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060420235351.9D72212ED4@bluewhale.planbit.co.uk>
In-Reply-To: <20060420235351.9D72212ED4@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

I take that back. You've got the registers set right. Well, there are
other places where the bits can be disabled, but I wonder if the DSDT
of your ACPI polls the alarms on the w83627ehf to monitor it. It
wouldn't surprise me.

David

On 4/23/06, David Hubbard <david.c.hubbard at gmail.com> wrote:
> Hi Roger,
>
> On 4/23/06, Roger Lucas <roger at planbit.co.uk> wrote:
> > Well, I think I made the correct changes.
> >
> >         CONFIG (addr 0x40) = 0x01
> >         OVT (addr 0x18) = 0x43
>
> I think you need to set CONFIG to 0x00.
>
> >
> > ... but it doesn't change the behaviour.
> >
> > I've posted a similar message to the ACPI mailing list to see if they can
> > shed any light on it...
> >
> > Thanks anyhow, it was definitely worth trying.
> >
> > - Roger
>
> There are other bits worth trying too, but maybe you just want to grab
> the datasheet and look around?
>
> Anyway, good luck!
> David
>

