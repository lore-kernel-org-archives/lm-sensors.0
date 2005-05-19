From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040104211933.29fe8657.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> To really do it properly, it needs to be aware of 2.4 vs. 2.6, due to
> the fact that the ridiculous PCI device unhiding happens at driver
> load in the former, at bootup in the latter.
> 
> I.e. if we only had 2.6 to worry about, i2c-sis96x would have a single
> PCI device entry in the table and detection would be nice and generic
> like all the rest.
> 
> Instead, what I should do is yank all the sis96x and sis5595 entries
> (because that misdetects all 96x) out of that table and write a
> special- purpose function for detecting them properly.
> 
> I'm not a perl wizard (in fact I dislike perl) so I'm inclined to just
> list both devices and attack the rest later, if ever.

If you provide the data and explain to me what I should do with them, I
can do the work for you. I'm not a perl wizard either, but in fact I
like perl pretty much ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
