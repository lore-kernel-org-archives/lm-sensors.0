From: "David O'Shea" <dcoshea@hotmail.com>
Date: Sun, 01 Mar 2009 10:50:49 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <SNT103-W55912201D47365B8188F79B8A80@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_c2b4b2d8-61af-4ac6-96cf-3e7312924f90_"
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
To: lm-sensors@vger.kernel.org

--_c2b4b2d8-61af-4ac6-96cf-3e7312924f90_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Jean=2C

> Date: Sun=2C 1 Mar 2009 09:58:56 +0100

>> As you can see from earlier in the mail=2C the USB controllers are at 00=
:1d so they come before the ISA bridge and I guess that's why using one of =
them worked for me!  Given that they each have their own ID would it be oka=
y to use them then?
>=20
> Did you try using DECLARE_PCI_FIXUP_EARLY() instead of
> DECLARE_PCI_FIXUP_HEADER()? I suspect this would let you use the IDE
> controller.

I'm afraid I didn't look around that much so wasn't aware of that one!

> But as said above=2C I am now also fine with you using one of the USB
> controllers if you prefer=3B it's up to you. When you have a working
> patch=2C please send it to me and I'll review it quickly so that it can
> make it into 2.6.30.

I prefer to stick to using the USB since it requires less changes and knowi=
ng as little as I do about the code it is probably best that I do as little=
 as possible to it :)

