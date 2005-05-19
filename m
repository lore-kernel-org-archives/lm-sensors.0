From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <1088335270.4t15bt59rqtc@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun 27 Jun 2004 03:48:32 AM CDT Jean Delvare <khali@linux-fr.org> said:

> > soekris1# sensors -s
> > soekris1# sensors
>
> Please do not run "sensors -s" right after loading the driver. Running
> "sensors" at least once before will show information that "sensors -s"
> will overwrite.

Ah, understood.

> > CPU0 Temp:    +0 C  (low  =    +0 C, high =   +70 C)
> > CPU0 Crit:   +85 C
> > CPU1 Temp:    +0 C  (low  =    +0 C, high =   +70 C)
> > CPU1 Crit:   +85 C
> > S-IO Temp:   +83 C  (low  =    +0 C, high =   +70 C)   ALARM
> > S-IO Crit:   +85 C
> > ERROR: Can't get TEMP4 data!
> > ERROR: Can't get TEMP4 overtemperature data!
> > ERROR: Can't get TEMP5 data!
> > ERROR: Can't get TEMP5 overtemperature data!
> > temp6:      -273 C  (low  =    +1 C, high =   +67 C)   ALARM
> > ERROR: Can't get TEMP6 overtemperature data!
>
> This is no good (I guess you knew that already).
>
> Do the errors happen consistently?

Yes, they do seem to be consistent.

> Can you report the values found in files
> /proc/sys/dev/sensors/pc87366-isa-6620/temp*?

Sure, attached.

> I've attached a patch to be applied against the current CVS tree. I
> didn't commit it because I don't want that much debugging in the driver
> in the long run, but that might help in your case. I really feel like
> I'm missing something obvious at some point, but can't seem to get what.
> Please apply ("patch -p0 < pc87360-debug.diff" from the lm_sensors2
> directory) and recompile (make sure you still have DEBUG=1 in the
> Makefile), then reload the driver with init=2, and watch the logs. They
> should contain much more information (or at least I hope so).

Yep, definitely quite a bit more output. Included in attachment.

> >   set temp1_min    0
> >   set temp1_max   70
> >   set temp1_crit  85
> >   set temp2_min    0
> >   set temp2_max   70
> >   set temp2_crit  85
> Please comment these lines out for now.

Done. I've also sent that email off to Soekris. Hopefully they'll respond to it
soon. Thanks much.

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: output.txt.gz
Type: application/x-gzip-compressed
Size: 744 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040627/0a8ffcca/output.txt.bin
