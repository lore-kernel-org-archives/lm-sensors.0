From: wipwap19@hotmail.com (Warren Wilder)
Date: Fri, 24 Feb 2006 19:51:45 +0000
Subject: [lm-sensors] Can't access procfs/sysfs file  - 2.6.14.6
Message-Id: <BAY115-F2032313B519534D280592CCFF30@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have noticed others had this problem, but it turned out to be some=20
configuration issue. Hopefully this is the case for me as well. I am=20
slightly worried that I have to wait for the 'eeprom' module, which my Via =

VT1211 chip seems to need.

My system:  (Via SP13000)
HLFS (Hardened Linux From Scratch) with kernel 2.6.14.6
sysfs compiled and mounted

running sensors-detect notifies me of these required modules:
i2c-viapro
i2c-dev
I can succesfully load both.

When I run sensors I get this notice:
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!

The thing is, I haven't build libsensors with sysfs support, since the=20
INSTALL and QUICKSTART files inform me of not having to do anything, beside=
s=20
'make user and make user_install' if I have a 2.6 kernel with i2c modules=20
compiled.
Since I also have udev on my system I am leaning towards missing some sort =

of udev rule.

Please inform me of the next step.

Warren

_________________________________________________________________
Don=92t just search. Find. Check out the new MSN Search!=20
http://search.msn.click-url.com/go/onm00200636ave/direct/01/


