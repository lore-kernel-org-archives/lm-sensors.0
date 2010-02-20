From: Otto <otto@vanouwerkerk.com>
Date: Sat, 20 Feb 2010 16:45:19 +0000
Subject: Re: [lm-sensors] sensors in kernel 2.6.31
Message-Id: <alpine.DEB.2.00.1002201734250.18810@kermit.vanouwerkerk.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1697266717-1765094829-1266684275=:24069"
List-Id: <lm-sensors.vger.kernel.org>
References: <4B643CC1.2000003@redhat.com>
In-Reply-To: <4B643CC1.2000003@redhat.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1697266717-1765094829-1266684275=:24069
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; format=flowed
Content-ID: <alpine.DEB.2.00.1002201745071.3477@kermit.vanouwerkerk.com>

Hi,

At the moment my Linux server is running kernel 2.6.31-19 and using the 
asus_atk0110 kernel module. As I discussed with Hans de Goede in Dutch 
below, unfortunately the command `sensors` is only functioning on my 
system when using the 'acpi_enforce_resources=lax' kernel option. Hans 
advised me to send this email, because I have an Asus motherboard and it's 
a bad idea to use both the acp_enforce_resources option and the 
asus_atk0110 driver.

Cheers,
Otto

Ps. More info on my system is attached in the file sysinfo.txt.





On Sat, 30 Jan 2010, Hans de Goede wrote:
> Ah, dan moet je even een mailtje (in het engels) sturen naar:
> lm-sensors@lm-sensors.org, met daarin dat de asus_atk0110 driver
> niet werkt op jouw moederbord + het model van je moederbord.
>
> Dan reageert de auteur van de asus_atk0110 driver vanzelf. Goed
> mogelijk trouwens dat dit al gefixed is in een latere versie,
> maar dat zegt hij dan wel.
>
> NB het mengen van acp_enforce_resources=lax met de asus_atk0110 driver
> is een erg slecht idee!
>
> MvG,
>
> Hans
---1697266717-1765094829-1266684275=:24069
Content-Type: TEXT/PLAIN; NAME=sysinfo.txt
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.1002201744350.24069@kermit.vanouwerkerk.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=sysinfo.txt

