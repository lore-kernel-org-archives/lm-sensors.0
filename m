From: Arseny Klimovsky <arseny.klimovsky@gmail.com>
Date: Sun, 29 May 2011 19:49:02 +0000
Subject: Re: [lm-sensors] Testing results for Nuvoton W83677HG-I
Message-Id: <4DE2A32E.2010505@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040907010903050604000507"
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD783EB.5010606@gmail.com>
In-Reply-To: <4DD783EB.5010606@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040907010903050604000507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Jean Delvare =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sun, 29 May 2011 17:47:18 +0400, Arseny Klimovsky wrote:
>> 2. Statement "ignore temp5" does not take effect. I see line about "PE=
CI
>> Agent 1"
> Maybe it's not temp5 but temp6 or more. Try "sensors -u" to find out
> the right number.
Thank you, Jean!
I've tried temp5..7 and no results. But with "sensors -u" it figured out =

to be temp8 :)

I think the configuration can now be added to wiki, I've attached the fil=
e.
According to the message
http://lists.lm-sensors.org/pipermail/lm-sensors/2011-March/031775.html
this confguration can be used for DH67CL board, possibly with very small =

changes.

--=20
Arseny Klimovsky


--------------040907010903050604000507
Content-Type: text/plain;
 name="DH67BL.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="DH67BL.conf"

