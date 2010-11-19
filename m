From: Ancoron Luciferis <ancoron.luciferis@googlemail.com>
Date: Fri, 19 Nov 2010 00:08:22 +0000
Subject: [lm-sensors] sensors.conf for GigaByte GA-770TA-UD3 (IT8720F rev. 8)
Message-Id: <4CE5BFF6.9050404@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090809000707070105050408"
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5BB7A.7040100@chaoslayer.de>
In-Reply-To: <4CE5BB7A.7040100@chaoslayer.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090809000707070105050408
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi *,

right away an additional config for another motherboard:

# dmidecode 2.9
SMBIOS 2.4 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Gigabyte Technology Co., Ltd.
        Product Name: GA-770TA-UD3
        Version:
        Serial Number:
        UUID: 36434630-3439-3743-4342-4245FFFFFFFF
        Wake-up Type: Power Switch
        SKU Number:
        Family:


The config is attached.

Here is some example output:

it8720-isa-0228
Adapter: ISA adapter
Vcore:           +1.22 V  (min =  +0.78 V, max =  +1.50 V)
Vdram:           +1.52 V  (min =  +1.42 V, max =  +1.57 V)
+3.3V:           +3.33 V  (min =  +3.14 V, max =  +3.47 V)
+5V:             +5.08 V  (min =  +4.76 V, max =  +5.24 V)
+12V:           +12.05 V  (min = +11.41 V, max = +12.62 V)
5VSB:            +5.03 V  (min =  +4.76 V, max =  +5.24 V)
Vbat:            +3.25 V
CPU Fan:        1691 RPM  (min = 1000 RPM)
SYS Temp:        +50.0°C  (low  = +127.0°C, high = +127.0°C)  sensor =
thermistor
CPU Casing Temp: +40.0°C  (low  = +127.0°C, high = +70.0°C)  sensor =
thermal diode


Please feel free to include this config at the list of available
motherboard configurations.


Cheers,

	Ancoron


--------------090809000707070105050408
Content-Type: text/plain;
 name="GA-770TA-UD3-sensors.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="GA-770TA-UD3-sensors.conf"

Y2hpcCAiaXQ4NzIwLWlzYS0qIgojIyMgVm9sdGFnZXMKCiAgICMgaW41IGlzIG15c3Rlcmlv
dXMuCgogICBsYWJlbCAgaW4wICAiVmNvcmUiCiAgIGxhYmVsICBpbjEgICJWZHJhbSIgICAj
ICJERFIzIiBpbiBCSU9TCiAgIGxhYmVsICBpbjIgICIrMy4zViIKICAgbGFiZWwgIGluMyAg
Iis1ViIgICAgICMgTm90IGluIEJJT1MKICAgbGFiZWwgIGluNCAgIisxMlYiCiAgIGlnbm9y
ZSBpbjUKICAgaWdub3JlIGluNgogICBsYWJlbCAgaW43ICAiNVZTQiIgICAgIyBOb3QgaW4g
QklPUwogICBsYWJlbCAgaW44ICAiVmJhdCIgICAgIyBOb3QgaW4gQklPUwogICBpZ25vcmUg
Y3B1MF92aWQKCiAgICMgVmNvcmUsIFZkcmFtLCArMy4zViBhbmQgVmJhdCBhcmUgY29ubmVj
dGVkIGRpcmVjdGx5LCBzbyBubyBjb21wdXRlCiAgICMgbGluZSBpcyBuZWVkZWQgZm9yIHRo
ZXNlLiArNVYgYW5kIDVWU0IgYXJlIGludGVybmFsIHNvIHdlIHVzZSB0aGUKICAgIyBzdGFu
ZGFyZCBzY2FsaW5nIGZhY3Rvci4gU2NhbGluZyBmb3IgKzEyViBpcyBhcHBhcmVudGx5IG5v
dCBzdGFuZGFyZCwKICAgIyBmYWN0b3IgMy45NjMgaXMgZ3Vlc3NlZCBmcm9tIEJJT1MgYW5k
IEVhc3lUdW5lIHZhbHVlcyAoMy45NDMgd2FzCiAgICMgYW5vdGhlciBjYW5kaWRhdGUuKQog
ICBjb21wdXRlICBpbjMgIEAgKiAoNi44LzEwKzEpLCBAIC8gKDYuOC8xMCsxKQogICBjb21w
dXRlICBpbjQgIEAgKiAzLjk2MywgICAgICBAIC8gMy45NjMKICAgY29tcHV0ZSAgaW43ICBA
ICogKDYuOC8xMCsxKSwgQCAvICg2LjgvMTArMSkKCiAgICMgVGhlIEJJT1Mgd29uJ3Qgc2V0
IGFueSBsaW1pdCBmb3Igdm9sdGFnZXMuCgogICBzZXQgaW4wX21pbiAgMC44MjUgKiAwLjk1
CiAgIHNldCBpbjBfbWF4ICAxLjQyNSAqIDEuMDUKICAgc2V0IGluMV9taW4gIDEuNSAgICog
MC45NQogICBzZXQgaW4xX21heCAgMS41ICAgKiAxLjA1CiAgIHNldCBpbjJfbWluICAzLjMg
ICAqIDAuOTUKICAgc2V0IGluMl9tYXggIDMuMyAgICogMS4wNQogICBzZXQgaW4zX21pbiAg
NSAgICAgKiAwLjk1CiAgIHNldCBpbjNfbWF4ICA1ICAgICAqIDEuMDUKICAgc2V0IGluNF9t
aW4gMTIgICAgICogMC45NQogICBzZXQgaW40X21heCAxMiAgICAgKiAxLjA1CiAgIHNldCBp
bjdfbWluICA1ICAgICAqIDAuOTUKICAgc2V0IGluN19tYXggIDUgICAgICogMS4wNQoKIyMj
IFRlbXBlcmF0dXJlcwoKICAgIyBUaGUgQklPUyBvbmx5IHNob3dzIDIgdGVtcGVyYXR1cmUg
dmFsdWVzOgogICAjIC0gdGVtcDE6IHRoZSBzeXN0ZW0gdGVtcHJhdHVyZQogICAjIC0gdGVt
cDI6IHRoZSBDUFUgdGVtcGVyYXR1cmUKCiAgIGxhYmVsIHRlbXAxICJTWVMgVGVtcCIKICAg
bGFiZWwgdGVtcDIgIkNQVSBDYXNpbmcgVGVtcCIKICAgaWdub3JlIHRlbXAzCgojIyMgRmFu
cwoKICAgbGFiZWwgIGZhbjEgIkNQVSBGYW4iCiAgIGlnbm9yZSBmYW4yCiAgIGlnbm9yZSBm
YW4zCiAgICMgaWdub3JlIGZhbjQgIyBkb2Vzbid0IGV4aXN0IG9uIEdBLTc3MFRBLVVEMwog
ICBpZ25vcmUgZmFuNQoKICAgIyBBZGp1c3QgZm9yIHlvdXIgb3duIGZhbnMKICAgc2V0IGZh
bjFfbWluIDEwMDAKICAgIyBzZXQgZmFuM19taW4gMzAwMAoK
--------------090809000707070105050408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090809000707070105050408--
