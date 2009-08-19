From: Stewart Adam <maillist@diffingo.com>
Date: Wed, 19 Aug 2009 23:40:10 +0000
Subject: [lm-sensors] Bogus sensor values on Supermicro X7SBi
Message-Id: <4A8C8D5A.1040102@diffingo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040700020704090201060602"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040700020704090201060602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm seeing some very weird sensors output on the Supermicro X7SBi. I 
have tried installing a backported w83627hf driver from elrepo-testing, 
but I had the same results.

Distro: CentOS 5.3
Motherboard: Supermicro X7SBi
Kernel 2.6.18-128.4.1.el5 and lm_sensors 2.10.7 (tried with 3.0.2 as well)
Outputs of sensors, sensors-detect, "i2cdetect 0" and lsmod are attached.

The only relevant part of dmesg is:
w83627hf: Found W83627HF chip at 0x290

According to the manufacturer's page, the sensor chip is a W83793G Rev G:
http://www.supermicro.com/products/motherboard/Xeon3000/3210/X7SBi.cfm

Regards,
Stewart

--------------040700020704090201060602
Content-Type: text/plain;
 name="sensors-detect.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sensors-detect.txt"

U3RvcHBpbmcgbG1fc2Vuc29yczogG1s2MEdbG1swOzMybSAgT0sgIBtbMDszOW1dDQojIHNl
bnNvcnMtZGV0ZWN0IHJldmlzaW9uIDU1NjkgKDIwMDgtMTItMTUgMDk6MzY6MDkgKzAxMDAp
CgpUaGlzIHByb2dyYW0gd2lsbCBoZWxwIHlvdSBkZXRlcm1pbmUgd2hpY2gga2VybmVsIG1v
ZHVsZXMgeW91IG5lZWQKdG8gbG9hZCB0byB1c2UgbG1fc2Vuc29ycyBtb3N0IGVmZmVjdGl2
ZWx5LiBJdCBpcyBnZW5lcmFsbHkgc2FmZQphbmQgcmVjb21tZW5kZWQgdG8gYWNjZXB0IHRo
ZSBkZWZhdWx0IGFuc3dlcnMgdG8gYWxsIHF1ZXN0aW9ucywKdW5sZXNzIHlvdSBrbm93IHdo
YXQgeW91J3JlIGRvaW5nLgoKV2UgY2FuIHN0YXJ0IHdpdGggcHJvYmluZyBmb3IgKFBDSSkg
STJDIG9yIFNNQnVzIGFkYXB0ZXJzLgpEbyB5b3Ugd2FudCB0byBwcm9iZSBub3c/IChZRVMv
bm8pOiBQcm9iaW5nIGZvciBQQ0kgYnVzIGFkYXB0ZXJzLi4uClVzZSBkcml2ZXIgYGkyYy1p
ODAxJyBmb3IgZGV2aWNlIDAwMDA6MDA6MWYuMzogSW50ZWwgSUNIOQoKV2Ugd2lsbCBub3cg
dHJ5IHRvIGxvYWQgZWFjaCBhZGFwdGVyIG1vZHVsZSBpbiB0dXJuLgpNb2R1bGUgYGkyYy1p
ODAxJyBhbHJlYWR5IGxvYWRlZC4KSWYgeW91IGhhdmUgdW5kZXRlY3RhYmxlIG9yIHVuc3Vw
cG9ydGVkIEkyQy9TTUJ1cyBhZGFwdGVycywgeW91IGNhbiBoYXZlCnRoZW0gc2Nhbm5lZCBi
eSBtYW51YWxseSBsb2FkaW5nIHRoZSBtb2R1bGVzIGJlZm9yZSBydW5uaW5nIHRoaXMgc2Ny
aXB0LgoKVG8gY29udGludWUsIHdlIG5lZWQgbW9kdWxlIGBpMmMtZGV2JyB0byBiZSBsb2Fk
ZWQuCkRvIHlvdSB3YW50IHRvIGxvYWQgYGkyYy1kZXYnIG5vdz8gKFlFUy9ubyk6IE1vZHVs
ZSBsb2FkZWQgc3VjY2Vzc2Z1bGx5LgoKV2UgYXJlIG5vdyBnb2luZyB0byBkbyB0aGUgSTJD
L1NNQnVzIGFkYXB0ZXIgcHJvYmluZ3MuIFNvbWUgY2hpcHMgbWF5CmJlIGRvdWJsZSBkZXRl
Y3RlZDsgd2UgY2hvb3NlIHRoZSBvbmUgd2l0aCB0aGUgaGlnaGVzdCBjb25maWRlbmNlCnZh
bHVlIGluIHRoYXQgY2FzZS4KSWYgeW91IGZvdW5kIHRoYXQgdGhlIGFkYXB0ZXIgaHVuZyBh
ZnRlciBwcm9iaW5nIGEgY2VydGFpbiBhZGRyZXNzLAp5b3UgY2FuIHNwZWNpZnkgdGhhdCBh
ZGRyZXNzIHRvIHJlbWFpbiB1bnByb2JlZC4KCk5leHQgYWRhcHRlcjogU01CdXMgSTgwMSBh
ZGFwdGVyIGF0IDExMDAgKGkyYy0wKQpEbyB5b3Ugd2FudCB0byBzY2FuIGl0PyAoWUVTL25v
L3NlbGVjdGl2ZWx5KTogQ2xpZW50IGZvdW5kIGF0IGFkZHJlc3MgMHgxZgpQcm9iaW5nIGZv
ciBgTWF4aW0gTUFYNjY1MC9NQVg2NjUxJy4uLiAgICAgICAgICAgICAgICAgICAgICBObwpD
bGllbnQgZm91bmQgYXQgYWRkcmVzcyAweDJmClByb2JpbmcgZm9yIGBOYXRpb25hbCBTZW1p
Y29uZHVjdG9yIExNNzgnLi4uICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBOYXRp
b25hbCBTZW1pY29uZHVjdG9yIExNNzgtSicuLi4gICAgICAgICAgICAgIE5vClByb2Jpbmcg
Zm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExNNzknLi4uICAgICAgICAgICAgICAgIE5v
ClByb2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExNODAnLi4uICAgICAgICAg
ICAgICAgIE5vClByb2JpbmcgZm9yIGBBbmFsb2cgRGV2aWNlcyBBRFQ3NDcwJy4uLiAgICAg
ICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBXaW5ib25kIFc4Mzc4MUQnLi4uICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBXaW5ib25kIFc4Mzc4
MkQnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBXaW5i
b25kIFc4Mzc5MkQnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vClByb2Jpbmcg
Zm9yIGBXaW5ib25kIFc4Mzc5M1IvRycuLi4gICAgICAgICAgICAgICAgICAgICAgICAgIFN1
Y2Nlc3MhCiAgICAoY29uZmlkZW5jZSA4LCBkcml2ZXIgYHc4Mzc5MycpClByb2JpbmcgZm9y
IGBXaW5ib25kIFc4Mzc5MVNEJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vClBy
b2JpbmcgZm9yIGBXaW5ib25kIFc4MzYyN0hGJy4uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5vClByb2JpbmcgZm9yIGBXaW5ib25kIFc4MzYyN0VIRicuLi4gICAgICAgICAgICAg
ICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBXaW5ib25kIFc4MzYyN0RIRycuLi4gICAg
ICAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBBc3VzIEFTOTkxMjdGIChy
ZXYuMSknLi4uICAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBBc3VzIEFT
OTkxMjdGIChyZXYuMiknLi4uICAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9y
IGBBc3VzIEFTQjEwMCBCYWNoJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vClBy
b2JpbmcgZm9yIGBXaW5ib25kIFc4M0w3ODZOUi9ORy9SL0cnLi4uICAgICAgICAgICAgICAg
ICAgIE5vClByb2JpbmcgZm9yIGBBbmFsb2cgRGV2aWNlcyBBRE05MjQwJy4uLiAgICAgICAg
ICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBEYWxsYXMgU2VtaWNvbmR1Y3RvciBEUzE3
ODAnLi4uICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29u
ZHVjdG9yIExNODEnLi4uICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBBbmFsb2cg
RGV2aWNlcyBBRE0xMDI5Jy4uLiAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9y
IGBJVEUgSVQ4NzEyRicuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vClBy
b2JpbmcgZm9yIGBGaW50ZWsgY3VzdG9tIHBvd2VyIGNvbnRyb2wgSUMnLi4uICAgICAgICAg
ICAgIE5vClByb2JpbmcgZm9yIGBXaW5ib25kIFc4Mzc5MUQnLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE5vCkNsaWVudCBmb3VuZCBhdCBhZGRyZXNzIDB4NTAKUHJvYmluZyBm
b3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzMnLi4uICAgICAgICAgICAgICAgICAgICAgTm8K
UHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzQnLi4uICAgICAgICAgICAgICAg
ICAgICAgTm8KUHJvYmluZyBmb3IgYFNQRCBFRVBST00nLi4uICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgWWVzCiAgICAoY29uZmlkZW5jZSA4LCBub3QgYSBoYXJkd2FyZSBt
b25pdG9yaW5nIGNoaXApClByb2JpbmcgZm9yIGBFRElEIEVFUFJPTScuLi4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5vCkNsaWVudCBmb3VuZCBhdCBhZGRyZXNzIDB4NTEK
UHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzMnLi4uICAgICAgICAgICAgICAg
ICAgICAgTm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzQnLi4uICAgICAg
ICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFNQRCBFRVBST00nLi4uICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICAoY29uZmlkZW5jZSA4LCBub3QgYSBo
YXJkd2FyZSBtb25pdG9yaW5nIGNoaXApClByb2JpbmcgZm9yIGBFRElEIEVFUFJPTScuLi4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCkNsaWVudCBmb3VuZCBhdCBhZGRy
ZXNzIDB4NTIKUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzMnLi4uICAgICAg
ICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzQn
Li4uICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFNQRCBFRVBST00nLi4u
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICAoY29uZmlkZW5jZSA4
LCBub3QgYSBoYXJkd2FyZSBtb25pdG9yaW5nIGNoaXApClByb2JpbmcgZm9yIGBFRElEIEVF
UFJPTScuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCkNsaWVudCBmb3Vu
ZCBhdCBhZGRyZXNzIDB4NTMKUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzMn
Li4uICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2Vz
IEFETTEwMzQnLi4uICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFNQRCBF
RVBST00nLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICAoY29u
ZmlkZW5jZSA4LCBub3QgYSBoYXJkd2FyZSBtb25pdG9yaW5nIGNoaXApClByb2JpbmcgZm9y
IGBFRElEIEVFUFJPTScuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCgpT
b21lIGNoaXBzIGFyZSBhbHNvIGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgSVNBIEkvTyBwb3J0
cy4gV2UgaGF2ZSB0bwp3cml0ZSB0byBhcmJpdHJhcnkgSS9PIHBvcnRzIHRvIHByb2JlIHRo
ZW0uIFRoaXMgaXMgdXN1YWxseSBzYWZlIHRob3VnaC4KWWVzLCB5b3UgZG8gaGF2ZSBJU0Eg
SS9PIHBvcnRzIGV2ZW4gaWYgeW91IGRvIG5vdCBoYXZlIGFueSBJU0Egc2xvdHMhCkRvIHlv
dSB3YW50IHRvIHNjYW4gdGhlIElTQSBJL08gcG9ydHM/IChZRVMvbm8pOiBQcm9iaW5nIGZv
ciBgTmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTc4JyBhdCAweDI5MC4uLiAgICAgICBObwpQ
cm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTc4LUonIGF0IDB4MjkwLi4u
ICAgICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTc5JyBhdCAw
eDI5MC4uLiAgICAgICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM3ODFEJyBhdCAweDI5
MC4uLiAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM3ODJE
JyBhdCAweDI5MC4uLiAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgSVBNSSBC
TUMgS0NTJyBhdCAweGNhMC4uLiAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZv
ciBgSVBNSSBCTUMgU01JQycgYXQgMHhjYTguLi4gICAgICAgICAgICAgICAgICAgICBObwoK
U29tZSBTdXBlciBJL08gY2hpcHMgbWF5IGFsc28gY29udGFpbiBzZW5zb3JzLiBXZSBoYXZl
IHRvIHdyaXRlIHRvCnN0YW5kYXJkIEkvTyBwb3J0cyB0byBwcm9iZSB0aGVtLiBUaGlzIGlz
IHVzdWFsbHkgc2FmZS4KRG8geW91IHdhbnQgdG8gc2NhbiBmb3IgU3VwZXIgSS9PIHNlbnNv
cnM/IChZRVMvbm8pOiBQcm9iaW5nIGZvciBTdXBlci1JL08gYXQgMHgyZS8weDJmClRyeWlu
ZyBmYW1pbHkgYE5hdGlvbmFsIFNlbWljb25kdWN0b3InLi4uICAgICAgICAgICAgICAgICAg
IE5vClRyeWluZyBmYW1pbHkgYFNNU0MnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYFZJQS9XaW5ib25kL0ZpbnRlaycuLi4gICAg
ICAgICAgICAgICAgICAgICAgIFllcwpGb3VuZCBgV2luYm9uZCBXODM2MjdIRi9GL0hHL0cg
U3VwZXIgSU8gU2Vuc29ycycgICAgICAgICAgICBTdWNjZXNzIQogICAgKGFkZHJlc3MgMHgy
OTUsIGRyaXZlciBgdzgzNjI3aGYnKQpQcm9iaW5nIGZvciBTdXBlci1JL08gYXQgMHg0ZS8w
eDRmClRyeWluZyBmYW1pbHkgYE5hdGlvbmFsIFNlbWljb25kdWN0b3InLi4uICAgICAgICAg
ICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYFNNU0MnLi4uICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYFZJQS9XaW5ib25kL0ZpbnRl
aycuLi4gICAgICAgICAgICAgICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYElURScuLi4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCgpTb21lIHNvdXRoIGJy
aWRnZXMsIENQVXMgb3IgbWVtb3J5IGNvbnRyb2xsZXJzIG1heSBhbHNvIGNvbnRhaW4KZW1i
ZWRkZWQgc2Vuc29ycy4gRG8geW91IHdhbnQgdG8gc2NhbiBmb3IgdGhlbT8gKFlFUy9ubyk6
IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFNJUzU1OTUuLi4gICAgICAgICAgICAgICAg
ICAgICAgIE5vClZJQSBWVDgyQzY4NiBJbnRlZ3JhdGVkIFNlbnNvcnMuLi4gICAgICAgICAg
ICAgICAgICAgICAgICAgIE5vClZJQSBWVDgyMzEgSW50ZWdyYXRlZCBTZW5zb3JzLi4uICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5vCkFNRCBLOCB0aGVybWFsIHNlbnNvcnMuLi4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCkFNRCBLMTAgdGhlcm1hbCBz
ZW5zb3JzLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCkludGVsIENv
cmUgZmFtaWx5IHRoZXJtYWwgc2Vuc29yLi4uICAgICAgICAgICAgICAgICAgICAgICAgIFN1
Y2Nlc3MhCiAgICAoZHJpdmVyIGBjb3JldGVtcCcpCkludGVsIEFNQiBGQi1ESU1NIHRoZXJt
YWwgc2Vuc29yLi4uICAgICAgICAgICAgICAgICAgICAgICAgIE5vClZJQSBDNyB0aGVybWFs
IGFuZCB2b2x0YWdlIHNlbnNvcnMuLi4gICAgICAgICAgICAgICAgICAgICAgIE5vCgpOb3cg
Zm9sbG93cyBhIHN1bW1hcnkgb2YgdGhlIHByb2JlcyBJIGhhdmUganVzdCBkb25lLgpKdXN0
IHByZXNzIEVOVEVSIHRvIGNvbnRpbnVlOiAKRHJpdmVyIGB3ODM3OTMnIChzaG91bGQgYmUg
aW5zZXJ0ZWQpOgogIERldGVjdHMgY29ycmVjdGx5OgogICogQnVzIGBTTUJ1cyBJODAxIGFk
YXB0ZXIgYXQgMTEwMCcKICAgIEJ1c2RyaXZlciBgaTJjLWk4MDEnLCBJMkMgYWRkcmVzcyAw
eDJmCiAgICBDaGlwIGBXaW5ib25kIFc4Mzc5M1IvRycgKGNvbmZpZGVuY2U6IDgpCgpEcml2
ZXIgYHc4MzYyN2hmJyAoc2hvdWxkIGJlIGluc2VydGVkKToKICBEZXRlY3RzIGNvcnJlY3Rs
eToKICAqIElTQSBidXMsIGFkZHJlc3MgMHgyOTUKICAgIENoaXAgYFdpbmJvbmQgVzgzNjI3
SEYvRi9IRy9HIFN1cGVyIElPIFNlbnNvcnMnIChjb25maWRlbmNlOiA5KQoKRHJpdmVyIGBj
b3JldGVtcCcgKHNob3VsZCBiZSBpbnNlcnRlZCk6CiAgRGV0ZWN0cyBjb3JyZWN0bHk6CiAg
KiBDaGlwIGBJbnRlbCBDb3JlIGZhbWlseSB0aGVybWFsIHNlbnNvcicgKGNvbmZpZGVuY2U6
IDkpCgpEbyB5b3Ugd2FudCB0byBvdmVyd3JpdGUgL2V0Yy9zeXNjb25maWcvbG1fc2Vuc29y
cz8gKFlFUy9ubyk6IFN0YXJ0aW5nIGxtX3NlbnNvcnM6IBtbNjBHWxtbMDszMm0gIE9LICAb
WzA7MzltXQ0K
--------------040700020704090201060602
Content-Type: text/plain;
 name="sensors.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="sensors.txt"

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.00 V  (min =  +1.09 V, max =  +1.50 V)       ALARM  
VCore 2:   +0.00 V  (min =  +1.09 V, max =  +1.50 V)       ALARM  
+3.3V:     +0.00 V  (min =  +2.82 V, max =  +3.79 V)       ALARM  
+5V:       +5.00 V  (min =  +3.52 V, max =  +1.72 V)       ALARM  
+12V:      +0.00 V  (min =  +0.79 V, max =  +8.63 V)       ALARM  
-12V:     -14.91 V  (min =  -4.14 V, max =  +3.51 V)       ALARM  
-5V:       -7.71 V  (min =  -4.14 V, max =  -2.84 V)       ALARM  
V5SB:      +5.56 V  (min =  +0.91 V, max =  +2.20 V)       ALARM  
VBat:      +3.34 V  (min =  +0.69 V, max =  +3.10 V)       ALARM  
fan1:        0 RPM  (min = 4141 RPM, div = 2)              ALARM  
fan2:        0 RPM  (min = 2922 RPM, div = 2)              ALARM  
fan3:        0 RPM  (min = 135000 RPM, div = 2)              ALARM  
temp1:      +127������C  (high =   +72������C, hyst =  +102������C)   sensor = thermistor   ALARM   
temp2:    +127.0������C  (high =   +80������C, hyst =   +75������C)   sensor = thermistor   ALARM   
temp3:    +127.0������C  (high =   +80������C, hyst =   +75������C)   sensor = thermistor   ALARM   
vid:      +1.300 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +48������C  (high =  +100������C)                   

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +44������C  (high =  +100������C)                   

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +49������C  (high =  +100������C)                   

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +57������C  (high =  +100������C)                   


