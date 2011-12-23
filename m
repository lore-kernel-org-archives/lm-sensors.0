From: In-Ho Yi <chajath@gmail.com>
Date: Fri, 23 Dec 2011 23:51:47 +0000
Subject: [lm-sensors] ITE IT8772F
Message-Id: <CAFVoeGcJ8N_DL41DzbsCOw-UVOUN7e1D42SQ1j+h66WOm0UP=Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7287725750587802195=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7287725750587802195==
Content-Type: multipart/alternative; boundary=f46d043be19a9ea62b04b4cb1906

--f46d043be19a9ea62b04b4cb1906
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear lm-sensors team,

Thank you for all the hard work to support devices. I own Shuttle SH67H3,
which is IT8772F chipset.
Following instructions for a similar chipset, I've tried modprobe it87
force_id=3D0x8721
Here is what I've got

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +42.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C=
)
Core 0:         +40.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C=
)
Core 1:         +39.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C=
)
Core 2:         +39.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C=
)
Core 3:         +40.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C=
)

it8721-isa-0a30
Adapter: ISA adapter
in0:          +0.98 V  (min =3D  +0.25 V, max =3D  +0.96 V)  ALARM
in1:          +1.56 V  (min =3D  +2.71 V, max =3D  +0.19 V)  ALARM
in2:          +1.07 V  (min =3D  +0.29 V, max =3D  +1.40 V)
in3:          +1.06 V  (min =3D  +1.04 V, max =3D  +0.00 V)  ALARM
in4:          +1.02 V  (min =3D  +0.91 V, max =3D  +1.64 V)
in5:          +2.23 V  (min =3D  +1.84 V, max =3D  +0.83 V)  ALARM
in6:          +2.23 V  (min =3D  +1.03 V, max =3D  +1.32 V)  ALARM
3VSB:         +3.29 V  (min =3D  +1.63 V, max =3D  +1.78 V)  ALARM
Vbat:         +3.24 V
fan1:           0 RPM  (min =3D  958 RPM)  ALARM
fan2:        1090 RPM  (min =3D   18 RPM)
fan3:           0 RPM  (min =3D   19 RPM)  ALARM
temp1:        +40.0=C2=B0C  (low  =3D +64.0=C2=B0C, high =3D -79.0=C2=B0C) =
 ALARM  sensor =3D
thermistor
temp2:        +44.0=C2=B0C  (low  =3D -36.0=C2=B0C, high =3D -124.0=C2=B0C)=
  sensor =3D thermal
diode
temp3:       -128.0=C2=B0C  (low  =3D  +4.0=C2=B0C, high =3D +33.0=C2=B0C) =
 sensor =3D disabled

Note that Shuttle has only one fan built in, so fan speed readings are
probably right. For all other weird readings, I get those from SpeedFan,
too.
I was able to do pwmconfig to make fan2 correlate to temp2, and it seems to
be working fine.

Kind regards,
In-Ho Yi

--f46d043be19a9ea62b04b4cb1906
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

