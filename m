From: Vahid Keykhaey <vahid.keykhaey@gmail.com>
Date: Tue, 11 Dec 2012 09:44:50 +0000
Subject: [lm-sensors] Fwd:  Fwd: Driver for Bulldozer
Message-Id: <CAMcsHH3ysybE5FRBVJu+K_4NDRXLs3gyrO9gPfuUtfX7396DZw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2608186640634292655=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH1KFnR-0kKjbQU52CWhJ-=g+=K+wP8mOGahodmYjcymjQ@mail.gmail.com>
In-Reply-To: <CAMcsHH1KFnR-0kKjbQU52CWhJ-=g+=K+wP8mOGahodmYjcymjQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2608186640634292655==
Content-Type: multipart/alternative; boundary=bcaec50408ec7bc08a04d09088ff

--bcaec50408ec7bc08a04d09088ff
Content-Type: text/plain; charset=ISO-8859-1

test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir
/lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
depmod -a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-generic
FATAL: Could not open '/lib/modules/3.2.0-23-generic/build/System.map': No
such file or directory
make: *** [modules_install] Error 1Your distribution puts the System.map
file at a different location.

I got it again with new makefile.

--bcaec50408ec7bc08a04d09088ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><div>test -d /lib/modules/3.2.0-23-generic/kerne=
l/drivers/hwmon || mkdir /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon=
<br>cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon<br>dep=
mod -a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-generic<b=
r>

FATAL: Could not open &#39;/lib/modules/3.2.0-23-generic/build/System.map&#=
39;: No such file or directory<br>make: *** [modules_install] Error 1Your d=
istribution puts the System.map file at a different location.<br></div>
<br>I got it again with new makefile.<br></div>

--bcaec50408ec7bc08a04d09088ff--


--===============2608186640634292655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2608186640634292655==--