I have attached a patch.  Apologies in advance if I got it wrong somehow!  =
Also I'm afraid it is based on an older kernel version (2.6.27) since this =
is what Fedora 10 includes - it was not until you mentioned 2.6.30 that I k=
new this was old :(  I hope this is acceptable anyway since the patch is pr=
etty simple.

Thanks in advance=2C
David

_________________________________________________________________
Looking to change your car this year? Find car news=2C reviews and more=20
http://a.ninemsn.com.au/b.aspx?URL=3Dhttp%3A%2F%2Fsecure%2Dau%2Eimrworldwid=
e%2Ecom%2Fcgi%2Dbin%2Fa%2Fci%5F450304%2Fet%5F2%2Fcg%5F801459%2Fpi%5F1004813=
%2Fai%5F859641&_t=3D762955845&_r=3Dtig_OCT07&_m=3DEXT=

--_c2b4b2d8-61af-4ac6-96cf-3e7312924f90_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="compaq_evo_d51s_sensors.patch"

ZGlmZiAtciAtdSAuL2xpbnV4LTIuNi4yNy5pNjg2Lm9yaWcvZHJpdmVycy9wY2kvcXVpcmtzLmMg
Li9saW51eC0yLjYuMjcuaTY4Ni5jb21wYXFfZXZvX2Q1MXNfc2Vuc29ycy9kcml2ZXJzL3BjaS9x
dWlya3MuYwotLS0gLi9saW51eC0yLjYuMjcuaTY4Ni5vcmlnL2RyaXZlcnMvcGNpL3F1aXJrcy5j
CTIwMDktMDEtMTggMTM6MzE6MzkuMDAwMDAwMDAwICsxMDMwCisrKyAuL2xpbnV4LTIuNi4yNy5p
Njg2LmNvbXBhcV9ldm9fZDUxc19zZW5zb3JzL2RyaXZlcnMvcGNpL3F1aXJrcy5jCTIwMDktMDMt
MDEgMjA6MDM6MTkuMDAwMDAwMDAwICsxMDMwCkBAIC0xMDY3LDEwICsxMDY3LDE1IEBACiAJCQkJ
ICogaXRzIG9uLWJvYXJkIFZHQSBjb250cm9sbGVyICovCiAJCQkJYXN1c19oaWRlc19zbWJ1cyA9
IDE7CiAJCQl9Ci0JCWVsc2UgaWYgKGRldi0+ZGV2aWNlID09IFBDSV9ERVZJQ0VfSURfSU5URUxf
ODI4NDVHX0lHKQorCQllbHNlIGlmIChkZXYtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX0lOVEVM
XzgyODAxREJfMikKIAkJCXN3aXRjaChkZXYtPnN1YnN5c3RlbV9kZXZpY2UpIHsKIAkJCWNhc2Ug
MHgwMGI4OiAvKiBDb21wYXEgRXZvIEQ1MTAgQ01UICovCiAJCQljYXNlIDB4MDBiOTogLyogQ29t
cGFxIEV2byBENTEwIFNGRiAqLworCQkJCS8qIE1vdGhlcmJvYXJkIGRvZXNuJ3QgaGF2ZSBIb3N0
IGJyaWRnZQorCQkJCSAqIHN1YnZlbmRvci9zdWJkZXZpY2UgSURzIGFuZCBvbi1ib2FyZCBWR0EK
KwkJCQkgKiBjb250cm9sbGVyIGlzIGRpc2FibGVkIGlmIGFuIEFHUCBjYXJkIGlzCisJCQkJICog
aW5zZXJ0ZWQsIHRoZXJlZm9yZSBjaGVja2luZyBVU0IgVUhDSQorCQkJCSAqIENvbnRyb2xsZXIg
IzEgKi8KIAkJCQlhc3VzX2hpZGVzX3NtYnVzID0gMTsKIAkJCX0KIAkJZWxzZSBpZiAoZGV2LT5k
ZXZpY2UgPT0gUENJX0RFVklDRV9JRF9JTlRFTF84MjgxNV9DR0MpCkBAIC0xMDk1LDcgKzExMDAs
NyBAQAogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsCVBDSV9E
RVZJQ0VfSURfSU5URUxfODI5MTVHTV9IQiwgYXN1c19oaWRlc19zbWJ1c19ob3N0YnJpZGdlKTsK
IAogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsCVBDSV9ERVZJ
Q0VfSURfSU5URUxfODI4MTBfSUczLAlhc3VzX2hpZGVzX3NtYnVzX2hvc3RicmlkZ2UpOwotREVD
TEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsCVBDSV9ERVZJQ0VfSURf
SU5URUxfODI4NDVHX0lHLAlhc3VzX2hpZGVzX3NtYnVzX2hvc3RicmlkZ2UpOworREVDTEFSRV9Q
Q0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsCVBDSV9ERVZJQ0VfSURfSU5URUxf
ODI4MDFEQl8yLAlhc3VzX2hpZGVzX3NtYnVzX2hvc3RicmlkZ2UpOwogREVDTEFSRV9QQ0lfRklY
VVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsCVBDSV9ERVZJQ0VfSURfSU5URUxfODI4MTVf
Q0dDLAlhc3VzX2hpZGVzX3NtYnVzX2hvc3RicmlkZ2UpOwogCiBzdGF0aWMgdm9pZCBhc3VzX2hp
ZGVzX3NtYnVzX2xwYyhzdHJ1Y3QgcGNpX2RldiAqZGV2KQpkaWZmIC1yIC11IC4vbGludXgtMi42
LjI3Lmk2ODYub3JpZy9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCAuL2xpbnV4LTIuNi4yNy5pNjg2
LmNvbXBhcV9ldm9fZDUxc19zZW5zb3JzL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCi0tLSAuL2xp
bnV4LTIuNi4yNy5pNjg2Lm9yaWcvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgJMjAwOS0wMS0xOCAx
MzozMjozOS4wMDAwMDAwMDAgKzEwMzAKKysrIC4vbGludXgtMi42LjI3Lmk2ODYuY29tcGFxX2V2
b19kNTFzX3NlbnNvcnMvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgJMjAwOS0wMy0wMSAxOTo0Mzo0
Mi4wMDAwMDAwMDAgKzEwMzAKQEAgLTIzMjIsNiArMjMyMiw3IEBACiAjZGVmaW5lIFBDSV9ERVZJ
Q0VfSURfSU5URUxfODI4MDFDQV8xMgkweDI0OGMKICNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRF
TF84MjgwMURCXzAJMHgyNGMwCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfSU5URUxfODI4MDFEQl8x
CTB4MjRjMQorI2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVMXzgyODAxREJfMgkweDI0YzIKICNk
ZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF84MjgwMURCXzMJMHgyNGMzCiAjZGVmaW5lIFBDSV9E
RVZJQ0VfSURfSU5URUxfODI4MDFEQl81CTB4MjRjNQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0lO
VEVMXzgyODAxREJfNgkweDI0YzYK

--_c2b4b2d8-61af-4ac6-96cf-3e7312924f90_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_c2b4b2d8-61af-4ac6-96cf-3e7312924f90_--
