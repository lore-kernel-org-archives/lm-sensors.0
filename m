From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: SOLVED: Ticket #1409
Message-Id: <20031002223441.4d936495.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I wonder however, would it be possible to include a refined version of
> the address detection code in the module?  I am willing to try to
> write it myself, but I won't do it unless I know it has some remote
> possibility of being included.

Thanks a lot for reporting your findings. It will hopefully help some
other folks someday.

Here are the possibilities:

1* Add address 0x0d00 to sensors-detect.
2* Add address 0x0d00 to it87.
3* Add your code to it87.
4* Add what you found to the it87 doc.
5* Distribute your program into lm_sensors.

I'm not easy with ISA chips, since I only wrote I2C chip drivers so far.
I know that ISA is typically a little bit more dangerous, but I don't
know to which extent. I'd like to hear other people about that. I don't
even understand what you code does (or, more precisely, how it does it)
but it looks interesting. Is there a chance we could use it for
something less specific than your own case? (in other words, how
A7N8X-VM specific is it? how it8712F-specific?)

I really don't know wether it's better to just add the new address to
the list, or include your detection code in some way.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
