From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 14 Jul 2008 15:21:39 +0000
Subject: [lm-sensors] [PATCH RESEND] lm-sensors: Add more chip detection
Message-Id: <191fb4ca0807140821o178d234ya4ac09e65666efd4@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_42120_6831916.1216048899977"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_42120_6831916.1216048899977
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add detection of VIA VT1212 and SMSC EMC2700LPC Super IOs.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>

---
Fixed to include both possible device IDs of the VT1212.



On Fri, Jul 11, 2008 at 8:45 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Fri, 11 Jul 2008 07:50:02 -0700, Juerg Haefliger wrote:
>> > Hi Jean,
>> >
>> >
>> >> Hi Juerg,
>> >>
>> >> Please set the attachment type to text/plain next time.
>> >
>> > Hmm... Gmail doesn't give me control over this (I think) and I haven't
>> > change anything. Weird.
>
> You may try adding .txt at the end of the file name to hint gmail at
> giving it type text/plain. Or complain to the gmail admins until they
> map .patch to type text/plain.
>
>> >> On Thu, 10 Jul 2008 12:37:26 -0700, Juerg Haefliger wrote:
>> >>> Add detection of VIA VT1212 and SMSC EMC2700LPC Super IOs.
>> >>>
>> >>> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>> >>
>> >>> Index: lm-sensors-3.0.0/prog/detect/sensors-detect
>> >>> ===================================================================
>> >>> --- lm-sensors-3.0.0.orig/prog/detect/sensors-detect  2008-07-10 12:16:17.709353000 -0700
>> >>> +++ lm-sensors-3.0.0/prog/detect/sensors-detect       2008-07-10 12:28:41.895364000 -0700
>> >>> @@ -1666,6 +1666,11 @@
>> >>>       devid => 0x77,
>> >>>        },
>> >>>        {
>> >>> +     name => "SMSC EMC2700LPC Super IO",
>> >>> +     # no datasheet
>> >>> +     devid => 0x67,
>> >>> +      },
>> >>> +      {
>> >>>       name => "SMSC FDC37B72x Super IO",
>> >>>       driver => "not-a-sensor",
>> >>>       devid => 0x4c,
>> >>> @@ -1908,6 +1913,11 @@
>> >>>       alias_detect => sub { vt1211_alias_detect(@_); },
>> >>>        },
>> >>>        {
>> >>> +     name => "VIA VT1212 Super IO Lite",
>> >>> +     driver => "not-a-sensor",
>> >>> +     devid => 0x3f,
>> >>
>> >> Are you sure? On Wilken's system, which according to the documentation
>> >> has a VT1212 chip, sensors-detect says:
>> >>
>> >> Found unknown chip with ID 0xfc01
>> >>
>> >> Which would mean a devid value of 0xfc rather then 0x3f.
>> >
>> > From the datasheet (sorry for the formatting):
>> > 7   Configuration Index   RW   00
>> > 20   Device ID   RO   3F
>> > 21   Device Revision   RO   01
>> > 22   Power Down Control   RW   00
>> > 23   LPC Wait State Select   RW   09
>> > 24   GPIO Port 1 Pin Select   RW   00
>> > 25   GPIO Port 2 Pin Select   RW   00
>>
>> I just realized that there's two different device IDs for the two
>> packaging options, 3F/3E. I'll respin the patch.
>
> None of which matches what Wilken's system has... Very strange.
>
> --
> Jean Delvare
>

------=_Part_42120_6831916.1216048899977
Content-Type: application/octet-stream;
	name=sensors-add-more-chip-detection.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fin7y0gy0
Content-Disposition: attachment; filename=sensors-add-more-chip-detection.patch

SW5kZXg6IGxtLXNlbnNvcnMtMy4wLjAvcHJvZy9kZXRlY3Qvc2Vuc29ycy1kZXRlY3QKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQotLS0gbG0tc2Vuc29ycy0zLjAuMC5vcmlnL3Byb2cvZGV0ZWN0L3NlbnNvcnMtZGV0ZWN0
CTIwMDgtMDctMTAgMTI6MTY6MTcuNzA5MzUzMDAwIC0wNzAwCisrKyBsbS1zZW5zb3JzLTMuMC4w
L3Byb2cvZGV0ZWN0L3NlbnNvcnMtZGV0ZWN0CTIwMDgtMDctMTQgMDg6MTY6MDUuNDUyNzMwMDAw
IC0wNzAwCkBAIC0xNjY2LDYgKzE2NjYsMTEgQEAKIAlkZXZpZCA9PiAweDc3LAogICAgICAgfSwK
ICAgICAgIHsKKwluYW1lID0+ICJTTVNDIEVNQzI3MDBMUEMgU3VwZXIgSU8iLAorCSMgbm8gZGF0
YXNoZWV0CisJZGV2aWQgPT4gMHg2NywKKyAgICAgIH0sCisgICAgICB7CiAJbmFtZSA9PiAiU01T
QyBGREMzN0I3MnggU3VwZXIgSU8iLAogCWRyaXZlciA9PiAibm90LWEtc2Vuc29yIiwKIAlkZXZp
ZCA9PiAweDRjLApAQCAtMTkwOCw2ICsxOTEzLDE2IEBACiAJYWxpYXNfZGV0ZWN0ID0+IHN1YiB7
IHZ0MTIxMV9hbGlhc19kZXRlY3QoQF8pOyB9LAogICAgICAgfSwKICAgICAgIHsKKwluYW1lID0+
ICJWSUEgVlQxMjEyIFN1cGVyIElPIExpdGUiLCAgICMgaW4gMTAwIHBpbiBUUUZQIHBhY2thZ2UK
Kwlkcml2ZXIgPT4gIm5vdC1hLXNlbnNvciIsCisJZGV2aWQgPT4gMHgzZSwKKyAgICAgIH0sCisg
ICAgICB7CisJbmFtZSA9PiAiVklBIFZUMTIxMiBTdXBlciBJTyBMaXRlIiwgICAjIGluIDQ4IHBp
biBMUUZQIHBhY2thZ2UKKwlkcml2ZXIgPT4gIm5vdC1hLXNlbnNvciIsCisJZGV2aWQgPT4gMHgz
ZiwKKyAgICAgIH0sCisgICAgICB7CiAJbmFtZSA9PiAiV2luYm9uZCBXODM2MjdIRi9GL0hHL0cg
U3VwZXIgSU8gU2Vuc29ycyIsCiAJZHJpdmVyID0+ICJ3ODM2MjdoZiIsCiAJZGV2aWQgPT4gMHg1
MiwK
------=_Part_42120_6831916.1216048899977
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_42120_6831916.1216048899977--
