From: Simon Tims <si@cog24.com>
Date: Sun, 09 Sep 2012 19:11:41 +0000
Subject: Re: [lm-sensors] Patching help
Message-Id: <CAPevXivtQ4KAPzNio1pi_md_JNFC0YaYnjPSzq9xhr2SxOtX3g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0400002737971773417=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
In-Reply-To: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0400002737971773417==
Content-Type: multipart/alternative; boundary=047d7b66fb0579265f04c9499c8c

--047d7b66fb0579265f04c9499c8c
Content-Type: text/plain; charset=ISO-8859-1

Hi Jean

Yes, that does give more detail:

/boot/config-3.0.0-12-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.0.0-16-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.0.0-17-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.0.0-19-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.0.0-20-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.0.0-21-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.0.0-22-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.0.0-24-generic-pae:CONFIG_I2C_PIIX4=m
/boot/config-3.2.0-29-generic-pae:CONFIG_I2C_PIIX4=m

Thanks


Simon


On 6 September 2012 20:34, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 6 Sep 2012 20:23:51 +0100, Simon Tims wrote:
> > zgrep I2C_PIIX4 /proc/config.gz
> >
> > reports no such file or directory; on my server, /proc exists but
> > /config.gz isn't within it.
>
> It is only there if a specific kernel configuration option is enabled,
> which is apparently not the case on your kernel.
>
> Distributions often place a copy of the kernel configuration file
> under /boot. If you can find a kernel configuration file there, search
> for I2C_PIIX4 in it. Something like:
>
> # grep I2C_PIIX4 /boot/*config*
>
> should do.
>
> > I think it looks like the combination of the HP N40L with Ubuntu isn't
> > presently supported by LM Sensors yet, due to Debian not being
> > supported by the SMBus multiplexing driver.
>
> Correct.
>
> --
> Jean Delvare
>

--047d7b66fb0579265f04c9499c8c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jean<div><br></div><div>Yes, that does give more detail:</div><div><br><=
/div><div><div>/boot/config-3.0.0-12-generic-pae:CONFIG_I2C_PIIX4=3Dm</div>=
<div>/boot/config-3.0.0-16-generic-pae:CONFIG_I2C_PIIX4=3Dm</div><div>/boot=
/config-3.0.0-17-generic-pae:CONFIG_I2C_PIIX4=3Dm</div>
<div>/boot/config-3.0.0-19-generic-pae:CONFIG_I2C_PIIX4=3Dm</div><div>/boot=
/config-3.0.0-20-generic-pae:CONFIG_I2C_PIIX4=3Dm</div><div>/boot/config-3.=
0.0-21-generic-pae:CONFIG_I2C_PIIX4=3Dm</div><div>/boot/config-3.0.0-22-gen=
eric-pae:CONFIG_I2C_PIIX4=3Dm</div>
<div>/boot/config-3.0.0-24-generic-pae:CONFIG_I2C_PIIX4=3Dm</div><div>/boot=
/config-3.2.0-29-generic-pae:CONFIG_I2C_PIIX4=3Dm</div><div><br></div><div>=
Thanks</div><div><br></div><div><br></div><div>Simon</div>
<br><br><div class=3D"gmail_quote">On 6 September 2012 20:34, Jean Delvare =
<span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D"_blan=
k">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
On Thu, 6 Sep 2012 20:23:51 +0100, Simon Tims wrote:<br>
&gt; zgrep I2C_PIIX4 /proc/config.gz<br>
&gt;<br>
&gt; reports no such file or directory; on my server, /proc exists but<br>
&gt; /config.gz isn&#39;t within it.<br>
<br>
It is only there if a specific kernel configuration option is enabled,<br>
which is apparently not the case on your kernel.<br>
<br>
Distributions often place a copy of the kernel configuration file<br>
under /boot. If you can find a kernel configuration file there, search<br>
for I2C_PIIX4 in it. Something like:<br>
<br>
# grep I2C_PIIX4 /boot/*config*<br>
<br>
should do.<br>
<br>
&gt; I think it looks like the combination of the HP N40L with Ubuntu isn&#=
39;t<br>
&gt; presently supported by LM Sensors yet, due to Debian not being<br>
&gt; supported by the SMBus multiplexing driver.<br>
<br>
Correct.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div>

--047d7b66fb0579265f04c9499c8c--


--===============0400002737971773417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0400002737971773417==--
