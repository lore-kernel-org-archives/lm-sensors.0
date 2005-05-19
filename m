From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: bug in as99127f
Message-Id: <20030722092438.08180dee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F1C9B68.5000508@paradyne.com>
In-Reply-To: <3F1C9B68.5000508@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> we're fairly certain that PWM doesn't work in the as99127f driver
> (same old story, no datasheet). On some chips a PWM output pin is
> shared with something else, perhaps that's what is affecting temp2? Or
> more likely we are just hitting the wrong bit in the wrong register...

From my experiments yesterday, it seems that we are simply using the
wrong register. The register we are using (0x5b) really has to be a
temperature sensor type selector (just as the IT87 does). Maybe we could
ask the MBM and SpeedFan guys what they think this register is?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
