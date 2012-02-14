From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 14 Feb 2012 17:56:06 +0000
Subject: Re: [lm-sensors] acpi 4.0 power_meter doesn't get "cap" files automatically
Message-Id: <20120214175606.GF14821@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 14, 2012 at 11:05:24AM +0000, Zwolak, Cezary wrote:
> Hello,
> As You can conclude from subject I am working on "power_meter" device and I
> have couple question to the author :) I have small problem with "cap" files,
> that aren't generated automatically in /sys/devices location.  I have to
> reload power_meter module with parameter force_cap_in set, then missing files
> are generated.  My ACPI Power Meter has "HW enforced limit" and "Is HW limit
> configurable" parameters set as supported.
> 
> I think those files should be created automatically, but it seems that
> parameter cap_in_hardware  (checked in " can_cap_in_hardware" method) is set
> to FALSE.  Could You tell me when this parameter is set as TRUE? In other
> words, is there anything that I can do to get "cap" files generated
> automatically?

[adding lm-sensors@lm-sensors.org to cc]

Right now, if you want to have cap_in_hardware=1, you have to add a DMI string
to pm_dmi_table in acpi_power_meter.c.  In theory, _PMC.capabilities & 0x4
could also determine can_cap_in_hardware(), but as I recall the kernel
community didn't want to trust that the BIOS to set that bit correctly, and
that's why one either has to patch the DMI table or load the module with
force_cap_on=1 -- we were simply being cautious.

On the other hand there were zero publicly available implementations when I
wrote that driver, so if you want to send in a patch to change the decision to
be based off _PMC, go ahead.

--D

> 
> Regards,
> Cezary Zwolak
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> z siedziba w Gdansku
> ul. Slowackiego 173
> 80-298 Gdansk
> 
> Sad Rejonowy Gdansk Polnoc w Gdansku, 
> VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
> numer KRS 101882
> 
> NIP 957-07-52-316
> Kapital zakladowy 200.000 zl
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
