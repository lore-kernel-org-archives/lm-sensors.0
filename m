From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20031028220957.2ccf2481.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Great. Looks really good. I've taken out the sensors-detect part,
> > since I had already added support for the Hermes some weeks ago
> > (amazing how we came to the very same function, almost to the byte).
> > I've also fixed a few typos in the docs, reformatted things a bit to
> > conform to the project standards (if there is such a thing). I
> > obviously should have told you that part of the docs is generated
> > from the code (insmod parameters, /proc files list).
> 
> Please tell me.

Look in prog/doc, you'll find the two scripts there. I used them to
override what you had in your doc file before committing it. That way
we're sure there's no typo in there. This also provides basic code
checking, which can't hurt.

> > Still there are two things that I would like to hear you about:
> > 
> > 1* In the docs, you say that fans have a programmable divider of 1,
> > 2 or 4. I can't see how one could change that divider. Am I missing
> > something?
> 
> RPM value can be devided by 1, 2 or 4 if the ripple pre scaler is set
> to 2, 4 or 8 (see LIMITATIONS).

I'm not sure I get you. Is it because most fans return two ripples by
rotation? Anyway, that fan divisor things have always been over me, I
guess it won't change today.

> > 2* In the driver itself, the hexadecimal mask 0x9b in fscher_in()
> > would probably need some comment. The choice of that value isn't
> > obvious. Others masks are simple enough to be guessed or at least
> > trusted at first sight, but this one isn't IMHO.
> 
> The mask cares for the reserved bits 2, 5 and 6.

OK, I'll be adding a comment in your code then.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
