From: Vahid Keykhaey <vahid.keykhaey@gmail.com>
Date: Tue, 11 Dec 2012 09:20:22 +0000
Subject: [lm-sensors] Fwd:  Driver for Bulldozer
Message-Id: <CAMcsHH0OBtynJ5BrOj9dSfooXAKUv+dZpV6+Zmj2rZcmnkeUcA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7882263475326140981=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
In-Reply-To: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7882263475326140981==
Content-Type: multipart/alternative; boundary=20cf30780ca403e75404d090314b

--20cf30780ca403e75404d090314b
Content-Type: text/plain; charset=ISO-8859-1

Dear Mr Delvare,
Hi,
Thank you for the installation instructions, but it did not work. There was
a problem. At line "make install", I got these:
root@user-desktop:~/Desktop# make install
test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir
/lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
depmod -a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-generic
FATAL: Could not open '/lib/modules/3.2.0-23-generic/build/System.map': No
such file or directory
make: *** [modules_install] Error 1


Thank you in advance for your help and support.
Regards,
Vahid Keykhaey

--20cf30780ca403e75404d090314b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Dear Mr Delvare,<br>Hi,<br>Thank you for the ins=
tallation instructions, but it did not work. There was a problem. At line &=
quot;make install&quot;, I got these:<br>root@user-desktop:~/Desktop# make =
install<br>
test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir /lib/mo=
dules/3.2.0-23-generic/kernel/drivers/hwmon<br>
cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon<br>depmod =
-a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-generic<br>FA=
TAL: Could not open &#39;/lib/modules/3.2.0-23-generic/build/System.map&#39=
;: No such file or directory<br>

make: *** [modules_install] Error 1<div class=3D"im"><br><br>Thank you in a=
dvance for your help and support.<br></div>Regards,<br>Vahid Keykhaey<br></=
div>

--20cf30780ca403e75404d090314b--


--===============7882263475326140981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7882263475326140981==--
