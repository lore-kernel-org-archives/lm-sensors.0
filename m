From: Davide Rizzo <elpa.rizzo@gmail.com>
Date: Mon, 17 Jan 2011 08:31:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Rewritten without using
Message-Id: <AANLkTinifVP8sD7gQ-hcVUzCGZkd7h17xV_dqxJuKzP_@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7114368708461091199=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
In-Reply-To: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7114368708461091199==
Content-Type: multipart/alternative; boundary=0050450143e7bdddb4049a069a5a

--0050450143e7bdddb4049a069a5a
Content-Type: text/plain; charset=ISO-8859-1

2010/11/18 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Davide,
>
>
> Moving include statements around is just a whitespace change and should be
> avoided.
> Also, you added a blank line at the end of the file which causes a git
> whitespace error
> when applying the patch.
>
> No need to retransmit. I fixed both and applied the patch with a couple of
> additional
> formatting changes to make the file checkpatch clean.
>
> Thanks,
> Guenter
>
>
Hi,
Any news about this ? I cannot find it in 2.6.37, did we miss the update
window or is it locked somewhere ?

-- 
All difficult problems have a simple solution. That is wrong. [A. Einstein]

--0050450143e7bdddb4049a069a5a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2010/11/18 Guenter Roeck <span dir=3D"ltr">&lt;<=
a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>=
&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0=
pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hi Davide,<br><div><div class=3D"h5">
<br>
<br>
</div></div>Moving include statements around is just a whitespace change an=
d should be avoided.<br>
Also, you added a blank line at the end of the file which causes a git whit=
espace error<br>
when applying the patch.<br>
<br>
No need to retransmit. I fixed both and applied the patch with a couple of =
additional<br>
formatting changes to make the file checkpatch clean.<br>
<br>
Thanks,<br>
<font color=3D"#888888">Guenter<br>
<br>
</font></blockquote></div><br>Hi,<br>
Any news about this ? I cannot find it in 2.6.37, did we miss the update wi=
ndow or is it locked somewhere ?<br clear=3D"all"><br>-- <br>All difficult =
problems have a simple solution. That is wrong. [A. Einstein]<br>

--0050450143e7bdddb4049a069a5a--


--===============7114368708461091199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7114368708461091199==--
