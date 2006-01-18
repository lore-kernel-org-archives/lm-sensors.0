From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 12:35:08 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m
Message-Id: <20060118133508.45477976.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
In-Reply-To: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Alexander,

> I have some additional information - may be it will help.
> SpeedFan (under Win2k) can detect the system and processor temperaure
> correctly  - I compared with ASUS proprietary monitor.
> Is it possible to figure out how this is done in SpeedFan?

Not really, SpeedFan is closed source so it is of little use to us. It
can tell us what information is available, but not how to get it.

Please list everything that is reported by the Asus tool and/or
SpeedFan under Windows and/or your BIOS. If we know exactly what
information we are looking for, it'll help our investugation efforts.

Are you certain that these values are taken from the W83627EHF chip and
not another chip on your board? SpeedFan should tell you if I remember
correctly. If you only have temperature reported, it may even come from
ACPI.

> Also, when I change the load, the isadump output changes in many places.

Please provide consecutive dumps without then with load, so that we can
check which register values change and how.

> My humble guess is that the EHF datasheet does not work with EHF-A.

Very unlikely, as Yuan Mu from Winbond confirmed elsewhere in this
thread. Many Winbond chips have -A top markings and are still working
just like the datasheet says.

-- 
Jean Delvare

