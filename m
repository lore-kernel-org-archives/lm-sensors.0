From: Ancoron Luciferis <ancoron.luciferis@googlemail.com>
Date: Fri, 19 Nov 2010 00:08:45 +0000
Subject: [lm-sensors] sensors.conf for GigaByte GA-790XTA-UD4
Message-Id: <4CE5C00D.8040900@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070607060601030308040208"
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5B8CD.4060808@chaoslayer.de>
In-Reply-To: <4CE5B8CD.4060808@chaoslayer.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607060601030308040208
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi *,

I just want to share the configuration that works nicely for the
mentioned motherboard:

# dmidecode 2.9
SMBIOS 2.4 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Gigabyte Technology Co., Ltd.
        Product Name: GA-790XTA-UD4
        Version:
        Serial Number:
        UUID: 36434630-3439-3533-3433-3734FFFFFFFF
        Wake-up Type: Power Switch
        SKU Number:
        Family:


The sensors.conf file is attached.

Here is some sample output:

it8720-isa-0228
Adapter: ISA adapter
Vcore:           +1.20 V  (min =  +0.78 V, max =  +1.50 V)
Vdram:           +1.49 V  (min =  +1.42 V, max =  +1.57 V)
+3.3V:           +3.34 V  (min =  +3.14 V, max =  +3.47 V)
+5V:             +5.11 V  (min =  +4.76 V, max =  +5.24 V)
+12V:           +11.92 V  (min = +11.41 V, max = +12.62 V)
5VSB:            +5.08 V  (min =  +4.76 V, max =  +5.24 V)
Vbat:            +3.26 V
CPU Fan:         690 RPM  (min =  300 RPM)
SYS Fan 2:       873 RPM  (min =  300 RPM)
SYS Temp:        +43.0°C  (low  =  +0.0°C, high = +50.0°C)  sensor =
thermistor
CPU Casing Temp: +27.0°C  (low  =  +0.0°C, high = +65.0°C)  sensor =
thermal diode
NB Temp:         +37.0°C  (low  =  +0.0°C, high = +55.0°C)  sensor =
thermistor


Please feel free to upload this to the available configurations.


Cheers,

	Ancoron



--------------070607060601030308040208
Content-Type: text/plain;
 name="GA-790XTA-UD4-sensors.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="GA-790XTA-UD4-sensors.conf"

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
dmFsdWVzLCBzbyB0ZW1wMSBhbmQgdGVtcDMKICAgIyBtaWdodCBub3QgYmUgYWN0dWFsbHkg
Ym90aCB1c2VkLCBhbmQgSSBkb24ndCBrbm93IHdoaWNoIG9uZQogICAjIGlzIHJlcG9ydGVk
IGJ5IHRoZSBCSU9TIGFzIHRoZSBzeXN0ZW0gdGVtcGVyYXR1cmUuCgogICBsYWJlbCB0ZW1w
MSAiU1lTIFRlbXAiCiAgIHNldCAgIHRlbXAxX21pbiAwCiAgIHNldCAgIHRlbXAxX21heCA1
MCAjIFRyb3BpY2FsIGFtYmllbnQgbWF4IHBsdXMgYSBiaXQKCiAgIGxhYmVsIHRlbXAyICAi
Q1BVIENhc2luZyBUZW1wIgogICBzZXQgICB0ZW1wMl9taW4gMAogICBzZXQgICB0ZW1wMl9t
YXggNjUgIyBCSU9TICJDUFUgV2FybmluZyBUZW1wZXJhdHVyZSIgLSA1CgogICBsYWJlbCB0
ZW1wMyAiTkIgVGVtcCIKICAgc2V0ICAgdGVtcDNfbWluIDAKICAgc2V0ICAgdGVtcDNfbWF4
IDU1ICMgQklPUyAiQ1BVIFdhcm5pbmcgVGVtcGVyYXR1cmUiIC0gMTUKCiMjIyBGYW5zCgog
ICBsYWJlbCBmYW4xICJDUFUgRmFuIgogICBpZ25vcmUgZmFuMgogICBsYWJlbCBmYW4zICJT
WVMgRmFuIDIiCiAgICMgaWdub3JlIGZhbjQgIyBkb2Vzbid0IGV4aXN0IG9uIEdBLTc5MFhU
QS1VRDQKICAgaWdub3JlIGZhbjUKCiAgICMgQWRqdXN0IGZvciB5b3VyIG93biBmYW5zCiAg
IHNldCBmYW4xX21pbiAzMDAKICAgc2V0IGZhbjNfbWluIDMwMAoKCg==
--------------070607060601030308040208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070607060601030308040208--
