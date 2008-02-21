From: Matt Roberds <mattroberds@cox.net>
Date: Thu, 21 Feb 2008 14:19:20 +0000
Subject: Re: [lm-sensors] First shot at Asus M2N-SLI Deluxe config file
Message-Id: <Pine.LNX.4.64.0802210811030.2910@birdbird.example.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="655872-1449599276-1203603560=:2931"
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--655872-1449599276-1203603560=:2931
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Thu, 21 Feb 2008, Jean Delvare wrote:
> On Wed, 20 Feb 2008 18:30:58 -0600 (CST), Matt Roberds wrote:
>> Here's a first shot at a config file for an Asus M2N-SLI Deluxe
>> motherboard.

My second shot is attached.  I have changed the name to inlclude the
"deluxe" designation.  This second shot also requires a small patch to
Jordan Crouse's latest adt7475.c driver to work; a diff is attached as
well.

>> chip "it8716-*"
>>
>>     ignore in2             # 3.3 V?
>
> I would be very surprised if +3.3V wasn't monitored. Doesn't it show
> in the BIOS?

It shows in the BIOS, but appears to be monitored by the adt7475 chip,
not the it8716.  This input always reads 0 V on the it8716.

> Most modern motherboards do not monitor -5V, and in general they don't
> monitor -12V either. Look in your BIOS, it probably doesn't display
> these either.

Running it with no compute lines gave 0 V, and the BIOS only reports
VCore, +3.3V, +5V, and +12V values, so I set the -5V and -12V to ignore.

>> # Not sure.  temp1 always reads close to what k8temp reports for Core0.
>> # temp3 always reads approximate ambient temperature.  temp2 is between
>> # temp1 and temp3.
>
> What does the BIOS display?

It only displays two temperatures: CPU and MB.  I have revised the
labels based on the temperature readings and the labels in your
M2N32-SLI configuration.

>> chip "ADT7475-*"
>>
>> # For some reason, ignoring vccp, remote1, and remote2 doesn't work.
>> # Is it because they have ALARM set?
>
> "vccp", "remote1" and "remote2" are not standard sysfs names, so I am
> not surprised that libsensors doesn't recognize them. Should be in<N>
> and temp<N>.

Those names are coming from the adt7475 driver.  I modified Jordan
Crouse's latest driver to report the standard names; a diff is attached.

>>     label  vcc  "+3.3V"
>
> "vcc" isn't a standard name either, I guess that this label statement
> has no effect?

Correct.  With the attached diff, it works again.

Matt Roberds

--655872-1449599276-1203603560=:2931
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=sensors.m2n-sli-deluxe.conf
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0802210819200.2931@birdbird.example.com>
Content-Description: Second shot at ASUS M2N-SLI Deluxe config file
Content-Disposition: attachment; filename=sensors.m2n-sli-deluxe.conf

