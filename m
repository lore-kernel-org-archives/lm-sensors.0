From: Tomas Johansson <tomasx@hotmail.com>
Date: Fri, 23 Mar 2012 14:07:07 +0000
Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
Message-Id: <SNT106-W113084A54F7DC67573281AD3460@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8927954132867278073=="
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
In-Reply-To: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============8927954132867278073==
Content-Type: multipart/alternative;
	boundary="_ac3aca3d-d192-4392-a124-47a46a2ba599_"

--_ac3aca3d-d192-4392-a124-47a46a2ba599_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> I have seen this in the past=2C many=2C many times. I'm in this
> "business" (and I'm using quotes because it's mostly done on my spare
> time) for 8 years so I have some experience about it all.
>=20
> Let's just take the machine I'm working on right now as an example.
> It's a Celeron 2.4 GHz on an Asus P4P800-VM board=2C using a Winbond
> W83627THF for monitoring. The BIOS displays a CPU temperature of
> 39.5=B0C. Linux displays a CPU temperature of 32.5=B0C. This is a 6=B0C
> difference=2C close to what you're seeing on your system.
>=20
> This machine happens to be plugged on a powermeter=2C so I can see that
> it consumes 84 W in the BIOS=2C and only 62 W under Linux. So the
> temperature difference is easily explained. As a matter of fact=2C if I
> put some load on the CPU (md5sum -b /dev/zero) the temperature climbs
> to 40=B0C=2C so roughly the same as what the BIOS prints.
>=20
> I am not claiming that there is no bug in our IT8728F support. Without
> a datasheet=2C odds are there are bugs. I am not even claiming that no
> adjustments must be made for "sensors" to report the right CPU
> temperature on your specific system. I am claiming that you did not
> provide factual data that would make me regard this possibility as
> likely.
>=20
> If you want to make sure=2C then get your hands on a powermeter=2C or
> external thermometer=2C or ideally both. Then compare their measurements
> under the BIOS and under Linux. If these measurements are the same and
> the CPU temperature values reported by the BIOS and "sensors" differ
> significantly=2C then OK=2C I'll admit some more investigation=2C and pos=
sible
> a fix=2C are needed.
>=20
> --=20
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html

Now we are talking=2C thanks for the information. :)
I
 guess=2C my original intention with my letter wasn=B4t giving you more wor=
k
 but rather broadcasting that it might be a problem with the IT8728F=20
support=2C i guess with 3.3 out we will soon see more usage of it. And=20
maybe more people will report=2C or not...

With your experience what would you recommend.
1. Asssuming ~26 C is the real idle value
2. fiddle with the lm sensors config file and add a couple of degrees
3. Get a life and stop monitoring my fan speeds and temps

Thanks for your help

Tomas
 		 	   		  =

--_ac3aca3d-d192-4392-a124-47a46a2ba599_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
&gt=3B I have seen this in the past=2C many=2C many times. I'm in this<br>&=
gt=3B "business" (and I'm using quotes because it's mostly done on my spare=
<br>&gt=3B time) for 8 years so I have some experience about it all.<br>&gt=
=3B <br>&gt=3B Let's just take the machine I'm working on right now as an e=
xample.<br>&gt=3B It's a Celeron 2.4 GHz on an Asus P4P800-VM board=2C usin=
g a Winbond<br>&gt=3B W83627THF for monitoring. The BIOS displays a CPU tem=
perature of<br>&gt=3B 39.5=B0C. Linux displays a CPU temperature of 32.5=B0=
C. This is a 6=B0C<br>&gt=3B difference=2C close to what you're seeing on y=
our system.<br>&gt=3B <br>&gt=3B This machine happens to be plugged on a po=
wermeter=2C so I can see that<br>&gt=3B it consumes 84 W in the BIOS=2C and=
 only 62 W under Linux. So the<br>&gt=3B temperature difference is easily e=
xplained. As a matter of fact=2C if I<br>&gt=3B put some load on the CPU (m=
d5sum -b /dev/zero) the temperature climbs<br>&gt=3B to 40=B0C=2C so roughl=
y the same as what the BIOS prints.<br>&gt=3B <br>&gt=3B I am not claiming =
that there is no bug in our IT8728F support. Without<br>&gt=3B a datasheet=
=2C odds are there are bugs. I am not even claiming that no<br>&gt=3B adjus=
tments must be made for "sensors" to report the right CPU<br>&gt=3B tempera=
ture on your specific system. I am claiming that you did not<br>&gt=3B prov=
ide factual data that would make me regard this possibility as<br>&gt=3B li=
kely.<br>&gt=3B <br>&gt=3B If you want to make sure=2C then get your hands =
on a powermeter=2C or<br>&gt=3B external thermometer=2C or ideally both. Th=
en compare their measurements<br>&gt=3B under the BIOS and under Linux. If =
these measurements are the same and<br>&gt=3B the CPU temperature values re=
ported by the BIOS and "sensors" differ<br>&gt=3B significantly=2C then OK=
=2C I'll admit some more investigation=2C and possible<br>&gt=3B a fix=2C a=
re needed.<br>&gt=3B <br>&gt=3B -- <br>&gt=3B Jean Delvare<br>&gt=3B http:/=
/khali.linux-fr.org/wishlist.html<br><br>Now we are talking=2C thanks for t=
he information. :)<br>I
 guess=2C my original intention with my letter wasn=B4t giving you more wor=
k
 but rather broadcasting that it might be a problem with the IT8728F=20
support=2C i guess with 3.3 out we will soon see more usage of it. And=20
maybe more people will report=2C or not...<br><br>With your experience what=
 would you recommend.<br>1. Asssuming ~26 C is the real idle value<br>2. fi=
ddle with the lm sensors config file and add a couple of degrees<br>3. Get =
a life and stop monitoring my fan speeds and temps<br><br>Thanks for your h=
elp<br><br>Tomas<br> 		 	   		  </div></body>
</html>=

--_ac3aca3d-d192-4392-a124-47a46a2ba599_--


--===============8927954132867278073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8927954132867278073==--
