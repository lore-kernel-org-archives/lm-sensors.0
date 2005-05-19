From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: LM77
Message-Id: <20030730121226.3685840e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030723112935.5a857970.khali@linux-fr.org>
In-Reply-To: <20030723112935.5a857970.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> We pretend to support the LM77 for years, using our lm75 driver. This
> isn't the absolute truth. The address range is shorter, the
> configuration register isn't exactly compatible, and the LM77 has two
> more registers. A LM77 would never be detected by our detection
> routine.(We use the fact that the LM75's registers cycle over 4-byte
> (well, sort of [1]) boundaries, which of course won't work with the
> LM77 since it as 6 registers.) And the lm75 module does the same check
> on load so it wouldn't load for a LM77 without the force parameter.
> 
> Suggestions:
> 
> 1* Add a different detection routine for the LM77 to sensors-detect. I
> think we can assume that the registers cycle over 8-byte [1]
> boundaries. Since cycling over 4-byte boundaries implies cycling over
> 8-byte boundaries, we would have to give it a lower confidence value
> than the LM75.
> 
> 2* Update the docs to explain the force parameter has to be used.

I guess the collective silence here means "we don't care", so I'll do
just as described above.

> 
> 3* Really support the LM77. Not sure anyone is using that chip, so
> maybe we don't have to do this part.

No support planned for now. If someone asks for it, we'll see.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
