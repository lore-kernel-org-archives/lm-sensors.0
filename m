From: bartonbosch@SoftHome.net (Barton Bosch)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: Ticket #1963 solution + further info
Message-Id: <426DD728.6040200@SoftHome.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks for the tip re: resetting the smbus after a hang, it did the=20
trick.

In the time after I posted ticket #1963 I continued working on=20
installing and configuring lm_sensors for 2.6.10-1.771_FC2 & matrox=20
g450 dual head.  As it turns out the big prob is that while=20
sensors-detect does find the sensors chips, it's way off on its=20
config suggestions.

The script wants these modules loaded:

MODULE_0=3Di2c-matroxfb
MODULE_1=3Di2c-isa
MODULE_2=DDcmon
MODULE_3=3Dw83627hf


i2c-matroxfb is uneeded and creates the problem with the smbus and=20
blanked screens, and the ddcmon module which is non-existent.

The correct configuration for lm_sensors with matrox/2.6.10/FC2 is=20
to modprobe the i2c-isa (which autoloads i2c-sensor and i2c-core)=20
and w83627hf and then running sensors -s;  all of this can be placed=20
in /etc/rc.local, and that's it.

Now figuring out how to get sensors-detect to correctly report that=20
is another matter altogether but that's not my place, <g>.


HTH,

Barton
--=20
Food brings benefit for some hours, clothes for some months but=20
wisdom lasts as long as the mind itself.  It is the foundation of a=20
better society.       -- Anonymous Tibetan source
