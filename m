From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: vt8231 and vt1211 changes
Message-Id: <20040221062231.332c67ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4036B758.4060701@verizon.net>
In-Reply-To: <4036B758.4060701@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The libsensors change is a good catch. thanks.
> The masking of the uch_config register in the 8231 and 1211 driver
> looks good, definitely harmless.

Great. For a moment, I was wondering if I had been missing something.

> I implemented temp1 and in6 and later noticed that the datasheet
> called them reserved. I never removed them from the driver though.

What about removing them now then (I mean, before we port them to Linux
2.6)? This should make them look nicer.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