--------------040700020704090201060602
Content-Type: text/plain;
 name="lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lsmod.txt"

Module                  Size  Used by
coretemp               42112  0 
w83627hf               64276  0 
hwmon_vid              35905  1 w83627hf
hwmon                  36553  2 coretemp,w83627hf
i2c_dev                43977  0 
autofs4                57033  2 
ip_conntrack_ftp       41361  0 
ip_conntrack_netbios_ns    36033  0 
ipt_REJECT             38849  1 
xt_state               35265  16 
ip_conntrack           91237  3 ip_conntrack_ftp,ip_conntrack_netbios_ns,xt_state
nfnetlink              40457  1 ip_conntrack
iptable_filter         36161  1 
ip_tables              55329  1 iptable_filter
ip6t_REJECT            38849  1 
xt_tcpudp              36289  38 
ip6table_filter        36033  1 
ip6_tables             50049  1 ip6table_filter
x_tables               50377  6 ipt_REJECT,xt_state,ip_tables,ip6t_REJECT,xt_tcpudp,ip6_tables
ipv6                  424737  31 ip6t_REJECT
xfrm_nalgo             43333  1 ipv6
crypto_api             42945  1 xfrm_nalgo
cpufreq_ondemand       42449  4 
acpi_cpufreq           47937  1 
freq_table             40889  2 cpufreq_ondemand,acpi_cpufreq
dm_multipath           55257  0 
scsi_dh                41665  1 dm_multipath
video                  53069  0 
backlight              39873  1 video
sbs                    49921  0 
i2c_ec                 38593  1 sbs
button                 40545  0 
battery                43849  0 
asus_acpi              50917  0 
acpi_memhotplug        40133  0 
ac                     38729  0 
lp                     47121  0 
floppy                 95465  0 
sg                     69993  0 
parport_pc             62313  1 
parport                73165  2 lp,parport_pc
i2c_i801               41813  0 
i2c_core               56129  3 i2c_dev,i2c_ec,i2c_i801
e1000e                145809  0 
shpchp                 70765  0 
pcspkr                 36289  0 
dm_raid45              99025  0 
dm_message             36289  1 dm_raid45
dm_region_hash         46145  1 dm_raid45
dm_mem_cache           38977  1 dm_raid45
dm_snapshot            51465  0 
dm_zero                35265  0 
dm_mirror              54089  0 
dm_log                 44865  3 dm_raid45,dm_region_hash,dm_mirror
dm_mod                100369  13 dm_multipath,dm_raid45,dm_snapshot,dm_zero,dm_mirror,dm_log
ahci                   68937  4 
libata                208849  1 ahci
sd_mod                 56385  6 
scsi_mod              196569  4 scsi_dh,sg,libata,sd_mod
raid1                  56001  2 
ext3                  167889  3 
jbd                    94257  1 ext3
uhci_hcd               57433  0 
ohci_hcd               55925  0 
ehci_hcd               65613  0 

--------------040700020704090201060602
Content-Type: text/plain;
 name="i2cdetect0.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2cdetect0.txt"

WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- 0c -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 1f 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2f 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- 46 -- -- -- -- -- -- -- -- -- 
50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- -- 
60: 60 61 -- -- -- -- -- -- -- 69 -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         

--------------040700020704090201060602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040700020704090201060602--