cm9vdEB0b21taWU6fiMgbHNwY2kNCjAwOjAwLjAgSG9zdCBicmlkZ2U6IElu
dGVsIENvcnBvcmF0aW9uIDgyRzMzL0czMS9QMzUvUDMxIEV4cHJlc3MgRFJB
TSBDb250cm9sbGVyIChyZXYgMDIpDQowMDowMi4wIFZHQSBjb21wYXRpYmxl
IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyRzMzL0czMSBFeHBy
ZXNzIEludGVncmF0ZWQgR3JhcGhpY3MgQ29udHJvbGxlciAocmV2IDAyKQ0K
MDA6MDIuMSBEaXNwbGF5IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9u
IDgyRzMzL0czMSBFeHByZXNzIEludGVncmF0ZWQgR3JhcGhpY3MgQ29udHJv
bGxlciAocmV2IDAyKQ0KMDA6MWEuMCBVU0IgQ29udHJvbGxlcjogSW50ZWwg
Q29ycG9yYXRpb24gODI4MDFJIChJQ0g5IEZhbWlseSkgVVNCIFVIQ0kgQ29u
dHJvbGxlciAjNCAocmV2IDAyKQ0KMDA6MWEuMSBVU0IgQ29udHJvbGxlcjog
SW50ZWwgQ29ycG9yYXRpb24gODI4MDFJIChJQ0g5IEZhbWlseSkgVVNCIFVI
Q0kgQ29udHJvbGxlciAjNSAocmV2IDAyKQ0KMDA6MWEuMiBVU0IgQ29udHJv
bGxlcjogSW50ZWwgQ29ycG9yYXRpb24gODI4MDFJIChJQ0g5IEZhbWlseSkg
VVNCIFVIQ0kgQ29udHJvbGxlciAjNiAocmV2IDAyKQ0KMDA6MWEuNyBVU0Ig
Q29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gODI4MDFJIChJQ0g5IEZh
bWlseSkgVVNCMiBFSENJIENvbnRyb2xsZXIgIzIgKHJldiAwMikNCjAwOjFj
LjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDFJIChJQ0g5
IEZhbWlseSkgUENJIEV4cHJlc3MgUG9ydCAxIChyZXYgMDIpDQowMDoxYy4y
IFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSSAoSUNIOSBG
YW1pbHkpIFBDSSBFeHByZXNzIFBvcnQgMyAocmV2IDAyKQ0KMDA6MWMuNSBQ
Q0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUkgKElDSDkgRmFt
aWx5KSBQQ0kgRXhwcmVzcyBQb3J0IDYgKHJldiAwMikNCjAwOjFkLjAgVVNC
IENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSSAoSUNIOSBG
YW1pbHkpIFVTQiBVSENJIENvbnRyb2xsZXIgIzEgKHJldiAwMikNCjAwOjFk
LjEgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSSAo
SUNIOSBGYW1pbHkpIFVTQiBVSENJIENvbnRyb2xsZXIgIzIgKHJldiAwMikN
CjAwOjFkLjIgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgy
ODAxSSAoSUNIOSBGYW1pbHkpIFVTQiBVSENJIENvbnRyb2xsZXIgIzMgKHJl
diAwMikNCjAwOjFkLjcgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0
aW9uIDgyODAxSSAoSUNIOSBGYW1pbHkpIFVTQjIgRUhDSSBDb250cm9sbGVy
ICMxIChyZXYgMDIpDQowMDoxZS4wIFBDSSBicmlkZ2U6IEludGVsIENvcnBv
cmF0aW9uIDgyODAxIFBDSSBCcmlkZ2UgKHJldiA5MikNCjAwOjFmLjAgSVNB
IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDFJQiAoSUNIOSkgTFBD
IEludGVyZmFjZSBDb250cm9sbGVyIChyZXYgMDIpDQowMDoxZi4yIElERSBp
bnRlcmZhY2U6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSUIgKElDSDkpIDIg
cG9ydCBTQVRBIElERSBDb250cm9sbGVyIChyZXYgMDIpDQowMDoxZi4zIFNN
QnVzOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUkgKElDSDkgRmFtaWx5KSBT
TUJ1cyBDb250cm9sbGVyIChyZXYgMDIpDQowMDoxZi41IElERSBpbnRlcmZh
Y2U6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSSAoSUNIOSBGYW1pbHkpIDIg
cG9ydCBTQVRBIElERSBDb250cm9sbGVyIChyZXYgMDIpDQowMTowMC4wIEV0
aGVybmV0IGNvbnRyb2xsZXI6IEF0dGFuc2ljIFRlY2hub2xvZ3kgQ29ycC4g
TDEgR2lnYWJpdCBFdGhlcm5ldCBBZGFwdGVyIChyZXYgYjApDQowMjowMC4w
IEV0aGVybmV0IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyNTcy
RUkgR2lnYWJpdCBFdGhlcm5ldCBDb250cm9sbGVyIChDb3BwZXIpIChyZXYg
MDYpDQoNCnJvb3RAdG9tbWllOn4jIHVuYW1lIC1hDQpMaW51eCB0b21taWUu
dmFub3V3ZXJrZXJrLmNvbSAyLjYuMzEtMTktc2VydmVyICM1Ni1VYnVudHUg
U01QIFRodSBKYW4gMjggMDM6NDA6NDggVVRDIDIwMTAgeDg2XzY0IEdOVS9M
aW51eA0KDQpyb290QHRvbW1pZTp+IyBzdHJpbmdzIC9kZXYvbWVtIHxncmVw
IFA1DQpQNUstVg0KUDVLLVYNClA1Sw0KDQpyb290QHRvbW1pZTp+IyBzdHJp
bmdzIC9kZXYvbWVtIHxncmVwIEFTVVMNCkFTVVNUZUsgQ29tcHV0ZXIgSU5D
Lg0KQVNVU1RlSyBQZWdhc3VzDQoNCnJvb3RAdG9tbWllOn4jIGxzbW9kIHxn
cmVwIGFzdXMgLWkNCmFzdXNfYXRrMDExMCAgICAgICAgICAgIDk0NzIgIDAN
Cg0Kcm9vdEB0b21taWU6fiMgbHNiX3JlbGVhc2UgLWENCk5vIExTQiBtb2R1
bGVzIGFyZSBhdmFpbGFibGUuDQpEaXN0cmlidXRvciBJRDogVWJ1bnR1DQpE
ZXNjcmlwdGlvbjogICAgVWJ1bnR1IDkuMTANClJlbGVhc2U6ICAgICAgICA5
LjEwDQpDb2RlbmFtZTogICAgICAga2FybWljDQo=

---1697266717-1765094829-1266684275=:24069
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1697266717-1765094829-1266684275=:24069--
