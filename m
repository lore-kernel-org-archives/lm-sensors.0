From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Sun, 26 Aug 2012 19:32:34 +0000
Subject: Re: [lm-sensors] doubt about assignments of the thermal sensors to their physical location
Message-Id: <20120826193234.GA29093@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <503A78A7.9020205@gmx.de>
In-Reply-To: <503A78A7.9020205@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Aug 26, 2012 at 09:27:35PM +0200, Toralf F=F6rster wrote:

> for a ThinkPad T420 (model 4180-f65) running at a stable Gentoo w/
> kernel 3-5.3 I'm wondering, if the kernel (module thinkpad_acpi) + the
> package  sys-apps/lm_sensors-3.3.1 works fine together wrt to the
> assignments of the thermal sensors to their physical location.

thinkpad-acpi isn't involved here. The core temperatures are all coming=20
from the CPU itself.

> I'm wondering why the 2 cores of the "Intel(R) Core(TM) i5-2540M CPU @
> 2.60GHz stepping 07" doesn't have the same temperature of 43=B0C and
> "Physical id 0:" has the other (different) value of 40=B0C.

The two cores can be different temperatures. The physical id 0 value is=20
the package temperature, which will typically just be the highest of the=20
core temperatures.

--=20
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
