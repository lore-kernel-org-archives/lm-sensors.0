From: "Mr. Tux" <tuxoholic@hotmail.de>
Date: Tue, 12 May 2009 17:55:10 +0000
Subject: Re: [lm-sensors] 5VSB computing on it87
Message-Id: <BLU120-W16A2919EF63B26A6985A6AD8600@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1407279743990995256=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
In-Reply-To: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============1407279743990995256==
Content-Type: multipart/alternative;
	boundary="_0e439557-4af1-4cc6-b58c-137dbfcf1804_"

--_0e439557-4af1-4cc6-b58c-137dbfcf1804_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Thank you Jean

So=2C this sensor is not assigned correctly=2C I could life with that for t=
he moment=2C but my problem
is the alarm flag this sensors is causing=2C since the value for some reaso=
n is saturated.

I'd like to put this sensor on ignore for the moment=2C but I don't know ho=
w to do that:

*) ignore in7 - only prevents the sensor to be listed using the 'sensors' c=
ommand
*) comment every line mentioning in7 in sensors3.conf - makes it appear und=
er
/sys/devices/plattform/[...]/ anyway ! With the alarm flag in "in7_alarm" s=
et to 1 - I need to get rid
of that...
*) trying to set in7 to value 0 (=3D unused): 'set in7_type  0' causes a pa=
rse error with 'sensors -s'
*) trying to raise the max_value barrier switching on the alarm: 'set in7_m=
ax    7 * 1.05'
this does not have an effect - the max limit stays at 6=2C.85=2C triggering=
 the alarm!

What else can I try? I need the alarm flag in /sys/devices/plattform/[...]/=
in7_alarm to
be set to '0' - since I'm writing a small daemon who will parse for alarm v=
alues
only=2C starting a speaker beep when a alarm is discovered.

Thanks in advance for any help.

Mr Tux

> On Mon=2C 11 May 2009 10:07:30 +0200=2C Mr. Tux wrote:
> > My Foxconn A7GM-S keep showing the wrong Voltage of 5VSB sensor.
> >=20
> > This one shows up in BIOS as well=2C so it is connected and should indi=
cate about 5.02V
> >=20
> > But 'sensors' with it87 module loaded keeps showing 6.85V - how to chan=
ge the compute
> > line in order to get the 5.02V?
> >=20
> > At the moment the compute line is the default:
> >=20
> > compute in7  ((6.8/10)+1)*@ =2C @/((6.8/10)+1)
>=20
> I can't help but notice that 6.85 =3D=3D ((6.8/10)+1)*4.08. The IT87xxF
> chips have a 4.08V DAC=2C meaning that this input channel is saturated.
> Thus I pretty much doubt it corresponds to your 5VSB line.
>=20
> --=20
> Jean Delvare

_________________________________________________________________
http://redirect.gimas.net/?n=3DM0905xIE8_MSN4
Internet Explorer 8 jetzt f=FCr MSN  - kostenlos!=

--_0e439557-4af1-4cc6-b58c-137dbfcf1804_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Thank you Jean<br><br>So=2C this sensor is not assigned correctly=2C I coul=
d life with that for the moment=2C but my problem<br>is the alarm flag this=
 sensors is causing=2C since the value for some reason is saturated.<br><br=
>I'd like to put this sensor on ignore for the moment=2C but I don't know h=
ow to do that:<br><br>*) ignore in7 - only prevents the sensor to be listed=
 using the 'sensors' command<br>*) comment every line mentioning in7 in sen=
sors3.conf - makes it appear under<br>/sys/devices/plattform/[...]/ anyway =
! With the alarm flag in "in7_alarm" set to 1 - I need to get rid<br>of tha=
t...<br>*) trying to set in7 to value 0 (=3D unused): 'set in7_type&nbsp=3B=
 0' causes a parse error with 'sensors -s'<br>*) trying to raise the max_va=
lue barrier switching on the alarm: 'set in7_max&nbsp=3B&nbsp=3B&nbsp=3B 7 =
* 1.05'<br>this does not have an effect - the max limit stays at 6=2C.85=2C=
 triggering the alarm!<br><br>What else can I try? I need the alarm flag in=
 /sys/devices/plattform/[...]/in7_alarm to<br>be set to '0' - since I'm wri=
ting a small daemon who will parse for alarm values<br>only=2C starting a s=
peaker beep when a alarm is discovered.<br><br>Thanks in advance for any he=
lp.<br><br>Mr Tux<br><br>&gt=3B On Mon=2C 11 May 2009 10:07:30 +0200=2C Mr.=
 Tux wrote:<br>&gt=3B &gt=3B My Foxconn A7GM-S keep showing the wrong Volta=
ge of 5VSB sensor.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B This one shows up in =
BIOS as well=2C so it is connected and should indicate about 5.02V<br>&gt=
=3B &gt=3B <br>&gt=3B &gt=3B But 'sensors' with it87 module loaded keeps sh=
owing 6.85V - how to change the compute<br>&gt=3B &gt=3B line in order to g=
et the 5.02V?<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B At the moment the compute =
line is the default:<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B compute in7  ((6.8/=
10)+1)*@ =2C @/((6.8/10)+1)<br>&gt=3B <br>&gt=3B I can't help but notice th=
at 6.85 =3D=3D ((6.8/10)+1)*4.08. The IT87xxF<br>&gt=3B chips have a 4.08V =
DAC=2C meaning that this input channel is saturated.<br>&gt=3B Thus I prett=
y much doubt it corresponds to your 5VSB line.<br>&gt=3B <br>&gt=3B -- <br>=
&gt=3B Jean Delvare<br><br /><hr />Mehr Sicherheit und Datenschutz - der ne=
ue  Internet Explorer 8 f=FCr MSN <a href=3D'http://redirect.gimas.net/?n=
=3DM0905IE8_MSN2' target=3D'_new'>Jetzt sofort kostenlos downloaden!</a></b=
ody>
</html>=

--_0e439557-4af1-4cc6-b58c-137dbfcf1804_--


--===============1407279743990995256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1407279743990995256==--
