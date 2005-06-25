From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 25 Jun 2005 09:52:14 +0000
Subject: [lm-sensors] lm78 fan speeds have too high minimum
Message-Id: <20050625095139.0805f2b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050624220454.GI8920@dbz.icequake.net>
In-Reply-To: <20050624220454.GI8920@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ryan,

> > Setting the correct "set fanN_min" lines in the lm78-* section of
> > the /etc/sensors.conf and running "sensors -s" afterwards should do.
> 
> Yes, this fixed it.  Would it make sense to add fanX_min prototypes to
> the lm78 section, since at least my chip seems to have incorrect
> minimums?

Good idea, I just added them.

> I wonder if anyone else with lm78 has noticed this.

I don't have the problem on mine, the LM78 chip comes up with a low
limit of 0 RPM for unconnected fans and 1997 RPM for connected ones,
which is fine. Maybe the BIOS of my motherboard (Asus TX97-E) sets the
limits that way.

-- 
Jean Delvare
