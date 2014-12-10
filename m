From: "Pablo Jose Royo" <pjroyo@teltronic.es>
Date: Wed, 10 Dec 2014 16:04:35 +0000
Subject: [lm-sensors] Is w83627ehf driver working with lm-sensors?
Message-Id: <003a01d01492$fe2458c0$fa6d0a40$@es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi

I have a Nexcom vehicular console running Ubuntu 14.04 LTS (x86_64) with
voltage monitoring enabled in BIOS. I=B4m using both 3.13.0-32 and 3.13.11.=
10
x86_64 kernels, with winbond w83627ehf driver (loaded using modprobe
force_id=3D0x8850)=20

I need to check when input voltage is low in order to shutdown the system in
proper way. Using lm-sensors from the distribution, or from last source, i
always see same values in all voltage sensors (Vcc, CPU,..etc) . I mean,
there is no CHANGE in it when I vary input voltage from a variable power
supply (with constant current limit to emulate a battery). My
/etc/sensor3.conf is Ok for this chip. Temperature sensors seem to work with
this driver (and with coretemp).=20

Do you know if lm-sensors works with this driver? What more could I check?
In sources, I see last date shown is 2012, so it seems quite recent.

Thank you!



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
