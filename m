From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: it87 & Asus A7V8X-X
Message-Id: <20040417194709.7572c90e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404171549.i3HFnfn00517@SilverHaven.dnsalias.net>
In-Reply-To: <200404171549.i3HFnfn00517@SilverHaven.dnsalias.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> A suggested Asus A7V8X-X -specific fix to be included in the sample 
> /etc/sensors.conf file as an MB-specific comment:
> 
> The IT87 chip on Asus A7V8X-X seems to report the VCORE voltage
> approximately 0,05 volts higher as the board's BIOS does. I had the
> opportunity to check this with two CPUs, and while the amount is not
> exact, it seems to be a working fix for Athlon XP 1600+ and Athlon XP
> 2500+ on this motherboard. So I managed to correct this by setting a
> line
> 
> compute in0 -0.05+@ , @+0.05
> 
> in /etc/sensors.conf
> 
> I have little idea of the meanings of the compute line, and I'm not
> saying the formula is correct, but this did work for me.

We had a previous report that seems to confirm that:
http://archives.andrew.net.au/lm-sensors/msg04456.html

I also found this report:
http://archives.andrew.net.au/lm-sensors/msg02813.html
but it's less relevant.

This is very strange however. I can't get the reason why Asus did this.
And, more importantly, I can't see how they would have done that
physically. I suspect that Asus is reporting a voluntarily bad value in
their BIOS setup screen. I already caught them doing this for
temperatures, so after all, why not voltages...

I will insert your comment (edited) in our default sensors.conf file.

Thanks for reporting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
