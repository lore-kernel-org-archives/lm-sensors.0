From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Thu, 05 Jul 2007 15:54:21 +0000
Subject: Re: [lm-sensors] [PATCH] Add f75375s driver
Message-Id: <738939.49740.qm@web25106.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8965628255569840611=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070628230725.GA29698@kos.to>
In-Reply-To: <20070628230725.GA29698@kos.to>
To: lm-sensors@vger.kernel.org

--===============8965628255569840611==
Content-Type: multipart/alternative; boundary="0-870312019-1183650861=:49740"
Content-Transfer-Encoding: 8bit

--0-870312019-1183650861=:49740
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

> Just to clarify, this the updated and resent patch as requested in the=20
> "kernel TODO" post.
> It is against latest 2.6.22-rc6 + Linuses git up till 29.6. I'd really=20
> appreciate if you would
> manage to review it before 2.6.23 window...

I tested the new version of the driver. Maybe i found one small bug. Should=
 it be in function 'show_in_min':=20
"return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in_min[nr]));"
instead of=20
"return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in_max[nr]));"? After chan=
ging it, i can set a min value in sensors.conf using sensors -s.

Another problem is still the value of tempX_max_hyst, the value is always z=
ero. If i read sysfs direct i get following output:
root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat temp1_max_hy=
st
0
root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat temp2_max_hy=
st
0
I'm using kernel version 2.6.17-10, is that a problem? I use the driver for=
 the f75373 chip.

best regards
christian.

      =20
---------------------------------
 Die besten Tipps und Tricks f=FCrs Grillen. BE A BETTER GRILLMEISTER!
--0-870312019-1183650861=:49740
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: courier;">Hi,</span><br style=3D"font-family: c=
ourier;"><pre style=3D"font-family: courier;">&gt; Just to clarify, this th=
e updated and resent patch as requested in the <br>&gt; "kernel TODO" post.=
<br>&gt; It is against latest 2.6.22-rc6 + Linuses git up till 29.6. I'd re=
ally <br>&gt; appreciate if you would<br>&gt; manage to review it before 2.=
6.23 window...<br></pre><span style=3D"font-family: courier;">I tested the =
new version of the driver. Maybe i found one small bug. Should it be in fun=
ction 'show_in_min': </span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">"return sprintf(buf, "%d\n", VOLT_FROM_REG(data-=
&gt;in_min[nr]));"</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">instead of </span><br style=3D"font-family: courier=
;"><span style=3D"font-family: courier;">"return sprintf(buf, "%d\n", VOLT_=
FROM_REG(data-&gt;in_max[nr]));"? After changing it, i can set a min value =
in sensors.conf using sensors
 -s.<br><br>Another problem is still the value of tempX_max_hyst, the value=
 is always zero. If i read sysfs direct i get following output:</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">root@p=
c:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat temp1_max_hyst</sp=
an><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">0</span><br style=3D"font-family: courier;"><span style=3D"font-family: c=
ourier;">root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat tem=
p2_max_hyst</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">0<br>I'm using kernel version 2.6.17-10, is that a problem=
? I use the driver for the f75373 chip.<br></span><pre style=3D"font-family=
: courier;">best regards<br>christian.</pre><p>&#32;
      <hr size=3D1>=20
Die besten Tipps und Tricks f=FCrs Grillen.=20
<a href=3D"http://de.rd.yahoo.com/evt=3D48734/*http://de.promotions.yahoo.c=
om/clever/be-a-better/grillmeister.html" target=3D_new >
<b>BE A BETTER GRILLMEISTER!</b></a>
--0-870312019-1183650861=:49740--


--===============8965628255569840611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8965628255569840611==--
