From: Bob Jurkowski <su_pyrow@yahoo.com>
Date: Thu, 05 Nov 2009 22:38:07 +0000
Subject: [lm-sensors] Dell 4600C, cannot read any sensors
Message-Id: <249591.49138.qm@web110305.mail.gq1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have googled for months... I still have no way of reading any sensors.
I am running Slackware 12.2 running a 2.6.31.1 kernel-huge. the bios does n=
ot have a sensor page.

Tried lm_sensors, it detects "SMSC LPC47M10x/112/13x Super IO Fan Sensors" =
with confidence 9


modprobe smsc47m1


smsc47m1: Found SMSC LPC47M10x/LPC47M112/LPC47M13x
ACPI: Device needs an ACPI driver
i have tried the kernel parameter


acpi_enforce_resources=3Dlax
this removes the "cannot insert modules / device busy" error message

and then dmesg gives:

smsc47m1: Found SMSC LPC47M10x/LPC47M112/LPC47M13x
ACPI: I/O resource smsc47m1 [0xc00-0xc7f] conflicts with ACPI region LEDX [=
0xc5d-0xc5e]
ACPI: Device needs an ACPI driver
smsc47m1 smsc47m1.3072: Device not configured, will not use


I have never heard or have any idea of "LEDX", i've searched, and nothing c=
omes up related to what im looking for.

The thing that tells me there has to be something is, when I didn't properl=
y have the heat sink seated correctly, I got thermal messages...

Something along the lines of "thermal temperature/normal"
and this would repeat: 2,000 times, 2,300 times (literally) and fill my "me=
ssages" log (300MB) worth of this stuff, ONLY when the CPU hits 100% say i =
was recompiling my kernel, it would just fill the log. even though it was s=
aying "normal" which was false, it had to be getting the data from somewher=
e!

all I'm after is CPU temp. the above tells me there has to be something tel=
ling it that there is an event or something happening.

/proc/acpi
$> ls
. dsdt fadt power_resource thermal_zone
.. embedded_controller fan processor video
button event info sleep wakeup

all the fan/thermal_zone/power_resource dirs, are empty
processor/CPU0 have "info limit power throttling" but have nothing indicati=
ng any type of sensor.

oh and running isadump shows no mercy of my pleas.


isadump -k 0x55 0x2e 0x2f 0xa
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 10 using bank register 0x07.
Continue? [Y/n]
0 1 2 3 4 5 6 7 8 9 a b c d e f
00: 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 59 00 38 00 44 00 2e 00 00 00 00 00 00 00 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


thats all i got, let me know if theres anything im missing.




-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.5 (GNU/Linux)

mQGiBEYIa3YRBACeJPMe8yvuTSYMnFGsf2T77uSFtZJWP1akPQ1KsEMoIs+rwErm
TYubfnS67oF6R/lNzFhLXhuabGdcCvfUpBQnT83jQaDK2M9L0AFOSB8mpa1fnGTi
5C/WpOz1cycKQuHyaDn365HLv0YuCzruhC2ZDreSDJYbWxBwulX0N/lKZwCgxdIq
USff9dvpjGhmmJEteDa8L3EEAII/6SAuiTt5qDhzyRuo00eDt8RX4dzR1No04cPg
geSdiMpV/OHOHcqTAZ83If0j58h7K/oVpf7Ko9iC5rkr3FDiJlN+ldrtkf0moAdI
Mbn/bqIfMh1IH8uGB5GKb3gCEhEsUmZ7zv9Eq/D5orupuKaLY1GRIjlNB44u47Mi
NOXdBACTKxOvIzH5YIg7uqoGShQCOQdUKiwxK0R94ELhEFdmWgNhBcpGVy7I+JVL
ggstbaOFSJwk7ioQQcwxUOWmQRAJpD+CLOtdNB60fC779wnwyLDeHR7eYvFql0df
ZhsK93uTLDHEl2UEOD3RIO8kDOGynhpvaJE7+M+w+xUXjmOYj7QiQm9iIEp1cmtv
d3NraSA8c3VfcHlyb3dAeWFob28uY29tPohgBBMRAgAgBQJGCGt2AhsjBgsJCAcD
AgQVAggDBBYCAwECHgECF4AACgkQ0wQdaBjjhFKX7ACfabntG64NTWiWs8hzCvNn
kMfIDkAAn0e6CHmi9KhzIgV6AxbFe3XZkI65uQENBEYIa3cQBADX9wpaIi2a2f4f
Sm/baTaIkEJcvsnimTIIZz6tYW08bXxjtbRCJppRTGkPWmWBI2aMdI4BnutNm36g
NQStP1F5I2zw7xRNycY+r1KKuQvwc9+5K8JKhAMF6H2FkD8eBnwLk7Mx2Ry6cphE
UKFUqigyHXN147WKu7YiNtWJHMpHcwADBQP+N9l33ZFtXVF9Ruy8VGlgoEVHZdr4
AiIO5osRtzafsrfZnVV14gYk8i4q8whGoJLevRQ7840s21Sz8upvWCAqL3gLf6Ha
z8ggnaK6t/0nH8wAZjRSPoK6bFlwwpvUUdiD4iz2UfpvaNCRGCfzd6iyTAI/HHYB
JF0wWTd0SsIYwK6ISQQYEQIACQUCRghrdwIbDAAKCRDTBB1oGOOEUmoTAJ4zhvbs
amik8fmRDxZFYCYAuOo+XgCfeMHpptGHecfQbacY4J6lnzUyrz0=A3oW
-----END PGP PUBLIC KEY BLOCK-----


     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