IyBTZWNvbmQgY3V0IGF0IGEgbWluaW1hbCBzZW5zb3JzMy5jb25mIGZvciBB
c3VzIE0yTi1TTEkgRGVsdXhlIG1vdGhlcmJvYXJkDQojIEJhc2VkIG9uIGV4
aXN0aW5nIGVudHJpZXMgaW4gc2Vuc29yczMuY29uZiBhbmQgSmVhbiBEZWx2
YXJlJ3MgY29uZmlndXJhdGlvbg0KIyBmb3IgdGhlIEFzdXMgTTJOMzItU0xJ
DQojIE1hdHQgUm9iZXJkcywgMjEgRmViIDIwMDgNCg0KDQpjaGlwICJpdDg3
MTYtKiINCg0KIyBWb2x0YWdlcw0KDQogICAgbGFiZWwgIGluMCAgIlZDb3Jl
Ig0KICAgIGxhYmVsICBpbjEgICJWRERSIiAgICAgIyBOb3QgaW4gQklPUw0K
ICAgIGlnbm9yZSBpbjIgICAgICAgICAgICAgIyAzLjMgViBpcyBtb25pdG9y
ZWQgYnkgYWR0NzQ3NQ0KICAgIGxhYmVsICBpbjMgICIrNVYiICAgICAgIyBW
Q0MNCiAgICBsYWJlbCAgaW40ICAiKzEyViINCiAgICBpZ25vcmUgaW41ICAg
ICAgICAgICAgICMgLTEyIFYgbm90IG1vbml0b3JlZA0KICAgIGlnbm9yZSBp
bjYgICAgICAgICAgICAgIyAgLTUgViBub3QgbW9uaXRvcmVkDQogICAgbGFi
ZWwgIGluNyAgIjVWU0IiICAgICAjIE5vdCBpbiBCSU9TDQogICAgbGFiZWwg
IGluOCAgIlZCYXQiICAgICAjIE5vdCBpbiBCSU9TDQoNCiAgICAjIFZjb3Jl
LCBWRERSLCBhbmQgVmJhdCBhcmUgY29ubmVjdGVkIGRpcmVjdGx5LCBzbyBu
byBjb21wdXRlDQogICAgIyBsaW5lIGlzIG5lZWRlZCBmb3IgdGhlc2UuIEZv
ciArNVYsICsxMlYgYW5kIDVWU0IsIHRoZSBkZWZhdWx0DQogICAgIyByZXNp
c3RvcnMgc2VlbSB0byBoYXZlIGJlZW4gdXNlZC4NCiAgICBjb21wdXRlIGlu
MyAgKCg2LjgvMTApKzEpKkAgLCBALygoNi44LzEwKSsxKQ0KICAgIGNvbXB1
dGUgaW40ICAoKDMwLzEwKSsxKSpAICAsIEAvKCgzMC8xMCkrMSkNCiAgICBj
b21wdXRlIGluNyAgKCg2LjgvMTApKzEpKkAgLCBALygoNi44LzEwKSsxKQ0K
DQojIFRlbXBlcmF0dXJlcw0KDQojIE5vdCBzdXJlLiAgdGVtcDEgYWx3YXlz
IHJlYWRzIGNsb3NlIHRvIHdoYXQgazh0ZW1wIHJlcG9ydHMgZm9yIENvcmUw
LA0KIyBhbmQgdG8gd2hhdCB0aGUgQklPUyByZXBvcnRzIGFzIHRoZSBDUFUg
dGVtcGVyYXR1cmUuICB0ZW1wMiBpcyBiZXR3ZWVuDQojIHRlbXAxIGFuZCB0
ZW1wMzsgaXQgaXMgY2xvc2UgdG8gd2hhdCB0aGUgQklPUyByZXBvcnRzIGFz
IHRoZSBtb3RoZXJib2FyZA0KIyB0ZW1wZXJhdHVyZS4gIHRlbXAzIGFsd2F5
cyByZWFkcyBhcHByb3hpbWF0ZSBhbWJpZW50IHRlbXBlcmF0dXJlLg0KDQog
ICAgbGFiZWwgdGVtcDEgIkNQVSBUZW1wIg0KICAgIGxhYmVsIHRlbXAyICJN
QiBUZW1wIg0KICAgIGxhYmVsIHRlbXAzICJNQiBUZW1wIg0KDQojIEZhbnMN
Cg0KICAgIGxhYmVsICBmYW4xICJDUFUgRmFuIg0KICAgIGxhYmVsICBmYW4y
ICJDaGFzc2lzIEZhbiAxIg0KICAgIGxhYmVsICBmYW4zICJQb3dlciBTdXBw
bHkgRmFuIg0KDQogICAgIyBJZ25vcmUgZmFucyB5b3UgZG9uJ3QgaGF2ZQ0K
IyAgIGlnbm9yZSBmYW4yDQojICAgaWdub3JlIGZhbjMNCg0KDQpjaGlwICJh
ZHQ3NDc1LSoiDQoNCiMgTm90ZTogdGhpcyBzZWN0aW9uIGRlcGVuZHMgb24g
c29tZSBmdXJ0aGVyIGhhY2tzIEkgaGF2ZSBtYWRlIHRvDQojIEpvcmRhbiBD
cm91c2UncyBkcml2ZXINCg0KIyBWb2x0YWdlcw0KDQogICAgaWdub3JlIGlu
MQ0KICAgIGxhYmVsICBpbjIgICIrMy4zViINCg0KIyBUZW1wZXJhdHVyZXMN
Cg0KIyB0ZW1wMSBhbmQgdGVtcDMgZG9uJ3QgYXBwZWFyIHRvIGJlIGhvb2tl
ZCB1cDsgdGVtcDIgaXMgb24gYm9hcmQgdGhlDQojIGFkdDc0NzUgY2hpcCBp
dHNlbGYuDQoNCiAgICBpZ25vcmUgdGVtcDENCiAgICBsYWJlbCAgdGVtcDIg
ICJBRFQ3NDc1IFRlbXAiDQogICAgaWdub3JlIHRlbXAzDQoNCiMgRmFucw0K
DQogICAgbGFiZWwgIGZhbjEgIkNoYXNzaXMgRmFuIDQiDQogICAgbGFiZWwg
IGZhbjIgIkNoYXNzaXMgRmFuIDIiDQogICAgbGFiZWwgIGZhbjMgIkNoYXNz
aXMgRmFuIDMiDQogICAgaWdub3JlIGZhbjQNCg0KICAgICMgSWdub3JlIGZh
bnMgeW91IGRvbid0IGhhdmUNCiMgICBpZ25vcmUgZmFuMQ0KIyAgIGlnbm9y
ZSBmYW4yDQojICAgaWdub3JlIGZhbjMNCg0KDQpjaGlwICJrOHRlbXAtKiIN
Cg0KICAgbGFiZWwgdGVtcDEgImNvcmUwIHRlbXAiDQogICBsYWJlbCB0ZW1w
MyAiY29yZTEgdGVtcCINCg0K

