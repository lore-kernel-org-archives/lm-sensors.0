From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Sat, 07 May 2011 16:23:57 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110507162357.B19E71A987F@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="==_Exmh_1304785426_32810"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
To: lm-sensors@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1304785426_32810
Content-Type: text/plain; charset=us-ascii


Hi Jean --

Here is the output from /usr/bin/sensors with the
ecm6w201 driver you just gave us AND from the
new i8k driver you mentioned in an earlier e-mail today.

Thanks for your work on this!!!

	Harry McGavran


On Sat, 7 May 2011 13:47:21 +0200 Jean Delvare wrote:
> Hi Harry, Ric and Jeff,
> 
> On Thu, 05 May 2011 10:40:28 -0600, Harry G McGavran Jr wrote:
> > I can hope for an lm-sensors driver...
> 
> I found some time to work on EMC6W201 support and I have something for
> you to test. My standalone driver for this chip can be downloaded from:
>   http://khali.linux-fr.org/devel/misc/emc6w201/
> You only need i2c-compat.h for kernels <= 2.6.32. I build-tested the
> driver down to kernel 2.6.27, older kernels may or may not work.
> emc6w201.conf is a template configuration file, copy to /etc/sensors.d
> and add statements as needed. Generic build instructions are available
> at:
>   http://khali.linux-fr.org/devel/misc/INSTALL
> 
> At this point the driver only supports basic monitoring, in read-only
> mode. It seems to work reasonably well on the dumps sent by Harry and
> Jeff, but real hardware can behave differently.
> 
> Anyway, let me know how it goes.
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html


--==_Exmh_1304785426_32810
Content-Type: application/octet-stream ; name="sensors.out"
Content-Description: sensors.out
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sensors.out"

aThrLXZpcnR1YWwtMApBZGFwdGVyOiBWaXJ0dWFsIGRldmljZQpMZWZ0IEZhbjogICA2NDcxMCBS
UE0KUmlnaHQgRmFuOiAgNDg0MjAgUlBNCkNQVTogICAgICAgICAtMjIuMCBDICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCgplbWM2dzIwMS1pMmMtMy0yZQpBZGFwdGVyOiBTTUJ1
cyBJODAxIGFkYXB0ZXIgYXQgZThhMAppbjA6ICAgICAgICAgKzEuODIgViAgKG1pbiA9ICArMS42
NCBWLCBtYXggPSAgKzEuOTggVikKaW4xOiAgICAgICAgICsxLjI2IFYgIChtaW4gPSAgKzAuNzgg
ViwgbWF4ID0gICsxLjcwIFYpCmluMjogICAgICAgICArMy4zMyBWICAobWluID0gICszLjA4IFYs
IG1heCA9ICArMy41MiBWKQppbjM6ICAgICAgICAgKzUuMTAgViAgKG1pbiA9ICArNC42NiBWLCBt
YXggPSAgKzUuMzQgVikKaW40OiAgICAgICAgICsxLjUxIFYgIChtaW4gPSAgKzEuNDAgViwgbWF4
ID0gICsxLjYwIFYpCmluNTogICAgICAgICArMC4wMCBWICAobWluID0gICswLjc4IFYsIG1heCA9
ICArMS43MCBWKQpmYW4xOiAgICAgICAxNjE0IFJQTSAgKG1pbiA9ICAzMDAgUlBNKQpmYW4yOiAg
ICAgICAgICAwIFJQTSAgKG1pbiA9ICAzMDAgUlBNKQpmYW4zOiAgICAgICAyMTUzIFJQTSAgKG1p
biA9ICAyMDAgUlBNKQpmYW40OiAgICAgICAgICAwIFJQTSAgKG1pbiA9ICAgODIgUlBNKQpmYW41
OiAgICAgICAgICAwIFJQTSAgKG1pbiA9ICAgODIgUlBNKQp0ZW1wMTogICAgICAgKzU0LjAgQyAg
KGxvdyAgPSAtMTI3LjAgQywgaGlnaCA9ICs4OC4wIEMpICAKdGVtcDI6ICAgICAgICArMC4wIEMg
IChsb3cgID0gLTEyNy4wIEMsIGhpZ2ggPSArODguMCBDKSAgCnRlbXAzOiAgICAgICAgKzAuMCBD
ICAobG93ICA9IC0xMjcuMCBDLCBoaWdoID0gKzYwLjAgQykgIAp0ZW1wNDogICAgICAgICswLjAg
QyAgKGxvdyAgPSAtMTI3LjAgQywgaGlnaCA9ICs1NS4wIEMpICAKdGVtcDU6ICAgICAgICs0OC4w
IEMgIChsb3cgID0gLTEyNy4wIEMsIGhpZ2ggPSArNzUuMCBDKSAgCnRlbXA2OiAgICAgICArNDQu
MCBDICAobG93ICA9IC0xMjcuMCBDLCBoaWdoID0gKzgwLjAgQykgIAoK

--==_Exmh_1304785426_32810
Content-Type: text/plain; charset=us-ascii


Harry G. McGavran, Jr.

E-mail: w5pny@w5pny.com


--==_Exmh_1304785426_32810
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--==_Exmh_1304785426_32810--


