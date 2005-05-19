From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm75 compute
Message-Id: <20031028225159.7c65c941.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F9C884D.93E32BDA@paradyne.com>
In-Reply-To: <3F9C884D.93E32BDA@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> ----------------------------
> revision 1.77
> date: 2002/11/08 12:06:53;  author: khali;  state: Exp;  lines: +119
> -94(Khali) Add section for lm75 in sensors.conf.eg
>         Complete the lm78 section in sensors.conf.eg
> ----------------------------

BTW, note that the change was almost one year old and this is the first
person complaining AFAIK. It might be that the LM75 is so old that it's
not used anymore. But it could as well mean that I am not the only one
needing that scaling.

> I wouldn't have changed an existing configuration, but it happens that
> the LM75 had no section at that time, so I simply made one based on
> the only board I had with a LM75 on it - an Asus TX97-E.
> 
> Now I admit that what's said on ticket 1423 is plain right. The LM75
> cannot be configured in any way, so I hardly can understand how the
> reported temperature could require scaling. On the other hand, which
> chip would it be on my TX97-E, if not a LM75? There's also a LM78 on
> that board, so it sound rather logical that the other monitoring chip
> would be from National Semiconductor too.
> 
> I'll open the case and take a look, in case I'm able to see the
> monitoring chips.

I did that and could see the chips. There *is* a real LM75 right under
the CPU socket. My guess is that the LM75 is not designed to accurately
measure a CPU's temperature, so Asus placed it in such a location that
multiplying the original value by two would give a correct approximation
of the CPU's temperature. This means that I should not trust the
reported value too much - although it *is* related to how much heat the
CPU generates, whatever the actual value is.

Whatever, the LM75's value *needs* to be scaled by 2 on my system to
match what the BIOS screen reports. This is why I changed the
configuration file the way I did. Sorry for the trouble, had I read the
LM75 datasheet before doing that, I'd have understand it wasn't making
sense at all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
