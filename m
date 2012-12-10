From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Mon, 10 Dec 2012 18:40:07 +0000
Subject: [lm-sensors] Fried CPU?
Message-Id: <201212101840.qBAIe73K013644@mx1.lsn.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0000_01CDD6D3.7CDB4200"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01CDD6D3.7CDB4200
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I fear I know the answer to this question before I ever ask it, but I'm
going to ask anyway, just in case there is a better answer out there.

	I purchased a used AMD Phenom II x 6 CPU and installed it along with
a water cooling system in one of my servers.  It was working perfectly,
except that the sensors binary evidently does not support alarms for the
atk0110-acpi-0 interface, so I could not trivially implement a shutdown =
in
the case of cooling failure, and like an idiot I didn't take the time to
write an interface at the time.  I put it on the back burner.  =
Unfortunately
that burner was the CPU itself and it was lit three weeks later when the
cooling pump failed while I was at work.  I came home to a CPU whose
temperature was 101=B0C, and had failed processing several times during =
the
day.  Most of the fluid was boiled away inside the coolant feed tubes, =
and
had I been gone longer, the CPU temp would have gone through the roof.  =
In
any case, I pulled the water cooler and put the old aluminum fin cooler =
back
on.  The system came up, and seemed to work fine for a couple of more =
weeks,
except that the atk0110-acpi-0 sensors were not quite stable.  I did not
have a monitor on them previously, so had no way to know if this were an
artifact of the CPU's having been excessively hot for a time, or not.  =
When
the replacement pump finally came in, I once again installed the water
cooler and brought the system up.  It only worked for a few minutes, and
then shut itself down, because the monitor was saying the CPU was
ridiculously hot.  It was difficult to even get it to bring up the BIOS, =
but
after letting the system sit without power overnight, I was able to get =
it
back up and disable the monitor before it shut down the system again.

	Processing seems stable, but the chip is reporting absurdly high
temperatures to the sensors command.  At first boot, it reported a
reasonable 36=B0C in the BIOS, but after coming up fully, the sensors =
command
is reporting temperatures of 429496652.5=B0C.  It is interesting the =
chip
reported a correct temperature to the BIOS, but that `sensors` is =
reporting
garbage.  I did run the `sensors-detect` command prior to shutting the
system down in order to check something.  My forlorn hope is that may =
have
caused some issue or that there is some other software fix for this.  I
could run it without CPU temperature monitoring, but with an active =
cooling
system, that does not seem wise.  (Hind sight is 20/20!)  I suppose I =
could
rig an external temperature probe.  The motherboard does have external
thermal sensor inputs, but the case of the waterblock is plastic, making =
the
measurement of the CPU temperature with a thermistor problematical.

	Is it at all possible this CPU is not fried, or that there is some
software work-around?

------=_NextPart_000_0000_01CDD6D3.7CDB4200
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
U0VUSEVSRUlTQUJFVFRFUkFOU1cAAAAACTU=

------=_NextPart_000_0000_01CDD6D3.7CDB4200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_0000_01CDD6D3.7CDB4200--

