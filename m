From: derek bonuccelli <dirksauce@hotmail.com>
Date: Thu, 09 Jun 2011 00:24:19 +0000
Subject: [lm-sensors] Master Configuration File Location
Message-Id: <COL119-W612399EB5F87CF7E73BF57BA650@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8975747722179045453=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8975747722179045453==
Content-Type: multipart/alternative;
	boundary="_f819ea3c-5dec-406e-9003-84584a217799_"

--_f819ea3c-5dec-406e-9003-84584a217799_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I apologize if this is the wrong place to ask this but I am at my wits end.=
 What I am looking to do is copy the config file to identical motherboards =
on remote machines that have not run sensors-detect. From an already instal=
led/configured computer I attempted to find a file=2C if deleted=2C makes i=
t return back to "not configured. run sensors-detect" state=2C so that I ca=
n copy the file over to another computer and be good to go. I have been uns=
uccessful at finding such a file=2C and removing lm_sensors does not clear =
the config.
Deleting the following files does not stop 'sensors' from outputting sensor=
 data.
/etc/init.d/lm_sensors/etc/sysconfig/lm_sensors (also tried deleting MODULE=
_ line to no avail)/etc/sensors.conf
If anyone can point me in the right direction I would be forever grateful. =
Thank you in advance. 		 	   		  =

--_f819ea3c-5dec-406e-9003-84584a217799_
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
--></style>
</head>
<body class=3D'hmmessage'>
I apologize if this is the wrong place to ask this but I am at my wits end.=
 What I am looking to do is copy the config file to identical motherboards =
on remote machines that have not run sensors-detect. From an already instal=
led/configured computer I attempted to find a file=2C if deleted=2C makes i=
t return back to "not configured. run sensors-detect" state=2C so that I ca=
n copy the file over to another computer and be good to go. I have been uns=
uccessful at finding such a file=2C and removing lm_sensors does not clear =
the config.<div><br></div><div>Deleting the following files does not stop '=
sensors' from outputting sensor data.</div><div><br></div><div>/etc/init.d/=
lm_sensors</div><div>/etc/sysconfig/lm_sensors (also tried deleting MODULE_=
 line to no avail)</div><div>/etc/sensors.conf</div><div><br></div><div>If =
anyone can point me in the right direction I would be forever grateful. Tha=
nk you in advance.</div> 		 	   		  </body>
</html>=

--_f819ea3c-5dec-406e-9003-84584a217799_--


--===============8975747722179045453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8975747722179045453==--
