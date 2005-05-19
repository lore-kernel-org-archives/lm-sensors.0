From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: issue with IT87 on Asus
Message-Id: <421756D0.50504@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1108697448.42156168bbec2@www.usherbrooke.ca>
In-Reply-To: <1108697448.42156168bbec2@www.usherbrooke.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

try playing with the fan control settings as described in doc/chips/it87

Luke Munholand wrote:
> Hi,
>=20
> First off, I'd like to say thanks to you for writing such a great program=
.=20
> Works great on my i810 chipset on the other computer.  This computer is a
> different story though....
>=20
> I'm hoping for a couple hints that will help me get my darned fans to tur=
n off
> (turn slower)!  I have used the windows program "speedfan" which detects =
and
> controls my fan1 (CPU) properly.  From Speed Fan:  ITE 8712F super IO.  I=
SA bus
> $0290 linked ISA bus @ $0D00  ... IT8712F/IT8705F at $D00
>=20
> I have an Asus A7N8x-VM/400 motherboard that lm_sensors "sensors-detect"
> correctly detects has a IT8712F chip on the ISA bus.
>=20
> link to motherboard:
> http://www.asus.com/prog/spec.asp?m=A7N8X-VM/400&langs=01
>=20
>=20
> SUMMARY OF PROBLEM
> 1. I patched 2.9.0.1 and compiled i2c for my 2.4.29 kernel (stock slackwa=
re
> 10.1)
> 2. I tried to compile lm_sensors-2.9.0 but got errors (even after doing l=
dconfig
> -v) *weird*
> 3. I downloaded the most recent "daily" cvs snapshot which compiled and it
> compiled and installed properly.
> 4. "sensors-detect" correctly identified the IT87 chip.
> 5.  lm_sensors2/prog/pwm/pwmconfig cant seem to stop the fan1?  it says:
>=20
> ------------------------------------------------------------
> Warning!!! This program will stop your fans, one at a time,
> for approximately 5 seconds each!!!
> This may cause your processor temperature to rise!!!
> If you do not want to do this hit control-C now!!!
> Hit return to continue:
>=20
> Testing pwm control it8712-isa-0d00/pwm1 ...
>   it8712-isa-0d00/fan1 ... speed was 4166 now 4166
>     no correlation
>=20
