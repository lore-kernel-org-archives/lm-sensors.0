From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 09 Mar 2007 23:20:14 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now
Message-Id: <4dfa50520703091520j2757de2bq611afc3e7d2d2e79@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F1E8C0.6040504@assembler.cz>
In-Reply-To: <45F1E8C0.6040504@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On 3/9/07, Rudolf Marek <r.marek at assembler.cz> wrote:
> Hello all,
>
> Jean asked me to help to covert the remaining i2c-isa drivers. Situation is
> following:
>
> it87.c -  montjoie is working on it, Jean can test
> lm78.c - special ISA, Jean can test
> pc87360.c
> sis5595.c
> smsc47b397.c - I can test but bit complicated - it is a server
> smsc47m1.c
> via686a.c
> vt8231.c
> w83627hf.c - Jean can test
> w83627ehf.c - I can test on monday/sunday, passing to David right now ;)
> w83781d.c - special ISA
>
> Of course my test platform does not boot via the WOL :/  So I cant test the EHF
> driver right now. David, please can you help with that? (the request resource
> part is still missing, please check the Jean's pending patches, the patch
> compiles OK thats all I know) If you don't have time, never mind.
>
> I will try to reboot my workstation on Sunday with new kernel, but I need it
> tomorrow for for some VHDL development.
>
> Maybe others may help? If we finish this in time, we can move to pending patches
> ;) I will convert perhaps smsc47b397 tomorrow.
>
> Thanks,
> Rudolf

I'll test out the patch on my machine. Can you send the URL?

Thanks,
David

