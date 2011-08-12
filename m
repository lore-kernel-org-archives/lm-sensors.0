From: Wayne Tams <wayne.tams@gmail.com>
Date: Fri, 12 Aug 2011 09:21:15 +0000
Subject: [lm-sensors] How can I use two command bytes for a block read?
Message-Id: <CAN=k24me3-OrpzHBww2J2_x62+iDtSRBTHwGH7pZ4RMqxSgpFA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9107774423015313303=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============9107774423015313303==
Content-Type: multipart/alternative; boundary=00163630eb05a6cf0704aa4b707b

--00163630eb05a6cf0704aa4b707b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am having a little bother interfacing with a device that requires two
command bytes for both reads and writes. I can perform a successful write
using I2C writes but I would rather use the user-space i2c_smbus_ functions
from i2c-dev.h. In the i2c-dev documentation (
http://lxr.free-electrons.com/source/Documentation/i2c/smbus-protocol?v=2.6.35;a=arm#L225)
there
is a mention of a two byte command block read but there does not appear to
be any supporting function in i2c-dev.h. Is there a patch available to add
this functionality or could there be another approach?

Just to clarify I need my smbus read transaction to look like this:


 S Addr Wr [A] Comm1 [A] Comm2 [A] S Addr Rd [A] [Data] A [Data] A ...
A [Data] NA P

Thanks

Wayne

--00163630eb05a6cf0704aa4b707b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I am having a little bother interfacing with a devic=
e that requires two command bytes for both reads and writes. I can perform =
a successful write using I2C writes but I would rather use the=A0user-space=
=A0i2c_smbus_ functions from i2c-dev.h. In the i2c-dev documentation (<a hr=
ef=3D"http://lxr.free-electrons.com/source/Documentation/i2c/smbus-protocol=
?v=3D2.6.35;a=3Darm#L225">http://lxr.free-electrons.com/source/Documentatio=
n/i2c/smbus-protocol?v=3D2.6.35;a=3Darm#L225</a>)=A0there is a mention of a=
 two byte command block read but there does not appear to be any supporting=
 function in i2c-dev.h. Is there a patch available to add this functionalit=
y or could there be another approach?</div>

<div><br></div><div>Just to clarify I need my smbus read transaction to loo=
k like this:</div><div><br></div><div><span class=3D"Apple-style-span" styl=
e=3D"color: rgb(120, 120, 120); font-family: &#39;Lucida Grande&#39;, Verda=
na, Arial, sans-serif; font-size: 14px; font-weight: bold; background-color=
: rgb(255, 255, 255); "><pre style=3D"font-family: Monaco, &#39;Courier New=
&#39;, Courier, monospace; font-size: 0.95em; padding-top: 1em; padding-rig=
ht: 1em; padding-bottom: 1em; padding-left: 1em; color: rgb(120, 120, 120);=
 background-color: white; overflow-x: auto; overflow-y: auto; ">

 S Addr Wr [A] Comm1 [A] Comm2 [A] S Addr Rd [A] [Data] A [Data] A ... A [D=
ata] NA P</pre></span><div>Thanks</div><div><br></div><div>Wayne</div></div=
>

--00163630eb05a6cf0704aa4b707b--


--===============9107774423015313303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9107774423015313303==--
