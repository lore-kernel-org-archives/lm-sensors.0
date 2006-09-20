From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 20 Sep 2006 16:16:47 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060920181647.5255dba7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> > Expected, as the W83627DHG doesn't have this voltage input. You'd need
> > to edit the script to skip in9 completely.
> 
> I just noticed this morning that in the BIOS setup at the top of one of the
> pages it says "Configure Win627EHF Super IO Chipset".  I had not noticed
> that before (perhaps it wasn't there before, I just updated my BIOS to the
> latest one).
> 
> Anyway, that doesn't appear to be the same chip, does it?

It is the same chip, for sure. But this chip has many functions, so the
menu might be to setup other functions rather than the hardware
monitoring functions.

-- 
Jean Delvare

