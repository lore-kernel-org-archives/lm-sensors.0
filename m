From: Juerg Haefliger <juergh@gmail.com>
Date: Sat, 16 Jan 2010 20:23:54 +0000
Subject: Re: [lm-sensors] dme1737 datasheet
Message-Id: <191fb4ca1001161223l5bf5d42bk2da9a2ab486a40e5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1176080449.13814.51.camel@ragnarok>
In-Reply-To: <1176080449.13814.51.camel@ragnarok>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jeremy,


> Heh ok so it's a while ago... but someone wrote a watchdog driver for
> SCH311x, which I have tried to apply to DME1737, but no luck!
>
> Using superiotool to dump the registers, I can see no difference when
> BIOS has watchdog enabled/disabled.
>
> I have compared the LDN 0xa Realtime Registers with watchdog enabled vs
> disabled, and there is no difference.
>
> I tried searching Logical Device Numbers that superiotool doesn't have
> defined, but they don't seem to exist or be enabled by the BIOS,
>
> So either the motherboard has a 2nd watchdog that the BIOS uses
> (although I can't find any mention of a watchdog on nForce4 Ultra) or
> there *is* some difference between the SCH311x with public datasheed and
> the DME1737.  Maybe superiotool isn't printing the full information?  I
> am thinking of making it dump all 255 registers of all LDNs with
> watchdog enabled/disabled in BIOS, in case it's hiding in there
> somewhere.
>
> I know it's not strictly related to lm-sensors, but can anyone help?

What exactly are you looking for?

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
