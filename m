From: Francois Gouget <fgouget@free.fr>
Date: Sun, 02 Nov 2014 21:23:12 +0000
Subject: [lm-sensors] lm-sensors config for Asus Z97-A
Message-Id: <alpine.DEB.2.11.1411022156200.12093@amboise>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463748084-84646575-1414963392=:12093"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463748084-84646575-1414963392=:12093
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Initially lm-sensors detected the sensors on my Asus Z97-A motherboard=20
without trouble but the voltages were all wrong. So I set out looking=20
for a way to convert them to proper values and I stumbled on a post by=20
Kenneth Almquist for the ASUS Vanguard B85 motherboard. It turns out the=20
configuration he posted essentially works for the Z97-A. Here's the=20
source: http://www.spinics.net/lists/lm-sensors/msg42249.html

So I'm attaching the slightly modified copy I'm using in the hope it=20
will be useful to someone else.

In particular there's a good chance it will also work for the variants=20
like the Z97-AR, Z97-C, Z97-K, Z97-Pro, Z97-Deluxe, and maybe Z97I-Plis=20
and Z97M-Plus.

Some more data points:
* If your board has a recent version of the BIOS then you will need to=20
  use 'acpi_enforce_resources=3Dlax'. It really does work.
  http://lists.lm-sensors.org/pipermail/lm-sensors/2014-September/042745.ht=
ml

* Also I read somewhere that one should be using the asus_atk0110 on=20
  recent Asus boards. However that module refuses to load so I guess I'm=20
  stuck with the NCT6791D driver.

  # modprobe -v asus_atk0110
  insmod /lib/modules/3.16-3-amd64/kernel/drivers/hwmon/asus_atk0110.ko=20
  modprobe: ERROR: could not insert 'asus_atk0110': Device or resource busy
  # lsmod | grep atk
  <nothing>

* My understanding is that the configuration file I'm posting cannot=20
  really be included in the standard configuration because other=20
  motherboards could be using the same chipset with other multipliers.=20
  But, short of the vendors coming up with a plug-and-play solution, it=20
  would be nice if motherboard-specific configuration files could be=20
  automatically selected based on the chipset + some sort of=20
  motherboard-identifying information like found in dmidecode:

  # dmidecode
[...]
       Manufacturer: ASUSTeK COMPUTER INC.
       Product Name: Z97-A
[...]

  That would make it possible to build a database and simplify the=20
  configuration.

--=20
Francois Gouget <fgouget@free.fr>              http://fgouget.free.fr/
A particle is an irreducible representation of the Poincar=E9 Group - Eugen=
e Wigner
---1463748084-84646575-1414963392=:12093
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=asus-z97a
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.11.1411022223120.12093@amboise>
Content-Description: asus-z97a.txt
Content-Disposition: attachment; filename=asus-z97a

Y2hpcCAibmN0Njc5MS0qIg0KICAgICMgRm9yIHRoZSBBc3VzIFo5Ny1BLiBC
YXNlZCBvbjoNCiAgICAjIGh0dHA6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMv
bG0tc2Vuc29ycy9tc2c0MjI0OS5odG1sDQoNCiAgICBsYWJlbCBpbjAgIkNQ
VSBWY2MiDQogICAgICAgICMgJ0NQVSBJbnB1dCBWb2x0YWdlJyBpbiBVRUZJ
DQogICAgICAgIGNvbXB1dGUgaW4wICBAICogMiwgQCAvIDINCg0KICAgIGxh
YmVsIGluMSAiKzVWIg0KICAgICAgICBjb21wdXRlIGluMSBAICogNSwgQCAv
IDUNCiAgICAgICAgc2V0IGluMV9taW4gNSAqIDAuOTUNCiAgICAgICAgc2V0
IGluMV9tYXggNSAqIDEuMDUNCg0KICAgICMgRnJvbSBkcml2ZXI6IGxhYmVs
IGluMiAiQVZDQyINCiAgICAgICAgc2V0IGluM19taW4gMy4zICogMC45NQ0K
ICAgICAgICBzZXQgaW4zX21heCAzLjMgKiAxLjA1DQoNCiAgICAjIEZyb20g
ZHJpdmVyOiBsYWJlbCBpbjMgIiszLjNWIg0KICAgICAgICBzZXQgaW4zX21p
biAzLjMgKiAwLjk1DQogICAgICAgIHNldCBpbjNfbWF4IDMuMyAqIDEuMDUN
Cg0KICAgIGxhYmVsIGluNCAiKzEyViINCiAgICAgICAgY29tcHV0ZSAgaW40
ICBAICogMTIsIEAgLyAxMg0KICAgICAgICBzZXQgaW40X21pbiAxMiAqIDAu
OTUNCiAgICAgICAgc2V0IGluNF9tYXggMTIgKiAxLjA1DQoNCiAgICAjIGlu
NTogdW5rbm93bg0KDQogICAgbGFiZWwgaW42ICJjb3JlIDMiDQogICAgICAg
IGNvbXB1dGUgaW42IEAgKiAyLCBAIC8gMg0KDQogICAgIyBGcm9tIGRyaXZl
cjogbGFiZWwgaW43ICIzVlNCIg0KICAgICMgRnJvbSBkcml2ZXI6IGxhYmVs
IGluOCAiVmJhdCINCiAgICAjIEZyb20gZHJpdmVyOiBsYWJlbCBpbjkgIlZj
b3JlIg0KDQogICAgbGFiZWwgaW4xMCAiR1BVIg0KDQogICAgbGFiZWwgaW4x
MSAic3lzIGFnZW50Ig0KICAgICAgICAjICdDUFUgU3lzdGVtIEFnZW50IFZv
bHRhZ2UgT2Zmc2V0IE1vZGUgU2lnbicgaW4gVUVGSQ0KDQogICAgbGFiZWwg
aW4xMiAiY29yZSAyIg0KICAgICAgICBjb21wdXRlIGluMTIgQCAqIDIsIEAg
LyAyDQoNCiAgICBsYWJlbCBpbjEzICJjb3JlIDEiDQogICAgICAgIGNvbXB1
dGUgaW4xMyBAICogMiwgQCAvIDINCg0KICAgIGxhYmVsIGluMTQgImNvcmUg
MCINCiAgICAgICAgY29tcHV0ZSBpbjE0IEAgKiAyLCBAIC8gMg0KDQogICAg
bGFiZWwgZmFuMSAiRmFuIDEiDQogICAgbGFiZWwgZmFuMiAiQ1BVIGZhbiIN
CiAgICAgICAgIyBUaGUgY29ycmVwb25kaW5nIHB3bSBhbHNvIGNvbnRyb2xz
IHRoZSAnQ1BVIE9wdCcgZmFuDQoNCiAgICBsYWJlbCBmYW4zICJGYW4gMiIN
CiAgICBsYWJlbCBmYW40ICJGYW4gMyINCiAgICBsYWJlbCBmYW41ICJGYW4g
NCINCiAgICBsYWJlbCBmYW42ICJDUFUgZmFuIDIiDQogICAgICAgICMgJ0NQ
VSBPcHQnIGhlYWRlcg0K

---1463748084-84646575-1414963392=:12093
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463748084-84646575-1414963392=:12093--
