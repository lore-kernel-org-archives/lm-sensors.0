From: forest@alittletooquiet.net (Forest Bond)
Date: Wed, 21 Mar 2007 15:51:03 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway 627FWE1G
Message-Id: <20070321155103.GD19205@storm.local.network>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I am getting what appear to be incorrect temperature readings for the CPU on a
627FWE1G mainboard, which has an F71805F.  The other two temperatures appear to
be reasonable, but the CPU temperature appears to be low (although it does seem
to scale appropriately in response to CPU burn-in, momentarily disconnecting the
fan, etc.).

From the documentation:

--------------------------------------------------------------------------------
All temperature channels are external, there is no embedded temperature
sensor. Each channel can be used for connecting either a thermal diode
or a thermistor. The driver reports the currently selected mode, but
doesn't allow changing it. In theory, the BIOS should have configured
everything properly.
--------------------------------------------------------------------------------

I'm wondering if the BIOS did not configure the sensor properly, although
the sensors program reports that the sensor is configured as a diode (which, I
believe, is correct).

Is it possible that the diode is not characterized correctly?

I have a technical contact at Jetway that may be able to assist.  Should I
pursue this as a BIOS issue, or ought I seek information with regard to how the
circuit is physically wired?

Any input you can provide is appreciated.  I am actually using this information
as a means of characterizing the vt1211 wiring on VIA EPIA boards with the same
CPU.  If I can get the information I need, I will be happy to pass it all along
to the lm-sensors project.

thanks,
Forest
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070321/ab7f5a11/attachment.bin 
