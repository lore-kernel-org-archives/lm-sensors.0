From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 09 Mar 2007 11:21:18 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070309112118.GC3925@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070302220454.a0c66d04.khali@linux-fr.org> <B28E9812BAF6E2498B7EC5C427F293A402021B07@orsmsx415.amr.corp.intel.com> <20070309071855.GA5148@ucw.cz> <20070309112420.42420cf2.khali@linux-fr.org> <45F13965.2030709@linux.intel.com>
In-Reply-To: <45F13965.2030709@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi!

> >>Can you take this as a wishlist item?
> >>
> >>It would be nice if next version of acpi specs supported table
> >>
> >>'AML / SMM BIOS will access these ports'
> >>
> >>...so we can get it correct with acpi4 or something..?
> >>    
> >
> >I can only second Pavel's wish here. This would be highly convenient
> >for OS developers to at least know which resources are accessed by AML
> >and SMM. Without this information, we can never be sure that OS-level
> >code won't conflict with ACPI or SMM.
> >
> >  
> BIOS vendors are not required to support latest and greatest ACPI spec. 
> So even if some future spec version
> will include this ports description, we will still have majority of 
> hardware not exporting it...

That's okay... vendors are not required to support _ACPI_, but they
mostly do. Can we get the "ports used by BIOS" table to the spec?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

