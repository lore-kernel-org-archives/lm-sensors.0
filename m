From: Crazy Casta <crazycasta@gmail.com>
Date: Thu, 03 Nov 2011 16:53:58 +0000
Subject: Re: [lm-sensors] Fix for ASUS Rampage II GENE
Message-Id: <CABpR-zRKT0AOwZSiyMUqy1oyiySPfa+VJi8VJe_usS3ixtFoCQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8395665085610465626=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABpR-zTSu4OByNwt_4Muv3s6cS3jf2F5BhWmSPLM6AkVpLCKNg@mail.gmail.com>
In-Reply-To: <CABpR-zTSu4OByNwt_4Muv3s6cS3jf2F5BhWmSPLM6AkVpLCKNg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8395665085610465626==
Content-Type: multipart/alternative; boundary=bcaec50161514b2d1304b0d76f3f

--bcaec50161514b2d1304b0d76f3f
Content-Type: text/plain; charset=ISO-8859-1

One slight mistake. Apparently w83627ehf does work, but you need a kernel
>2.6.38 (not sure which version exactly but it works with 3.0.6).
asus_atk0110 does work with kernel 2.6.38 though.

On Wed, Nov 2, 2011 at 3:24 PM, Crazy Casta <crazycasta@gmail.com> wrote:

> To all who might come across this in the future:
>
> I have an ASUS Rampage II GENE motherboard. Contrary to other postings I
> found, the adt7475, i2c-i801 and w83627ehf modules are not sufficient to
> get anything out of this motherboard. You almost must compile the
> asus_atk0110 module (near the bottom of the compile list in the kernel).
> I'm writing this simply so it gets in the archive and google can find it in
> case anyone has a similar issue.
>
> P.S. If anyone know what the modules needed for fan control on this
> motherboard are I'd sure like to know :)
>

--bcaec50161514b2d1304b0d76f3f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

One slight mistake. Apparently w83627ehf does work, but you need a kernel &=
gt;2.6.38 (not sure which version exactly but it works with 3.0.6). asus_at=
k0110 does work with kernel 2.6.38 though.<br><br><div class=3D"gmail_quote=
">
On Wed, Nov 2, 2011 at 3:24 PM, Crazy Casta <span dir=3D"ltr">&lt;<a href=
=3D"mailto:crazycasta@gmail.com">crazycasta@gmail.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex;">
To all who might come across this in the future:<br><br>I have an ASUS Ramp=
age II GENE motherboard. Contrary to other postings I found, the adt7475, i=
2c-i801 and w83627ehf modules are not sufficient to get anything out of thi=
s motherboard. You almost must compile the asus_atk0110 module (near the bo=
ttom of the compile list in the kernel). I&#39;m writing this simply so it =
gets in the archive and google can find it in case anyone has a similar iss=
ue.<br>

<br>P.S. If anyone know what the modules needed for fan control on this mot=
herboard are I&#39;d sure like to know :)<br>
</blockquote></div><br>

--bcaec50161514b2d1304b0d76f3f--


--===============8395665085610465626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8395665085610465626==--
