From: linux_user98765@yahoo.com (linux_user98765@yahoo.com)
Date: Sat, 18 Jun 2005 08:35:38 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Debian Packages:
lm-sensors-2.9.1_2
kernel-image-2.6.11-1-686

HP Pavilion A1020N Desktop PC
ASUS PTGD-LA (Goldfish3) OEM Motherboard
http://h20000.www2.hp.com/bizsupport/TechSupport/Document.jsp?objectID=C003=
61570&prodTypeId=12169&prodSeriesIdC3919&locale=3Den_US

ASUS A8000 Sensor Chip
http://vip.asus.com/forum/bbs.aspx?board_id=3D1&SLanguage=3Den-us

# lspci -n

0000:00:00.0 0600: 8086:2580 (rev 04)
0000:00:02.0 0300: 8086:2582 (rev 04)
0000:00:1b.0 0403: 8086:2668 (rev 03)
0000:00:1c.0 0604: 8086:2660 (rev 03)
0000:00:1d.0 0c03: 8086:2658 (rev 03)
0000:00:1d.1 0c03: 8086:2659 (rev 03)
0000:00:1d.2 0c03: 8086:265a (rev 03)
0000:00:1d.3 0c03: 8086:265b (rev 03)
0000:00:1d.7 0c03: 8086:265c (rev 03)
0000:00:1e.0 0604: 8086:244e (rev d3)
0000:00:1f.0 0601: 8086:2640 (rev 03)
0000:00:1f.1 0101: 8086:266f (rev 03)
0000:00:1f.2 0101: 8086:2651 (rev 03)
0000:00:1f.3 0c05: 8086:266a (rev 03)
0000:02:01.0 0c00: 1106:3044 (rev 80)
0000:02:02.0 0200: 10ec:8139 (rev 10)
0000:02:05.0 0780: 11c1:048c (rev 03)

# i2c-detect 0

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2e XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

(`i2cdump 0 0xXX` for above attached)


Lastly, Everest Home Edition
(http://www.lavalys.com/products/overview.php?pid=3D1&lang=3Den) detects
the following:


Sensor
* Asus A8000 (SMBus 2Eh)

Temperature
* Motherboard
* CPU
* /dev/hda
* /dev/sda

Fans
* CPU
* Chasis (Case)

Voltages
* CPU Core
* +2.5 V
* +3.3 V
* +5 V
* +12 V
* VTR


TIA!


	=09
____________________________________________________=20
Yahoo! Sports=20
Rekindle the Rivalries. Sign up for Fantasy Football=20
http://football.fantasysports.yahoo.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump_log
Type: application/octet-stream
Size: 6209 bytes
Desc: pat1069775445
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050617=
/f9d8fc97/i2cdump_log-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-detect_log
Type: application/octet-stream
Size: 8057 bytes
Desc: pat1210933812
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050617=
/f9d8fc97/sensors-detect_log-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lsmod
Type: application/octet-stream
Size: 3726 bytes
Desc: pat95937310
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050617=
/f9d8fc97/lsmod-0001.obj
