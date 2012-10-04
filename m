From: Andrew Potter <apottere@gmail.com>
Date: Thu, 04 Oct 2012 15:30:45 +0000
Subject: [lm-sensors] sensors-detect changes monitor settings on hp pavilion dv7
Message-Id: <CAAq1RJmLU+cyc59=3fnm-ZNZckk0t-qkcE=2rWNHMfj0HedKSQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5582823946895349774=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5582823946895349774==
Content-Type: multipart/alternative; boundary=bcaec54d42bc5ae8d504cb3d70df

--bcaec54d42bc5ae8d504cb3d70df
Content-Type: text/plain; charset=ISO-8859-1

Hi, I wasn't quite sure from the information on lm-sensors.org how to open
an official ticket, but the details of my problem are here:

https://bbs.archlinux.org/viewtopic.php?pid=1170583

Basically, when I probe i915 gmbus panel (i2c-2) with sensors-detect, when
it probes address 0x4f my monitor settings (I think the sharpness mostly)
are changed drastically.  This is persistent over any operating system and
reboot, leading me to believe a) its a hardware issue, or b) nothing
usually touches whatever values were changed.  Any help would be greatly
appreciated, in the forum post I've also included some experimentation with
i2c-tools.  The problem originally occured on an Arch Linux system.  Let me
know if you need anything else!

Thanks,
Andrew Potter

--bcaec54d42bc5ae8d504cb3d70df
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, I wasn&#39;t quite sure from the information on <a href=3D"http://lm-se=
nsors.org">lm-sensors.org</a> how to open an official ticket, but the detai=
ls of my problem are here:<div><br></div><div><a href=3D"https://bbs.archli=
nux.org/viewtopic.php?pid=3D1170583">https://bbs.archlinux.org/viewtopic.ph=
p?pid=3D1170583</a></div>
<div><br></div><div>Basically, when I probe=A0<span style=3D"background-col=
or:rgb(252,253,254);color:rgb(51,51,51);font-family:sans-serif;font-size:13=
px;line-height:19px">i915 gmbus panel (i2c-2) with sensors-detect, when it =
probes address 0x4f my monitor settings (I think the sharpness mostly) are =
changed drastically. =A0This is persistent over any operating system and re=
boot, leading me to believe a) its a hardware issue, or b) nothing usually =
touches whatever values were changed. =A0Any help would be greatly apprecia=
ted, in the forum post I&#39;ve also included some experimentation with i2c=
-tools. =A0The problem originally occured on an Arch Linux system. =A0Let m=
e know if you need anything else!</span></div>
<div><span style=3D"background-color:rgb(252,253,254);color:rgb(51,51,51);f=
ont-family:sans-serif;font-size:13px;line-height:19px"><br></span></div><di=
v><span style=3D"background-color:rgb(252,253,254);color:rgb(51,51,51);font=
-family:sans-serif;font-size:13px;line-height:19px">Thanks,</span></div>
<div><span style=3D"background-color:rgb(252,253,254);color:rgb(51,51,51);f=
ont-family:sans-serif;font-size:13px;line-height:19px">Andrew Potter</span>=
</div>

--bcaec54d42bc5ae8d504cb3d70df--


--===============5582823946895349774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5582823946895349774==--
