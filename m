From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <000801c4982a$038cbd20$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> ----- Original Message -----=20
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "Leif W" <warp-9.9@usa.net>
> Cc: <sensors@Stimpy.netroedge.com>
> Sent: Saturday, September 11, 2004 03:18
> Subject: Re: Support DB Entry 1770
>
> Attached is a modified patch that will make the failure more verbose.
> Please revert the previous patch, apply this one, and test again.
>
> The patch will also ignore the step 2 error, so that we can see
whether
> or not this is the only step failing.


<defiant> [2004-09-11@13:54:07] ~ -> modprobe w83781d

=3D> /var/log/syslog <=3D
Sep 11 13:54:10 defiant kernel: i2c-core: driver w83781d registered.
Sep 11 13:54:10 defiant kernel: i2c_adapter i2c-0: found normal isa
entry for adapter 9191, addr 0290
Sep 11 13:54:10 defiant kernel: i2c_adapter i2c-0: Detection of w83781d
chip failed at step 2 (0x61 !=3D 0x60)

> Alternatively, you can try to load the w83781d module with the
> "force=9191,0x290" parameter and see how it goes. This should skip all
> the detection steps.

Tried  this, "sensors" still says "No sensors found!"  First two syslog
lines are same as above, minus the third "failed" line.
"sensors-detect" still detects the chip.  Have been applying these two
patches to a kernel configured with no PM whatsoever, no ACPI, ISA PnP
disabled in the kernel.

Leif