--655872-1449599276-1203603560=:2931
Content-Type: TEXT/x-diff; charset=US-ASCII; name=adt7475.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0802210819201.2931@birdbird.example.com>
Content-Description: Patch of J Crouse's adt7475.c;
	std sysfs names, ADT lowcase
Content-Disposition: attachment; filename=adt7475.diff

KioqIGFkdDc0NzUtamMtMS5jCTIwMDgtMDEtMjQgMTA6MjQ6MTQuMDAwMDAw
MDAwIC0wNjAwDQotLS0gYWR0NzQ3NS1tY3ItMS5jCTIwMDgtMDItMjEgMDc6
NDc6MjUuMDAwMDAwMDAwIC0wNjAwDQoqKioqKioqKioqKioqKioNCioqKiAy
MTgsMjI1ICoqKioNCiAgDQogIAlzd2l0Y2goc2F0dHItPm5yKSB7DQogIAkJ
Y2FzZSBMQUJFTDoNCiEgCQkJcmV0dXJuIHNwcmludGYoYnVmLCAiJXNcbiIs
DQohIAkJCQlzYXR0ci0+aW5kZXggPT0gMCA/ICJ2Y2NwIiA6ICJ2Y2MiKTsN
CiAgCQljYXNlIEFMQVJNOg0KICAJCQlyZXR1cm4gc3ByaW50ZihidWYsICIl
ZFxuIiwNCiAgCQkJCShkYXRhLT5hbGFybXMgPj4gKHNhdHRyLT5pbmRleCAr
IDEpKSAmIDEpOw0KLS0tIDIxOCwyMjUgLS0tLQ0KICANCiAgCXN3aXRjaChz
YXR0ci0+bnIpIHsNCiAgCQljYXNlIExBQkVMOg0KISAJCQlyZXR1cm4gc3By
aW50ZihidWYsICJpbiVzXG4iLA0KISAJCQkJc2F0dHItPmluZGV4ID09IDAg
PyAiMSIgOiAiMiIpOw0KICAJCWNhc2UgQUxBUk06DQogIAkJCXJldHVybiBz
cHJpbnRmKGJ1ZiwgIiVkXG4iLA0KICAJCQkJKGRhdGEtPmFsYXJtcyA+PiAo
c2F0dHItPmluZGV4ICsgMSkpICYgMSk7DQoqKioqKioqKioqKioqKioNCioq
KiAyNTcsMjYzICoqKioNCiAgc3RhdGljIHNzaXplX3Qgc2hvd190ZW1wKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0
dHIsDQogIAkJCSBjaGFyICpidWYpDQogIHsNCiEgCXN0YXRpYyBjb25zdCBj
aGFyICpsYWJlbHNbXSA9IHsicmVtb3RlMSIsICJsb2NhbCIsICJyZW1vdGUy
In07DQogIA0KICAJc3RydWN0IGFkdDc0NzVfZGF0YSAqZGF0YSA9IGFkdDc0
NzVfdXBkYXRlX2RldmljZShkZXYpOw0KICAJc3RydWN0IHNlbnNvcl9kZXZp
Y2VfYXR0cmlidXRlXzIgKnNhdHRyID0gdG9fc2Vuc29yX2Rldl9hdHRyXzIo
YXR0cik7DQotLS0gMjU3LDI2NCAtLS0tDQogIHN0YXRpYyBzc2l6ZV90IHNo
b3dfdGVtcChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICphdHRyLA0KICAJCQkgY2hhciAqYnVmKQ0KICB7DQohIAlzdGF0
aWMgY29uc3QgY2hhciAqbGFiZWxzW10gPSB7InRlbXAxIiwgInRlbXAyIiwg
InRlbXAzIn07DQohICAgLyogd2FzIHJlbW90ZTEsIGxvY2FsLCByZW1vdGUy
IC0gbWNyICovDQogIA0KICAJc3RydWN0IGFkdDc0NzVfZGF0YSAqZGF0YSA9
IGFkdDc0NzVfdXBkYXRlX2RldmljZShkZXYpOw0KICAJc3RydWN0IHNlbnNv
cl9kZXZpY2VfYXR0cmlidXRlXzIgKnNhdHRyID0gdG9fc2Vuc29yX2Rldl9h
dHRyXzIoYXR0cik7DQoqKioqKioqKioqKioqKioNCioqKiA3NTAsNzU2ICoq
KioNCiAgCWNvbnN0IGNoYXIgKm5hbWU7DQogIAlzdHJ1Y3QgYXR0cmlidXRl
X2dyb3VwIGdyb3VwOw0KICB9IGFkdDc0NzVfY2hpcHNbQURUNzQ3NV9NQVhf
SURdID0gew0KISAJeyAubmFtZSA9ICJBRFQ3NDc1IiwNCiAgCSAgLmdyb3Vw
ID0gew0KICAJCSAgLmF0dHJzID0gYWR0NzQ3NV9hdHRycywNCiAgCSAgfQ0K
LS0tIDc1MSw3NTcgLS0tLQ0KICAJY29uc3QgY2hhciAqbmFtZTsNCiAgCXN0
cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgZ3JvdXA7DQogIH0gYWR0NzQ3NV9jaGlw
c1tBRFQ3NDc1X01BWF9JRF0gPSB7DQohIAl7IC5uYW1lID0gImFkdDc0NzUi
LA0KICAJICAuZ3JvdXAgPSB7DQogIAkJICAuYXR0cnMgPSBhZHQ3NDc1X2F0
dHJzLA0KICAJICB9DQo=

--655872-1449599276-1203603560=:2931
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--655872-1449599276-1203603560=:2931--
