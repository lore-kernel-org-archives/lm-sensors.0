From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Ticket 1382 : Update
Message-Id: <1063655328.5201.29.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
> Did you try loading the LM80 driver? I wonder if the values would make
> sense.
> 
> Sorry, I can't tell you what it is if it isn't a LM80.

The values make no sense at all, I have no idea what this chip is. I
guess it's another case of "Nevermind" ;)

>> The thing is, since I'm clueless at C, I don't know if the readings
>> output by sensors when questioning the via686a are processed with any
>> of these fits.
>
>Looks like there are, or why would they be in the module code?

Well, the fact that the linear fit was included in the remarks and not
in the code itself sortof confused me. Now that I've read the whole
thing again, I realize that the fit were in fact used to create the
values for the look up tables. Another "nevermind" !

But the readings *do* look better now. I'll probably investigate that a
bit, maybe with some help from Gigabyte (they actually answer tech
support, unbelievable...). By the way, VIA has released a guide and a
small utility to "enable the hardware monitoring functions for VIA
southbridge chips VT82C686B and VT8231, and Low-Pin-Count Super I/O chip
VT1211". I thought I could find anything useful in there, but no joy.
Maybe you guys will!

Best,
Romain
