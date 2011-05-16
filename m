From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, 16 May 2011 10:58:55 +0000
Subject: Re: [lm-sensors] Feature request: smsc47b397 (SCH5307-NS)
Message-Id: <BANLkTi=+DatvKLU=Rt7hUb3aRAdhmcFNWA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTi=+PGMPhMWz9vQA3v90vBRFvrnnYg@mail.gmail.com>
In-Reply-To: <BANLkTi=+PGMPhMWz9vQA3v90vBRFvrnnYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Andrew,


> Could someone please tell me what it would take to gain PWM control via t=
his
> chip?=A0 A proper data sheet from SMSC?

That would certainly help. I'll ask my contact at SMSC.


> Are there other techniques I could
> try or that others have worked on?
>
> The chip is used in my HP workstation and seems not to adapt fan RPM to C=
PU
> temperatures, whatsoever.

Which model is this?


> My understanding is that this should be done
> automatically at the BIOS/chip level, but it is not.

What makes you think it should? Is this feature mentioned somewhere in
the doc of the server? If it's handled by the BIOS, then there
usuallly are some controls in the BIOS. Never heard of a machine that
does automatic fan control without providing some knobs through the
BIOS. If your BIOS doesn't have any, it's unlikely, that there is HW
supported fan control.

...Juerg


> Thus my search for a
> driver + userspace solution.
>
> Thanks,
> Andrew
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
