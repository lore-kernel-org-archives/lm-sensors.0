From: cedric <cedric321@hotmail.fr>
Date: Sat, 21 Feb 2015 18:03:18 +0000
Subject: [lm-sensors] Address Port chip IT8620E
Message-Id: <BLU436-SMTP13606C23E77219C144F9B1A902B0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090100070809040104030404"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--------------090100070809040104030404
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I see that lm-sensors.org have no datasheetfor chip IT8620E.

Because in0 and in4, i think, is badly displayed with modeprobe it87 
option force_id=0x8728
I contacted gigabyte-support and they gived me a little table.

I'm not qualified to use this table and i hope she can be useful.

Thank you.
Goodbye.


The table:

9.5.2.1    Address Port (Base+05h, Default=00h)

20h    |    R    |    -    |    VIN0 Voltage Reading Register
21h    |    R    |    -    |    VIN1 Voltage Reading Register
22h    |    R    |    -    |    VIN2 Voltage Reading Register
23h    |    R    |    -    |    VIN3 Voltage Reading Register
24h    |    R    |    -    |    VIN4 Voltage Reading Register
25h    |    R    |    -    |    VIN5 Voltage Reading Register
26h    |    R    |    -    |    VIN6 Voltage Reading Register

--------------090100070809040104030404
Content-Type: text/plain; charset="UTF-8"; name="table - IT8620e - h97mhd3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="table - IT8620e - h97mhd3"

OS41LjIuMQlBZGRyZXNzIFBvcnQgKEJhc2UrMDVoLCBEZWZhdWx0PTAwaCkKCjIwaAl8CVIJ
fAktCXwJVklOMCBWb2x0YWdlIFJlYWRpbmcgUmVnaXN0ZXIJCjIxaAl8CVIJfAktCXwJVklO
MSBWb2x0YWdlIFJlYWRpbmcgUmVnaXN0ZXIKMjJoCXwJUgl8CS0JfAlWSU4yIFZvbHRhZ2Ug
UmVhZGluZyBSZWdpc3RlcgoyM2gJfAlSCXwJLQl8CVZJTjMgVm9sdGFnZSBSZWFkaW5nIFJl
Z2lzdGVyCjI0aAl8CVIJfAktCXwJVklONCBWb2x0YWdlIFJlYWRpbmcgUmVnaXN0ZXIKMjVo
CXwJUgl8CS0JfAlWSU41IFZvbHRhZ2UgUmVhZGluZyBSZWdpc3RlcgoyNmgJfAlSCXwJLQl8
CVZJTjYgVm9sdGFnZSBSZWFkaW5nIFJlZ2lzdGVyCg==
--------------090100070809040104030404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090100070809040104030404--
