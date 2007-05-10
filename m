From: Dieter Rogiest <dieter.rogiest@telenet.be>
Date: Thu, 10 May 2007 16:36:31 +0000
Subject: [lm-sensors] =?iso-8859-1?q?Athlon_64_X2_Dual_core=3ACore0_17=B0C?=
Message-Id: <200705101836.31464.dieter.rogiest@telenet.be>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

My cpu is an Athlon 64 X2 Dual core 5600+.
I installed lm_sensors-2.10.2 on Mandriva Linux 2007.1.

When I run sensors I get these temperatures:
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +17=B0C
Core1 Temp:
             +25=B0C

How come temperature of Core0 is so low? Does this mean that Core0 is not u=
sed=20
by my kernel (uname -r: 2.6.20.11-tmb-desktop-1mdvsmp )?
What programs should I use so that Core0 is also used
Are there shell commands by which I can let Core0 and Core1 work to their=20
maximum?=20

Dieter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
