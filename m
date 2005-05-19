From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors without modules in the kernel
Message-Id: <20030913233451.30096fd7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
In-Reply-To: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I know you've made some good strides in making lm_sensors non
> modularized. I was able to get everything compiled into my kernel for
> my particular platform (lm_sensors-2.8 and i2c-2.8). Using kernel
> 2.4.22 and I also have compiled in the appropriate sensor driver
> (i2c-amd756). 
> 
> The only problem I am seeing is that your sensors-detect program seems
> to be hard coded for modules, when in fact everything is compiled in
> the kernel.

Having chip drivers compiled as modules is *required* for proper
detection (because scanning the bus while a driver is already using it
is generally bad and sometimes impossible). What's more, if you are
detecting, that means that you don't know what you have, so compiling
everything into the kernel, while possible, is not the best idea.

> Also the sensors program reports no sensors found.

That's a completely different problem. Is it different if you have the
very same drivers as modules instead of inside the kernel?

> A previous unsolved ticket# relating to this would be #892 and #547.
> The former being nearly identical in symptoms.
> 
> If I need to open a ticket, let me know.

The tickets are way old and probably irrelevant by the time.

You don't need to open a ticket, mailing lists are great for this kind
of problem. Simply answer the question above, from there we'll see what
we need from you.

> Sorry for bothering you directly.

That's not "directly", you're on a mailing list ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
