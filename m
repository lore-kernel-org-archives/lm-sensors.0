From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 09 Feb 2007 17:06:54 +0000
Subject: [lm-sensors] VT1211 sensors.conf: other CPUs?
Message-Id: <191fb4ca0702090906k52c31153vfda98a2abb415c7e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070208194910.GE18906@storm.local.network>
In-Reply-To: <20070208194910.GE18906@storm.local.network>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Forest,


> What is the preferred method for adding support for other CPUs?

There is none :-)


> The Ezra cores
> aren't shipping anymore, so most EPIA boards (i.e., most boards using thi=
s Super
> I/O chip) have Nehemiah cores of one kind or another.  It would seem ther=
e are
> two options:
>
> 1. Get the appropriate CPU documentation from VIA, if available.

Been there, done that. I tried to get information from them for the
vt1211 internal thermal diode and the Nehemiah CPU but they couldn't
provide any.
From VIA: "After checking with our engineers, I'm sorry to tell you
that we don't have further update for the V1211 internal thermal diode
and the C3 Nehemiah CPU."


> 2. Try to measure the die temperature by approximation from some surface
>    temperature.  Take some data points, and estimate the offset.

Been there too, done that too :-) But I didn't trust my results, they
were offseted for some reason. What I can remember is that the
calculated gain from these results matched the gain of the other VIA
CPUs so I'm confident that we can assume that the gain is identical.


> 3. Really wing it, and take a trial-and-error approach, nudging the offset
>    iteratively until the resulting temperature results look reasonable.

Hmm... And how do you define 'reasonable'?

There's a 4th option: Using windows to get the temp and fix the offset
in Linux to match the windows reading. That's probably the easiest way
if you have windows running on one of these machines and a tool that
can read the temp (and trust it). Fire up a CPU stresser like
cpuburn-in, let it sit until the system reaches a thermal steady state
and measure the CPU temp. Then fire up Linux, run cpuburn-in and read
the temp via sensors and adjust the offset accordingly.

As a sanity check, you can then slow the CPU down (via cpuspeed or the
likes) and the temp should drop down linearly. Or almost that is,
since not all parts of the CPU slow down when you drop the core freq.
But it should give you an indication if your numbers are in the right
ballpark.

...juerg



> I am not inclined to belive that the documentation mentioned in (1) is wi=
dely
> available, or that it exists at all.  Is (2) feasible?  (3) is obviously =
not a
> great way to go, but if anyone has suggestions for increasing accuracy I'=
m all
> ears.
>
> Any assistance would be appreciated; I have access to a variety of boards
> utilizing this chip.  I would be more than happy to contribute informatio=
n I am
> able to pick up.
>
> thanks,
> Forest
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
>
> iD8DBQFFy362RO4fQQdv5AwRAgVuAJ91bniGWSkvi3r3A3RnR0VJvp3H9wCfc8pG
> 1LxGUqCIggYKywD1QnYRGKA> =9AH7
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

