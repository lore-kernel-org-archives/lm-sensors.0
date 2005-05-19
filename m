From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <20050328183535.75ce8913.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325220626.4fdc613c.khali@linux-fr.org>
In-Reply-To: <20050325220626.4fdc613c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> # isadump -f 0x290 16
> WARNING! Running this program can cause system crashes, data loss and
> worse! I will probe address range 0x290 to 0x29f.
> Continue? [Y/n] Y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff 71 13 71 71 ff ff ff ff ff ff ff ff=20
>=20
> I'm convinced that those bug reports talk about my problem.

And quite rightly so. The detection code expects values at 1, 2, 3 and 7
above to be the same. It fails for 7 in your case, obviously.

So the bug was already known, and a fix is already on it's way to Linus'
tree. All you have to do is wait for it to show.

In the meantime, you can use "modprobe it87 force=9191,0x290" to skip
the detection step.

I'll update the ticket now.

--=20
Jean Delvare
