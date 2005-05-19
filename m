From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: compile bug workaround (ticket 1344)
Message-Id: <20031028223052.7f9310c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031026224736.GA6514@avalon.gci.net>
In-Reply-To: <20031026224736.GA6514@avalon.gci.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Well, the bug is fixed in our latest release (2.8.1) anyway.
> 
> That's good, but I run kernel 2.4.21, and I use bttv, so I needed
> the i2c kernel patch.

Oh, OK, I understand now.

> Kernel 2.4.22 has a patch for i2c-2.8.1, but
> for some reason, kernel 2.4.21 only has a patch for i2c-2.8.0.

The reason is that I had no time to backport the i2c-2.8.1 patch to
2.4.21. And I'd expect people compiling kernels by themselves to use the
latest stable sources available, that is, 2.4.22 for now. This is the
reason why I did not feel like wasting my time packporting the patch.

> So at this point, anyone running kernel 2.4.21 will be stuck with
> version 2.8.0.

That said, the backport would be rather easy (it's just a matter of
repackaging all the correct files in one convenient patch), so I might
consider doing it if it might help people like you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
