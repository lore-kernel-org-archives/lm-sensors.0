From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: I2C parallel port adapters drivers
Message-Id: <3FAD8C45.E872D1C0@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031102132342.79920c6f.khali@linux-fr.org>
In-Reply-To: <20031102132342.79920c6f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I agree with your analysis.

Back when I tried to figure out what was what,
there was almost nothing in doc/ about them.
 
I documented what I could in the following places:
	the bottom of doc/summary
	doc/i2c-pport
	doc/i2c-velleman

Please enhance these docs as you learn more about the drivers.
Any parallel port module that doesn't have documentation
about how to connect electrically is pretty worthless :)

Seems like direct access should be avoided,
using the parallel port layer may make it work better
on non-PC architectures.

mds




Jean Delvare wrote:
> 
> > hi,
> > sorry for the late answer.
> 
> No problem. After all, you're the first one to answer, too ;)
> 
> > you're right, the drivers are very similar, and typically you will
> > only use one of them. It is of course possible to integrate them all
> > into one physical module, which you are free to do :) This is more or
> > less grounded on historic reasons far back in the development of the
> > driver where I introduced the different hardware access
> > implementations to accomodate the different implementations (and this
> > went eventually into the kernel...).
> >
> > So I'd say, go ahead and code :)
> 
> OK, I'll write a unified driver then. Just one more question. Any reason
> to prefer direct I/O access (ELV/Velleman) over parallel-port-style
> programming (i2c-philips-par)? I'd say that the second is preferable,
> but you might have had a reason to use direct access, that I ignore. If
> not, I'll somehow use i2c-philips-par as a base for my unified driver,
> which I'll probably call i2c-parport (since it won't be Philips-specific
> anymore). That driver would support Philips adapters, ELV, Velleman and
> ADM evaluation boards (I have one here for testing).
> 
> Thanks a lot for spending some time replying.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