RGVhciBsbS1zZW5zb3JzIHRlYW0sPGJyPjxicj5UaGFuayB5b3UgZm9yIGFsbCB0aGUgaGFyZCB3
b3JrIHRvIHN1cHBvcnQgZGV2aWNlcy4gSSBvd24gU2h1dHRsZSBTSDY3SDMsIHdoaWNoIGlzIElU
ODc3MkYgY2hpcHNldC48YnI+Rm9sbG93aW5nIGluc3RydWN0aW9ucyBmb3IgYSBzaW1pbGFyIGNo
aXBzZXQsIEkmIzM5O3ZlIHRyaWVkIG1vZHByb2JlIGl0ODcgZm9yY2VfaWQ9MHg4NzIxPGJyPgoK
SGVyZSBpcyB3aGF0IEkmIzM5O3ZlIGdvdDxicj48YnI+Y29yZXRlbXAtaXNhLTAwMDA8YnI+QWRh
cHRlcjogSVNBIGFkYXB0ZXI8YnI+UGh5c2ljYWwgaWQgMDrCoCArNDIuMMKwQ8KgIChoaWdoID0g
KzgwLjDCsEMsIGNyaXQgPSArOTguMMKwQyk8YnI+Q29yZSAwOsKgwqDCoMKgwqDCoMKgwqAgKzQw
LjDCsEPCoCAoaGlnaCA9ICs4MC4wwrBDLCBjcml0ID0gKzk4LjDCsEMpPGJyPkNvcmUgMTrCoMKg
wqDCoMKgwqDCoMKgICszOS4wwrBDwqAgKGhpZ2ggPSArODAuMMKwQywgY3JpdCA9ICs5OC4wwrBD
KTxicj4KCkNvcmUgMjrCoMKgwqDCoMKgwqDCoMKgICszOS4wwrBDwqAgKGhpZ2ggPSArODAuMMKw
QywgY3JpdCA9ICs5OC4wwrBDKTxicj5Db3JlIDM6wqDCoMKgwqDCoMKgwqDCoCArNDAuMMKwQ8Kg
IChoaWdoID0gKzgwLjDCsEMsIGNyaXQgPSArOTguMMKwQyk8YnI+PGJyPml0ODcyMS1pc2EtMGEz
MDxicj5BZGFwdGVyOiBJU0EgYWRhcHRlcjxicj5pbjA6wqDCoMKgwqDCoMKgwqDCoMKgICswLjk4
IFbCoCAobWluID3CoCArMC4yNSBWLCBtYXggPcKgICswLjk2IFYpwqAgQUxBUk08YnI+CgppbjE6
wqDCoMKgwqDCoMKgwqDCoMKgICsxLjU2IFbCoCAobWluID3CoCArMi43MSBWLCBtYXggPcKgICsw
LjE5IFYpwqAgQUxBUk08YnI+aW4yOsKgwqDCoMKgwqDCoMKgwqDCoCArMS4wNyBWwqAgKG1pbiA9
wqAgKzAuMjkgViwgbWF4ID3CoCArMS40MCBWKTxicj5pbjM6wqDCoMKgwqDCoMKgwqDCoMKgICsx
LjA2IFbCoCAobWluID3CoCArMS4wNCBWLCBtYXggPcKgICswLjAwIFYpwqAgQUxBUk08YnI+aW40
OsKgwqDCoMKgwqDCoMKgwqDCoCArMS4wMiBWwqAgKG1pbiA9wqAgKzAuOTEgViwgbWF4ID3CoCAr
MS42NCBWKTxicj4KCmluNTrCoMKgwqDCoMKgwqDCoMKgwqAgKzIuMjMgVsKgIChtaW4gPcKgICsx
Ljg0IFYsIG1heCA9wqAgKzAuODMgVinCoCBBTEFSTTxicj5pbjY6wqDCoMKgwqDCoMKgwqDCoMKg
ICsyLjIzIFbCoCAobWluID3CoCArMS4wMyBWLCBtYXggPcKgICsxLjMyIFYpwqAgQUxBUk08YnI+
M1ZTQjrCoMKgwqDCoMKgwqDCoMKgICszLjI5IFbCoCAobWluID3CoCArMS42MyBWLCBtYXggPcKg
ICsxLjc4IFYpwqAgQUxBUk08YnI+VmJhdDrCoMKgwqDCoMKgwqDCoMKgICszLjI0IFbCoCA8YnI+
CgpmYW4xOsKgwqDCoMKgwqDCoMKgwqDCoMKgIDAgUlBNwqAgKG1pbiA9wqAgOTU4IFJQTSnCoCBB
TEFSTTxicj5mYW4yOsKgwqDCoMKgwqDCoMKgIDEwOTAgUlBNwqAgKG1pbiA9wqDCoCAxOCBSUE0p
PGJyPmZhbjM6wqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBSUE3CoCAobWluID3CoMKgIDE5IFJQTSnC
oCBBTEFSTTxicj50ZW1wMTrCoMKgwqDCoMKgwqDCoCArNDAuMMKwQ8KgIChsb3fCoCA9ICs2NC4w
wrBDLCBoaWdoID0gLTc5LjDCsEMpwqAgQUxBUk3CoCBzZW5zb3IgPSB0aGVybWlzdG9yPGJyPgoK
dGVtcDI6wqDCoMKgwqDCoMKgwqAgKzQ0LjDCsEPCoCAobG93wqAgPSAtMzYuMMKwQywgaGlnaCA9
IC0xMjQuMMKwQynCoCBzZW5zb3IgPSB0aGVybWFsIGRpb2RlPGJyPnRlbXAzOsKgwqDCoMKgwqDC
oCAtMTI4LjDCsEPCoCAobG93wqAgPcKgICs0LjDCsEMsIGhpZ2ggPSArMzMuMMKwQynCoCBzZW5z
b3IgPSBkaXNhYmxlZDxicj48YnI+Tm90ZSB0aGF0IFNodXR0bGUgaGFzIG9ubHkgb25lIGZhbiBi
dWlsdCBpbiwgc28gZmFuIHNwZWVkIHJlYWRpbmdzIGFyZSBwcm9iYWJseSByaWdodC4gRm9yIGFs
bCBvdGhlciB3ZWlyZCByZWFkaW5ncywgSSBnZXQgdGhvc2UgZnJvbSBTcGVlZEZhbiwgdG9vLjxi
cj4KCkkgd2FzIGFibGUgdG8gZG8gcHdtY29uZmlnIHRvIG1ha2UgZmFuMiBjb3JyZWxhdGUgdG8g
dGVtcDIsIGFuZCBpdCBzZWVtcyB0byBiZSB3b3JraW5nIGZpbmUuPGJyPjxicj5LaW5kIHJlZ2Fy
ZHMsPGJyPkluLUhvIFlpPGJyPgo=
--f46d043be19a9ea62b04b4cb1906--


--===============7287725750587802195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7287725750587802195==--
