From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040220214538.41a2f07e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yes, that's what I am after, and the suggestion above was to embed it
> in the versioning scheme itself. Which is the minimal required i2c in
> kernel for lm_sensors 2.8.4/2.8.5?

Sadly, i2c 2.8.4, although it shouldn't (the "incompatibility" comes
from new IDs, this can be avoided easily.)

> BTW I am about to build new kernels for FC1 (2.4.22 & lots of
> backports based) and would like to include 2.8.5 (currently at 2.8.2),
> will you provide an i2c patch for it again? :)

To anyone else I'd have replied "no way, I'm busy". But since this is
you... I just updated the files, go pick them and tell me how it goes :)

> (...)
> If you are referring to the kernel-i2c versioning scheme, the
> kernel-drm dependeny to XFree86 has been the patron of the above
> suggestion ;)

I guess we might consider it then... However, I still want to keep in
sync (sort of) with Linux 2.6 for now. Once the rush is behind us,
maybe...

That said, we better start with not creating unneeded dependencies with
IDs, as MDS suggested. And keeping the docs accurate too. This should
already make your life a bit easier.

Feel free to come back with your suggestion within a few months, in case
we forget about it and you're still interested.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
