From: Florian Schwade <florian.schwade@googlemail.com>
Date: Sun, 09 May 2010 20:19:11 +0000
Subject: [lm-sensors] No temperature output with k10temp for AMD II X3 435
Message-Id: <4BE718BF.4080101@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,
I have an AMD II X3 435 cpu. Sensors-detect successfully detects the=20
k10temp module is needed.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           Success!
     (driver `k10temp')
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No


I also checked that it is loaded correctly.

[florian@errorkiste ~]$ lsmod |grep k10temp
k10temp                 2827  0

If I run sensors to get the temperature the output is just:

[florian@errorkiste ~]$ sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +21.0=B0C  (high =3D +70.0=B0C)

21=B0C is impossible to be the correct temperature. The BIOS reports my=20
CPU running at something like 36=B0.
The Kernel is: 2.6.33-ARCH
lm-sensors version: lm_sensors 3.1.2-1

I would appreciate any help. Thanks a lot!
Regards

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
