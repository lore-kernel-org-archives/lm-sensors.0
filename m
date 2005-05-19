From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: lm_sensors
Message-Id: <20031101121832.53da097f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Bios ACPI : PTLTD	
> Thinkpad T22
> DMI : 1GET31WW (1.11)

Could you please download and run vpddecode, from the dmidecode package?
http://savannah.nongnu.org/files/?group=dmidecode

This is a new tool for IBM systems identification. I plan to use it to
allow lm_sensors to be used on known-to-be-safe Thinkpads, but it hasn't
been tested heavily yet.

> It does not want to go, saying that ibm systems are known to be
> unstable with lm_sensors.
> No chance for me :)

The T22 is one of these Thinkpads with a problematic chip on it. I
suggest you forget about lm_sensors, unless you like playing with fire.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
