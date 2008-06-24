From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Tue, 24 Jun 2008 13:16:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <76366b180806240616t296e5239gafb29a6db17d42d9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_20076_26749979.1214313390773"
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
To: lm-sensors@vger.kernel.org

------=_Part_20076_26749979.1214313390773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, Feb 24, 2008 at 11:43 AM, Jean Delvare <khali@linux-fr.org> wrote:

> As a side note, I think it's rather weird that the IT8712F rev. J (and
> later) do default to 8-bit fan speed values while they no longer
> support fan clock dividers. As these revisions of the chip are not
> backward compatible with the older revisions, ITE should really have
> switched to a saner default.
>

Yes, strange.. see below.

>> The it8712 chip type now enables 16-bit fan tachometer reading to get
>> proper readings. The register used in the it8712old chip type no longer
>> has the same meaning in rev 8 of the chip.
>
> Which register are you talking about please?

If you compare the PDF documents here:
http://www.ite.com.tw/product_info/PC/Brief-IT8712_2.asp

v0.8.2 shows 9.6.2.2.12 Fan Tachometer Divisor Register (Index=0Bh,
Default=09h) using bits 0-6 for the divisors. This version corresponds
to revisions of the chip < 0x8.

v0.9.1 & v0.9.3 show the same register having bits 0-5 reserved and
6-7 are the PWM Smoothing Step Frequency Selection. This version
corresponds to revisions of the chip >= 0x8.

Since those bit ranges overlap, I don't see how they could be
preserving the "old" behavior. They could have done that if bits 0-6
were reserved, but the new meaning of bits 6-7 overlaps the old FAN3
divisor. Strangely, both revisions say they have a default value of
09h. (Documentation error?)

>> Also, a new module param array enable_fans is added. This was needed to
>> get fan2 to show up on an it8712 rev 8 chip which was not enabled at
>> boot time by the BIOS. The module param is checked and if a fan index
>> value is 1, the fan is forced on even if it is not configured that way
>> from the BIOS.
>
> This is a BIOS bug, which should be fixed in the BIOS. Please report to
> your motherboard manufacturer and get them to fix the bug. What
> motherboard is this, BTW? Usually motherboard BIOS enable all fans, or
> none; I don't remember seeing a BIOS (improperly) enabling a subset
> only.
>

I've reported this to the motherboard manufacturer and I'm waiting to
hear back if they confirm that it is a BIOS setup issue on their side.
The board in question is the Albatron KI 690-AM2 motherboard. This
board has a 4-pin & a 3-pin fan header. The main fan control register
has a value of 0x11 which indicates that only FAN1 is active (in
SmartGuardian mode). If I manually hack the driver to always set bit 5
of the register (9.6.2.2.16 Fan Controller Main Control Register
(Index=13h, Default=07h) in the docs), then I get a valid fan reading
from my CPU fan on "fan2" plugged into the 3-pin header. Short of a
BIOS update to fix this, I'd have to hack it to allow me to force
enable the second fan to get a valid reading.

I've reworked the code to just add a revision field as you noted and
to only contain the 16-bit tach change. Please review and let me know
what you think re: force enabling the fans via a module parameter
bitmask or something similar.

Thanks,
-Andrew

------=_Part_20076_26749979.1214313390773
Content-Type: text/plain;
	name=0001-hwmon-it87-support-for-16-bit-fan-reading-in-it8712-rev-8.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhuirlp20
Content-Disposition: attachment;
	filename=0001-hwmon-it87-support-for-16-bit-fan-reading-in-it8712-rev-8.txt

