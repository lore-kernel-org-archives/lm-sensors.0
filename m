From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Sat, 03 Mar 2007 15:50:49 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070303155048.GA22755@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302151055.d2665d66.khali@linux-fr.org> <20070302141840.GA3441@srcf.ucam.org> <20070302220454.a0c66d04.khali@linux-fr.org> <20070302211251.GA10035@srcf.ucam.org> <20070303105316.d51e032d.khali@linux-fr.org> <4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
In-Reply-To: <4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Hubbard <david.c.hubbard@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>, Rudolf@atrpms.net

On Sat, Mar 03, 2007 at 08:47:21AM -0700, David Hubbard wrote:

> For I/O and memory that ACPI accesses and has not reserved, the AML
> interpreter could allocate at run-time.

Not ideal. ACPI's already fiddling with ranges that have been reserved 
by other drivers.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org

