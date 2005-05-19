From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20031112232941.5b6cab15.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> tested new sensors-detect on 4 machines.
> 2 w/ ACPI+DMI worked fine.

Typical configuration. The output doesn't even mention VPD, right?

> One with neither (iopener) gave the standard Thinkpad warning at the
> beginning.

Should not happen. This could happen if /dev/mem is unreadable for some
reason. Could you download dmidecode CVS and give a try to biosdecode?
Then edit the Makefile, remove -DUSE_MMAP, compile again and retry.
Might crash. If it does, this means I should use mmap() to access
/dev/mem in sensors-detect - although I don't even know how to do that.

Anything special about that iopener? You once sent me a copy of the BIOS
area and there's nothing strange at first sight, except that it actually
doesn't support any of ACPI, SMBIOS nor VPD.

If biosdecode works OK on it (both with and without -DUSE_MMAP), please
try to track down why system_safeness_by_vpd in sensors-detect returns
0. There are three reasons it could (you'll see in the code). The third
one is the more likely to cause problems (I think).

> On my HP ia64 machine it didn't give any ACPI or DMI info but didn't
> give the Thinkpad warning either... what's up with that?

That's the expected behavior. This is why VPD supersedes the other
methods. If ACPI or DMI isn't present, you can't conclude, while VPD
being not there *does* mean that it's not an IBM system (with the
exception of one very specific Thinkpad model).

Thanks a lot for the feedback.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
