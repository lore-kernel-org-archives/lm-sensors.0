From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <1075368241.4018d131f0799@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Chew Hong Gunn <hgchew@gunnet.org>:

> Do note that these comments are due to the original code that I was
> not involved in.  I simply ported it over to 2.6 kernel accordingly.
> Since the chip specification is not available anymore, I can only
> comment based on what I think the code is doing and from
> doc/chips/gl518sm.

Same here. I'm only discovering the code and was quite surprised that is
is so different from other chip drivers. Haven't read the docs nor data
sheet yet, but this will probably be required.

Note that we *do* have a copy of the data sheet, here:
http://www2.lm-sensors.nu/~lm78/pdfs/gl518sm_r117.pdf

(This shows how important it is to centralize the data sheets as we get
them, so that they survive manuacturer's website evolutions.)

> As for the threaded method of reading the values, it would be up to
> team to decide whether to remove or keep it.  I will update the code
> accordingly.

I think I understand why this was done that way. This makes the driver
much more complex however. I have no strong opinion as to wether we
should keep it that way or simplify it.

One possible replacement is to simply keep two different bufferization
timings (as this is already the case) for fast registers and slow ones.
Voltages don't change much as far as I can tell (as opposed to
temperatures, and fans that can break silently). If the PSU breaks,
it's likely that you'll notice that before sensors has a chance to tell
you.

So I'd be perfectly happy with a driver simplification, especially since
I don't know anything about threads. And a simplified driver is anyway
better than no driver at all.

But if someone with enough knowledge of threads can handle the problem
and ensure that the code is clean enough to enter the 2.6 kernel tree,
it's OK too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
