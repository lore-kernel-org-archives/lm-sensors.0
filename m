From: Jordan <xero@xeron.cc>
Date: Sun, 15 Apr 2007 18:58:54 +0000
Subject: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <20070415185853.GA11766@xeron.cc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have a MSI 975x Platinum, which uses the w83627dhg. This one here:

http://www.msicomputer.com/product/p_spec.asp?model=975X_Platinum_(Limited_=
Edition)&class=3Dmb

I've applied the DHG patch to my kernel (2.6.20) but I'm currently having s=
ome
issues controlling the fan speeds. I've tried pwmconfig as well as manually
echoing some values to pwm1-4 and pwm1-4_enable. It does correctly control
my case fans, but it doesn't seem to have any effect over my CPU fan. I am
using one of the new 4 pin cpu fans.

My bios has a "smart fan" option for the CPU fan which does work correctly,
although this option is not very configurable in the BIOS, it's only an=20
on/off switch with no way to control the temperature that it raises the fan
speed at. I found an actual picture of the BIOS screen for reference:
http://www.hardocp.com/images/articles/1168231380Rzv7IS7G0U_2_15_l.gif

I was hoping to be able to control the CPU fan speed through lm_sensors ins=
tead.
Disabling the smart fan in the bios leaves the fan running at full speed, b=
ut
this doesn't seem to make a difference, pwm1-4 continue to have no effect on
the fan speed. Any ideas?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