CiMgQ3JlYXRlZCBmb3IgYm9hcmQgREg2N0JMIHVzaW5nIGluZm9ybWF0aW9uIGZyb20gSW50
ZSBEZXNrdG9wIFV0aWxpdGllcyBhbmQgQklPUwojICJGUk9OVCIgYW5kICJSRUFSIiBmYW4g
bGFiZWxzIGNvcnJlc3BvbmQgdG8gdGhlIG1vdGhlcmJvYXJkCiMgaGVhZGVycywgYnV0IG5v
dCBuZWNlc3NhcmlseSB0aGUgYWN0dWFsIGZhbiBsb2NhdGlvbnMuCgpjaGlwICJuY3Q2Nzc1
LWlzYS0wMjkwIgoKIyBGYW5zCiAgICAgICAgbGFiZWwgZmFuMSAiUmVhciBmYW4iCiAgICAg
ICAgc2V0IGZhbjFfbWluIDI1MCAjIEZyb20gSURVCgogICAgICAgIGxhYmVsIGZhbjIgIkNQ
VSBmYW4iCiAgICAgICAgc2V0IGZhbjJfbWluIDI1MCAjIEZyb20gSURVCgogICAgICAgIGxh
YmVsIGZhbjMgIkZyb250IGZhbiIKICAgICAgICBzZXQgZmFuM19taW4gMjUwICMgRnJvbSBJ
RFUKCgkjIFRoZXJlIGlzIG5vIGZhbjQgb24gdGhlIGJvYXJkCglpZ25vcmUgZmFuNAoKIyBW
b2x0YWdlcwoKCSMgUHJvY2Vzc29yIFZjYwoJbGFiZWwJaW4wCQkiVmNvcmUiCglzZXQJaW4w
X21pbiAJMC42ICMgRnJvbSBJRFUKCXNldAlpbjBfbWF4IAkxLjYgIyBGcm9tIElEVQoJCgkj
IFRoaXMgc2hvdWxkIGJlICIxMiBWb2x0cyIsIGJ1dCBjb21wdXRhdGlvbnMgYXJlIHN0cmFu
Z2UKCWxhYmVsCWluMQkJIisxMlYiCgljb21wdXRlCWluMQkJMTEqQCwgQC8xMQoJc2V0CWlu
MV9taW4JCTExLjEgIyBGcm9tIElEVQoJc2V0CWluMV9tYXgJCTEyLjkgIyBGcm9tIElEVQoK
CSMgQVZDQyg/KSAtIE5vdCBzaG93biBpbiBCSU9TIG9yIElEVQoJbGFiZWwJaW4yCQkiQVZD
QyIKCXNldAlpbjJfbWluCQkzLjAJCSMgc2FtZSBhcyArMy4zVgoJc2V0CWluMl9tYXgJCTMu
NgkJIyBzYW1lIGFzICszLjNWCgoJIyArMy4zIFZvbHRzCglsYWJlbAlpbjMJCSIrMy4zViIK
CXNldAlpbjNfbWluCQkzLjAJCSMgZnJvbSBJRFUKCXNldAlpbjNfbWF4CQkzLjYJCSMgZnJv
bSBJRFUKCgkjICs1IFZvbHRzCglsYWJlbAlpbjQJCSIrNVYiCgljb21wdXRlCWluNAkJNSpA
LCBALzUKCXNldAlpbjRfbWluCQk0LjYJCSMgZnJvbSBJRFUKCXNldAlpbjRfbWF4CQk1LjQJ
CSMgZnJvbSBJRFUKCgkjIE1lbW9yeSBWY2MgKCJTRFJBTSBWY2MiIGluIElEVSkKCWxhYmVs
CWluNQkJIk1lbVYiCgljb21wdXRlCWluNQkJMS41KkAsIEAvMS41CglzZXQJaW41X21pbgkJ
MC40CQkjIGZyb20gSURVCglzZXQJaW41X21heAkJMi4wCQkjIGZyb20gSURVCgoJIyBQQ0gg
VmNjCglsYWJlbAlpbjYJCSJQQ0hWIgoJc2V0CWluNl9taW4JCTAuNgkJIyBmcm9tIElEVQoJ
c2V0CWluNl9tYXgJCTEuNgkJIyBmcm9tIElEVQoKCSMgKzMuMyBWb2x0IFN0YW5kYnkKCWxh
YmVsCWluNwkJIjNWU0IiCglzZXQJaW43X21pbgkJMy4wCQkjIGZyb20gSURVCglzZXQJaW43
X21heAkJMy42CQkjIGZyb20gSURVCgoJIyBWQkFUKD8pIC0gTm90IHNob3duIGluIEJJT1Mg
b3IgSURVCglsYWJlbAlpbjgJCSJWYmF0IgoKCSMgSXQgc2hvd3MgKzIuMDUwIFYsIHNlZW1z
IHRvIGJlIG5vdCB1c2VkCglpZ25vcmUJY3B1MF92aWQKCiMJVGVtcGVyYXR1cmVzCgoJIyBM
YWJlbGVkIGFzICJTWVNUSU4iCgkjIEd1ZXNzIQoJbGFiZWwJdGVtcDEJCSJWUiB0ZW1wIgoJ
c2V0CXRlbXAxX21heCAJOTAJCSMgRnJvbSBJRFUKCXNldAl0ZW1wMV9tYXhfaHlzdCAJNzUJ
CSMgRnJvbSBJRFUKCSMgTGFiZWxlZCBhcyAiQ1BVVElOIgoJbGFiZWwJdGVtcDIJCSJDUFUg
dGVtcCIKCXNldAl0ZW1wMl9tYXggCTkzCQkjIEZyb20gSURVCglzZXQJdGVtcDJfbWF4X2h5
c3QgCTc1CQkjIEZyb20gSURVCgkjIExhYmVsZWQgYXMgIlBFQ0kgQWdlbnQgMCIKCSMgR3Vl
c3MhCglsYWJlbAl0ZW1wMwkJIk1lbW9yeSBESU1NIHRlbXAiCglzZXQJdGVtcDNfbWF4IAk5
MAkJIyBGcm9tIElEVQoJc2V0CXRlbXAzX21heF9oeXN0IAk3NQkJIyBGcm9tIElEVQoJIyBM
YWJlbGVkIGFzICJQQ0hfQ0hJUF9URU1QIgoJbGFiZWwJdGVtcDQJCSJQQ0ggdGVtcCIKCgkj
IExhYmVsZWQgYXMgIlBFQ0kgQWdlbnQgMSIKCSMgTm90IHVzZWQKCWlnbm9yZQl0ZW1wOAoK

--------------040907010903050604000507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040907010903050604000507--
