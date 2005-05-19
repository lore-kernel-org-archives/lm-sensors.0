From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Ticket 1382 : Update
Message-Id: <20030913222128.58f023c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> I noticed that there's a linear fit in the via686a.c, in the temp
> conversion section, in the remarks.
> The way I understand it, the linear fit is actually valid within a
> short range of temperatures, while the 5th degree polynomial is
> actually more accurate for the whole range.

That's not the way I understand it. the 5th degree polynomial is valid
for interger (that is, 7-bit) readings, and the linear interpolation is
made for the 3 extra bits (value .125 degree). So the whole range has
the same average accuracy.

> The thing is, since I'm clueless at C, I don't know if the readings
> output by sensors when questioning the via686a are processed with any
> of these fits.

Looks like there are, or why would they be in the module code?

> I tried applying the linear fit in the common temp range (temp = val x
> 0.427 + 32.08) in gkrellm, and behold! the readings *look* better.
> Now, I don't know if it's just a coincidence, or if it's actually the
> way it should work.
> I'd really appreciate your comments on that one.

I think it is a coincidence. Either formula should be used, not both.
Our formula, derived from Alex van Kaam's one (the author of Motherboard
Monitor), is supposed to be better than the linear fits.

Anyway, if you get something better that way, why not...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
