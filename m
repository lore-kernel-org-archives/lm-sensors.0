From: Kenneth Cox <kencox1@gmail.com>
Date: Sat, 18 Feb 2012 00:36:36 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <CAP4ecBMUiiJS6squDJYsHWSRGDZC2vZ2=p8HzsNChcUrFJeThg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2378401272239232469=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2378401272239232469==
Content-Type: multipart/alternative; boundary=e89a8fb1ef180055a004b9324107

--e89a8fb1ef180055a004b9324107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2012 at 11:35 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 16 Feb 2012 20:29:04 -0800, Kenneth Cox wrote:
> > Thanks for the response. I downloaded the new sensors-detect script and
> ran
> > it. I also installed Roeck's driver. Here is the output of
> sensors-detect:
> >
> > # sensors-detect revision 6022 (2012-02-16 07:44:31 +0100)
> > # Board: ASRock A75M-HVS
> > (...)
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >
> > Driver `w83627ehf':
> >   * ISA bus, address 0x290
> >     Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
> >
> > Driver `k10temp' (autoloaded):
> >   * Chip `AMD Family 12h and 14h thermal sensors' (confidence: 9)
> >
> > Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
> > Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
> > for initialization at boot time.
> > You should now start the lm_sensors service to load the required
> > kernel modules.
> >
> > Unloading i2c-dev... OK
> > Unloading cpuid... OK
> >
> > But sensors does not give any more info:
> >
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > temp1:         +9.6=B0C  (high =3D +70.0=B0C)
> >                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)
> >
> >
> > Am I missing something?
>
> Did you restart the lm_sensors service after that? sensors-detect only
> detects which drivers are needed, it doesn't load them for you.
>

How do you restart lm_sensors? I just rebooted and assumed that would
restart it ok.


>
> If you still don't get more values even after that, check the kernel
> log for error messages.


I don't know what I'm looking for in the kernel log. I searched the log for
"sensors" and came up with nothing. What should I be looking for?


>
> --
> Jean Delvare
>

Thanks for all your help on this.
Ken

--e89a8fb1ef180055a004b9324107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2012 at 11:35 PM, Jean Delvare <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Thu, 16 Feb 2012 20:29:04 -0800, Kenneth Cox wrote:<br=
>
&gt; Thanks for the response. I downloaded the new sensors-detect script an=
d ran<br>
&gt; it. I also installed Roeck&#39;s driver. Here is the output of sensors=
-detect:<br>
&gt;<br>
&gt; # sensors-detect revision 6022 (2012-02-16 07:44:31 +0100)<br>
&gt; # Board: ASRock A75M-HVS<br>
</div>&gt; (...)<br>
<div class=3D"im">&gt; Now follows a summary of the probes I have just done=
.<br>
&gt; Just press ENTER to continue:<br>
&gt;<br>
&gt; Driver `w83627ehf&#39;:<br>
&gt; =A0 * ISA bus, address 0x290<br>
&gt; =A0 =A0 Chip `Nuvoton NCT6776F Super IO Sensors&#39; (confidence: 9)<b=
r>
&gt;<br>
&gt; Driver `k10temp&#39; (autoloaded):<br>
&gt; =A0 * Chip `AMD Family 12h and 14h thermal sensors&#39; (confidence: 9=
)<br>
&gt;<br>
&gt; Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):<br>
&gt; Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors<br>
&gt; for initialization at boot time.<br>
&gt; You should now start the lm_sensors service to load the required<br>
&gt; kernel modules.<br>
&gt;<br>
&gt; Unloading i2c-dev... OK<br>
&gt; Unloading cpuid... OK<br>
&gt;<br>
&gt; But sensors does not give any more info:<br>
&gt;<br>
&gt; k10temp-pci-00c3<br>
&gt; Adapter: PCI adapter<br>
&gt; temp1: =A0 =A0 =A0 =A0 +9.6=B0C =A0(high =3D +70.0=B0C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +70.0=B0C, hy=
st =3D +69.0=B0C)<br>
&gt;<br>
&gt;<br>
&gt; Am I missing something?<br>
<br>
</div>Did you restart the lm_sensors service after that? sensors-detect onl=
y<br>
detects which drivers are needed, it doesn&#39;t load them for you.<br></bl=
ockquote><div><br>How do you restart lm_sensors? I just rebooted and assume=
d that would restart it ok.<br>=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">

<br>
If you still don&#39;t get more values even after that, check the kernel<br=
>
log for error messages.=A0</blockquote><div><br>I don&#39;t know what I&#39=
;m looking for in the kernel log. I searched the log for &quot;sensors&quot=
; and came up with nothing. What should I be looking for?<br>=A0<br></div>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br>Thanks for all your help on this.<br>K=
en<br>

--e89a8fb1ef180055a004b9324107--


--===============2378401272239232469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2378401272239232469==--