RnJvbSBmYjQ3ODZlMzJhYzEzYTQyNWZmNGE0MjNhYWY4ZmI1YTI1ODEwMmUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXcgUGFwcm9ja2kgPGFuZHJld0Bpc2hpYm9vLmNvbT4K
RGF0ZTogVHVlLCAyNCBKdW4gMjAwOCAwODozMDo1OSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGh3
bW9uOiBpdDg3IHN1cHBvcnQgZm9yIDE2LWJpdCBmYW4gcmVhZGluZyBpbiBpdDg3MTIgPj0gcmV2
IDgKClRoZSBpdDg3MTIgY2hpcCBkb2VzIG5vdCB1c2UgZmFuIGRpdmlzb3JzIGluIHJldmlzaW9u
cyA+PSA4LgpUaGUgbmV3ZXIgdmVyc2lvbiBvZiB0aGUgY2hpcCB1c2VzIDE2LWJpdCBmYW4gdGFj
aG9tZXRlcnMganVzdApsaWtlIHRoZSBpdDg3MTYgYW5kIGl0ODcxOCBjaGlwcy4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJldyBQYXByb2NraSA8YW5kcmV3QGlzaGlib28uY29tPgotLS0KIGRyaXZlcnMv
aHdtb24vaXQ4Ny5jIHwgICAyOSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxl
cyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2h3bW9uL2l0ODcuYyBiL2RyaXZlcnMvaHdtb24vaXQ4Ny5jCmluZGV4IGUxMmMx
MzIuLjQwMTdmZWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vaXQ4Ny5jCisrKyBiL2RyaXZl
cnMvaHdtb24vaXQ4Ny5jCkBAIC0xNTEsOSArMTUxLDkgQEAgc3RhdGljIGludCBmaXhfcHdtX3Bv
bGFyaXR5OwogLyogVGhlIElUODcxOEYgaGFzIHRoZSBWSUQgdmFsdWUgaW4gYSBkaWZmZXJlbnQg
cmVnaXN0ZXIsIGluIFN1cGVyLUkvTwogICAgY29uZmlndXJhdGlvbiBzcGFjZS4gKi8KICNkZWZp
bmUgSVQ4N19SRUdfVklEICAgICAgICAgICAweDBhCi0vKiBXYXJuaW5nOiByZWdpc3RlciAweDBi
IGlzIHVzZWQgZm9yIHNvbWV0aGluZyBjb21wbGV0ZWx5IGRpZmZlcmVudCBpbgotICAgbmV3IGNo
aXBzL3JldmlzaW9ucy4gSSBzdXNwZWN0IG9ubHkgMTYtYml0IHRhY2hvbWV0ZXIgbW9kZSB3aWxs
IHdvcmsKLSAgIGZvciB0aGVzZS4gKi8KKy8qIFRoZSBJVDg3MDVGIGFuZCBJVDg3MTJGIGVhcmxp
ZXIgdGhhbiByZXZpc2lvbiAweDA4IHVzZSByZWdpc3RlciAweDBiCisgICBmb3IgZmFuIGRpdmlz
b3JzLiBMYXRlciBJVDg3MTJGIHJldmlzaW9ucyB1c3QgdXNlIDE2LWJpdCB0YWNob21ldGVyCisg
ICBtb2RlLiAqLwogI2RlZmluZSBJVDg3X1JFR19GQU5fRElWICAgICAgIDB4MGIKICNkZWZpbmUg
SVQ4N19SRUdfRkFOXzE2QklUICAgICAweDBjCiAKQEAgLTIzNCw2ICsyMzQsNyBAQCBzdGF0aWMg
Y29uc3QgdW5zaWduZWQgaW50IHB3bV9mcmVxWzhdID0gewogc3RydWN0IGl0ODdfc2lvX2RhdGEg
ewogCWVudW0gY2hpcHMgdHlwZTsKIAkvKiBWYWx1ZXMgcmVhZCBmcm9tIFN1cGVyLUkvTyBjb25m
aWcgc3BhY2UgKi8KKwl1OCByZXZpc2lvbjsKIAl1OCB2aWRfdmFsdWU7CiB9OwogCkBAIC0yNDIs
NiArMjQzLDcgQEAgc3RydWN0IGl0ODdfc2lvX2RhdGEgewogc3RydWN0IGl0ODdfZGF0YSB7CiAJ
c3RydWN0IGRldmljZSAqaHdtb25fZGV2OwogCWVudW0gY2hpcHMgdHlwZTsKKwl1OCByZXZpc2lv
bjsKIAogCXVuc2lnbmVkIHNob3J0IGFkZHI7CiAJY29uc3QgY2hhciAqbmFtZTsKQEAgLTk5MSw4
ICs5OTMsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBpdDg3X2ZpbmQodW5zaWduZWQgc2hvcnQgKmFk
ZHJlc3MsCiAJfQogCiAJZXJyID0gMDsKKwlzaW9fZGF0YS0+cmV2aXNpb24gPSBzdXBlcmlvX2lu
YihERVZSRVYpICYgMHgwZjsKIAlwcl9pbmZvKCJpdDg3OiBGb3VuZCBJVCUwNHhGIGNoaXAgYXQg
MHgleCwgcmV2aXNpb24gJWRcbiIsCi0JCWNoaXBfdHlwZSwgKmFkZHJlc3MsIHN1cGVyaW9faW5i
KERFVlJFVikgJiAweDBmKTsKKwkJY2hpcF90eXBlLCAqYWRkcmVzcywgc2lvX2RhdGEtPnJldmlz
aW9uKTsKIAogCS8qIFJlYWQgR1BJTyBjb25maWcgYW5kIFZJRCB2YWx1ZSBmcm9tIExETiA3IChH
UElPKSAqLwogCWlmIChjaGlwX3R5cGUgIT0gSVQ4NzA1Rl9ERVZJRCkgewpAQCAtMTA0NSw2ICsx
MDQ4LDcgQEAgc3RhdGljIGludCBfX2RldmluaXQgaXQ4N19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQogCiAJZGF0YS0+YWRkciA9IHJlcy0+c3RhcnQ7CiAJZGF0YS0+dHlwZSA9
IHNpb19kYXRhLT50eXBlOworCWRhdGEtPnJldmlzaW9uID0gc2lvX2RhdGEtPnJldmlzaW9uOwog
CWRhdGEtPm5hbWUgPSBuYW1lc1tzaW9fZGF0YS0+dHlwZV07CiAKIAkvKiBOb3csIHdlIGRvIHRo
ZSByZW1haW5pbmcgZGV0ZWN0aW9uLiAqLwpAQCAtMTA2OSw3ICsxMDczLDggQEAgc3RhdGljIGlu
dCBfX2RldmluaXQgaXQ4N19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQln
b3RvIEVSUk9SMjsKIAogCS8qIERvIG5vdCBjcmVhdGUgZmFuIGZpbGVzIGZvciBkaXNhYmxlZCBm
YW5zICovCi0JaWYgKGRhdGEtPnR5cGUgPT0gaXQ4NzE2IHx8IGRhdGEtPnR5cGUgPT0gaXQ4NzE4
KSB7CisJaWYgKChkYXRhLT50eXBlID09IGl0ODcxMiAmJiBkYXRhLT5yZXZpc2lvbiA+PSAweDA4
KQorCSB8fCBkYXRhLT50eXBlID09IGl0ODcxNiB8fCBkYXRhLT50eXBlID09IGl0ODcxOCkgewog
CQkvKiAxNi1iaXQgdGFjaG9tZXRlcnMgKi8KIAkJaWYgKGRhdGEtPmhhc19mYW4gJiAoMSA8PCAw
KSkgewogCQkJaWYgKChlcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LApAQCAtMTM1MCw3ICsx
MzU1LDggQEAgc3RhdGljIHZvaWQgX19kZXZpbml0IGl0ODdfaW5pdF9kZXZpY2Uoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIAlkYXRhLT5oYXNfZmFuID0gKGRhdGEtPmZhbl9tYWluX2N0
cmwgPj4gNCkgJiAweDA3OwogCiAJLyogU2V0IHRhY2hvbWV0ZXJzIHRvIDE2LWJpdCBtb2RlIGlm
IG5lZWRlZCAqLwotCWlmIChkYXRhLT50eXBlID09IGl0ODcxNiB8fCBkYXRhLT50eXBlID09IGl0
ODcxOCkgeworCWlmICgoZGF0YS0+dHlwZSA9PSBpdDg3MTIgJiYgZGF0YS0+cmV2aXNpb24gPj0g
MHgwOCkKKwkgfHwgZGF0YS0+dHlwZSA9PSBpdDg3MTYgfHwgZGF0YS0+dHlwZSA9PSBpdDg3MTgp
IHsKIAkJdG1wID0gaXQ4N19yZWFkX3ZhbHVlKGRhdGEsIElUODdfUkVHX0ZBTl8xNkJJVCk7CiAJ
CWlmICh+dG1wICYgMHgwNyAmIGRhdGEtPmhhc19mYW4pIHsKIAkJCWRldl9kYmcoJnBkZXYtPmRl
diwKQEAgLTE0MjYsNyArMTQzMiw4IEBAIHN0YXRpYyBzdHJ1Y3QgaXQ4N19kYXRhICppdDg3X3Vw
ZGF0ZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQogCQkJZGF0YS0+ZmFuW2ldID0gaXQ4N19y
ZWFkX3ZhbHVlKGRhdGEsCiAJCQkJICAgICAgIElUODdfUkVHX0ZBTltpXSk7CiAJCQkvKiBBZGQg
aGlnaCBieXRlIGlmIGluIDE2LWJpdCBtb2RlICovCi0JCQlpZiAoZGF0YS0+dHlwZSA9PSBpdDg3
MTYgfHwgZGF0YS0+dHlwZSA9PSBpdDg3MTgpIHsKKwkJCWlmICgoZGF0YS0+dHlwZSA9PSBpdDg3
MTIgJiYgZGF0YS0+cmV2aXNpb24gPj0gMHgwOCkKKwkJCSB8fCBkYXRhLT50eXBlID09IGl0ODcx
NiB8fCBkYXRhLT50eXBlID09IGl0ODcxOCkgewogCQkJCWRhdGEtPmZhbltpXSB8PSBpdDg3X3Jl
YWRfdmFsdWUoZGF0YSwKIAkJCQkJCUlUODdfUkVHX0ZBTlhbaV0pIDw8IDg7CiAJCQkJZGF0YS0+
ZmFuX21pbltpXSB8PSBpdDg3X3JlYWRfdmFsdWUoZGF0YSwKQEAgLTE0NDMsOCArMTQ1MCw5IEBA
IHN0YXRpYyBzdHJ1Y3QgaXQ4N19kYXRhICppdDg3X3VwZGF0ZV9kZXZpY2Uoc3RydWN0IGRldmlj
ZSAqZGV2KQogCQl9CiAKIAkJLyogTmV3ZXIgY2hpcHMgZG9uJ3QgaGF2ZSBjbG9jayBkaXZpZGVy
cyAqLwotCQlpZiAoKGRhdGEtPmhhc19mYW4gJiAweDA3KSAmJiBkYXRhLT50eXBlICE9IGl0ODcx
NgotCQkgJiYgZGF0YS0+dHlwZSAhPSBpdDg3MTgpIHsKKwkJaWYgKChkYXRhLT5oYXNfZmFuICYg
MHgwNykKKwkJICYmIChkYXRhLT50eXBlID09IGl0ODcKKwkJICB8fCAoZGF0YS0+dHlwZSA9PSBp
dDg3MTIgJiYgZGF0YS0+cmV2aXNpb24gPCAweDA4KSkpIHsKIAkJCWkgPSBpdDg3X3JlYWRfdmFs
dWUoZGF0YSwgSVQ4N19SRUdfRkFOX0RJVik7CiAJCQlkYXRhLT5mYW5fZGl2WzBdID0gaSAmIDB4
MDc7CiAJCQlkYXRhLT5mYW5fZGl2WzFdID0gKGkgPj4gMykgJiAweDA3OwpAQCAtMTQ2MCw3ICsx
NDY4LDggQEAgc3RhdGljIHN0cnVjdCBpdDg3X2RhdGEgKml0ODdfdXBkYXRlX2RldmljZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCiAJCWRhdGEtPmZhbl9jdGwgPSBpdDg3X3JlYWRfdmFsdWUoZGF0YSwg
SVQ4N19SRUdfRkFOX0NUTCk7CiAKIAkJZGF0YS0+c2Vuc29yID0gaXQ4N19yZWFkX3ZhbHVlKGRh
dGEsIElUODdfUkVHX1RFTVBfRU5BQkxFKTsKLQkJLyogVGhlIDg3MDUgZG9lcyBub3QgaGF2ZSBW
SUQgY2FwYWJpbGl0eSAqLworCQkvKiBUaGUgODcwNSBkb2VzIG5vdCBoYXZlIFZJRCBjYXBhYmls
aXR5LgorCQkgICBUaGUgODcxOCBkb2VzIG5vdCB1c2UgSVQ4N19SRUdfVklEIGZvciB0aGUgc2Ft
ZSBwdXJwb3NlLiAqLwogCQlpZiAoZGF0YS0+dHlwZSA9PSBpdDg3MTIgfHwgZGF0YS0+dHlwZSA9
PSBpdDg3MTYpIHsKIAkJCWRhdGEtPnZpZCA9IGl0ODdfcmVhZF92YWx1ZShkYXRhLCBJVDg3X1JF
R19WSUQpOwogCQkJLyogVGhlIG9sZGVyIElUODcxMkYgcmV2aXNpb25zIGhhZCBvbmx5IDUgVklE
IHBpbnMsCi0tIAoxLjQuNC40Cgo=
------=_Part_20076_26749979.1214313390773
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_20076_26749979.1214313390773--
