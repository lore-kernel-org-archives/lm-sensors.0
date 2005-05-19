From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c kernel patch issue with bttv-if module
Message-Id: <20030717202455.50d27376.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F16DAEA.1060802@themattpad.com>
In-Reply-To: <3F16DAEA.1060802@themattpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have no idea who the right person is for this sort of email, however
> I trust someone will forward it on to the right person.

I am the one (yeah, I love saying that) and I'm already there so no need
to forward.

> I applied your new i2c patch (i2c-2.8.0) to a virgin 2.4.21 kernel
> with zero issues. However during the build process I die at the same
> point in the middle of the bttv modules. The bummer is I still love my
> bttv card and can't stand to part with it.
> 
> Perhaps there's something missing from the patch.

Which patch or set of patches did you applied exactly? (complete URI
wanted)

I am running a bttv card myself, with a patched 2.4.21 kernel, and it
works rather well. However, the source tree is the one I made the
changes on and extracted the patches from, so if I forgot to extract
one, it could explain the problem you had.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
