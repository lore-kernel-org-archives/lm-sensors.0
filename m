From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 11 Aug 2006 09:05:57 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <20060811110557.0da9ee0c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Jean Delvare wrote:
> > 
> > (As a side note, our sensors-detect script still doesn't know about the
> > uGuru. Don't you want to add support for it? Or is it just too
> > dangerous because of the non-standard I/O addresses?)
> 
> I don't know what else could be behind those addresses, so thats not the 
> reason I haven't worked on adding it to the script yets. The real 
> problem is that the current detection code in the driver could very well 
> miss-detect. The only good way of doing detection would be todo a proof 
> read. A better idea would be to use dmidecode and sue the info from 
> there, atleast for Abit motherboards this info seems sane. I could do 
> that if you want me to (as time permits).

I don't really care myself, but that would probably bring you some more
testers. Indeed checking that the board is an Abit board would make
some sense. Not only in sensors-detect, but also in the driver itself.

-- 
Jean Delvare

