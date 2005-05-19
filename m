From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: ddcmon module improved
Message-Id: <20030804111546.50d5ba60.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030801223858.75729d65.khali@linux-fr.org>
In-Reply-To: <20030801223858.75729d65.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> looks good.
> guess there was a bug in the model number code? I see it changed...

Yes, there was a bug, which BTW I had fixed some days before. The module
was thinking the 4 bytes were to be decoded to letters, while only the
two first are (giving three letters) while the two last are plain hexa
and not meant to be decoded (or to decimal, but no more).

I also fixed the horizontal and vertical refresh rates, which were wrong
most of the times because the code to locate it was defective, and told
sensors not to display zero values (which simply means that the data is
unavailable).

Now I am wondering wether we should display the Established timings in
sensors or not. OHO, it occupies up to 6 lines, which is much. OTOH, it
may be useful for people that have no idea which resolutions and refresh
rates their screen can handle. OTTH, I am not sure this data is very
reliable. One of my screen repports it can handle 800x600 at 56, 60 and
75Hz, but not 72Hz. Some screens report only the higher frequency they
support for some or all resolutions, while other reports all modes they
support. I also saw modes in standard timings that were already in the
established timings list (which is useless and should not happen).

Any opinion anyone?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
