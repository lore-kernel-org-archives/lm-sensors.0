From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 03 Mar 2007 15:47:21 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D6DDCE.5050803@assembler.cz> <20070228213803.GA4877@ucw.cz>
	 <20070301152655.f232db64.khali@linux-fr.org>
	 <20070302114023.GD2163@elf.ucw.cz>
	 <20070302114747.GB1212@srcf.ucam.org>
	 <20070302151055.d2665d66.khali@linux-fr.org>
	 <20070302141840.GA3441@srcf.ucam.org>
	 <20070302220454.a0c66d04.khali@linux-fr.org>
	 <20070302211251.GA10035@srcf.ucam.org>
	 <20070303105316.d51e032d.khali@linux-fr.org>
In-Reply-To: <20070303105316.d51e032d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>, Rudolf@atrpms.net

Hi Jean,

> Is there anything preventing us from doing such a walk and pre-allocate
> all the I/O ranges? I am not familiar with the ACPI code at all, would
> you possibly propose a patch doing that?

Here's a random idea -- what do you think of it?

ACPI already allocates some I/O ranges, which was a surprise to me:

> My machine looks like this:
>
> 1000-107f : 0000:00:1f.0
>  1000-1003 : ACPI PM1a_EVT_BLK
>  1004-1005 : ACPI PM1a_CNT_BLK
>  1008-100b : ACPI PM_TMR
>  1010-1015 : ACPI CPU throttle
>  1020-1020 : ACPI PM2_CNT_BLK
>  1028-102b : ACPI GPE0_BLK
>  102c-102f : ACPI GPE1_BLK

For I/O and memory that ACPI accesses and has not reserved, the AML
interpreter could allocate at run-time.

I'm not sure how to implement exactly. For example, it would be bad to
have a /proc/ioports that had a lot of single ports allocated, for
example:
1000-107f : 0000:00:1f.0
 1000-1000 : ACPI PM1a_EVT_BLK
 1001-1001 : ACPI PM1a_EVT_BLK
 1002-1002 : ACPI PM1a_EVT_BLK
 1003-1003 : ACPI PM1a_EVT_BLK

Thus the AML interpreter would need to have some reasonable
intelligence when allocating regions. Conflict resolution would also
be more difficult, e.g. if a hwmon driver was loaded first and then
acpi as a module, ACPI could not allocate the region. Maybe run-time
allocating won't work.

And then, how would ACPI release a region after it has used it? The
easiest method would be to never release anything used even once.

Thoughts?

David

