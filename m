From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <1077809666.403e12020f2a2@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225111219.1c117787.komoriya@paken.org>
In-Reply-To: <20040225111219.1c117787.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Takeru KOMORIYA <komoriya@paken.org>:

> > Do not initialize it explicitely to 0. It's done for you (if I'm
> > not mistaking).
> 
> OK, I think update_vbat should be the same then.

Correct.

> According to the datasheet, voltage scan, temperature channels and
> fan tachometers are disabled at reset. We can enable temperature
> channels from user-space, but not for voltages and thachometers.

This would mean that the reset option of the 2.4 driver is unusable at
the moment (since it would also disable all readings)?

> So I think we should keep initializations for voltages and
> thachometers, even if reset option is not given, because it may not
> be guaranteed that these are always set by BIOS(especially if
> hardware monitor features are disabled by BIOS settings).

This could be done on purpose by the BIOS. For example, the BIOS could
know that a given voltage input isn't wired on the motherboard, and
disable that particular input. I regret that we would lose this
information if we were to force all inputs on by default.

Maybe we could first check whether all voltage inputs and tachometers
are disabled. If they are (which is the case after a reset), enable
them all. If not, don't touch anything. That way, we would respect the
choices of the BIOS in the case they are correct.

This is only a suggestion, you might not agree with it.

> > The only thing that should be kept (and has been in 2.4) is the
> > monitoring start, of course (with or without reset). That said, I
> > think that the 0xb7 mask is wrong and should be 0x36 (that too
> > should be verified with the datasheets).
> 
> I looked into the datasheet and I think 0x36 is the right
> value(though 0xb7 may not cause problems).

Correct. It simply sounds better to me, expecially because we have no
way to write a 1 to bit 7 anymore. Since we retrieve the configuration
register value right after a reset, I was thinking that under some
conditions, the bit 7 could be still high at that moment. This would
make us reset the chip twice, and possibly lose the values we were
trying to write to the other bits. I agree that this isn't supposed to
be possible, but being safe doesn't cost us anything here.

> > Aligato.
> 
> Wow, you speak Japanese! Aligato!

Not really. I think I know three words: "ushi", "dicho" and "aligato".
Only the last one is obviously usable on a regular basis ;) My
grilfriend, on the other hand, knows quite a bit of Jananese, and we
like watching original Japanese animation videos together.

> @@ -825,77 +828,24 @@
>  /* Called when we have found a new IT87. It should set limits, etc.
> */

The second part of this comment doesn't make sense anymore.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
