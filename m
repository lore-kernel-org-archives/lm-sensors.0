From: camden lindsay <camden.lindsay+lmsensors@gmail.com>
Date: Wed, 28 Nov 2012 15:55:47 +0000
Subject: Re: [lm-sensors] Fancontrol for intel HM77
Message-Id: <CABkW7JPuDQ+dakVMMkcTOqUaW_7Zm61eKNSBDX7tTSFYCzFWWQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4317359195830302123=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20121128120329.GA3502@pegasus.localdomain>
In-Reply-To: <20121128120329.GA3502@pegasus.localdomain>
To: lm-sensors@vger.kernel.org

--===============4317359195830302123==
Content-Type: multipart/alternative; boundary=0015175df1525cbfa804cf903434

--0015175df1525cbfa804cf903434
Content-Type: text/plain; charset=ISO-8859-1

Hello, Fred-
I'm by no means an expert, but it appears that the chip you have is not yet
supported by a driver in the version of lm-sensors you are running.

SuperIO chips seem to be usually the chips that support PWM outs.  Looking
at your superio section, we see this:
"Found unknown chip with ID 0x0b00"

This would imply that lm-sensors is not aware of the chip that your laptop
has.
Here is the output from my superio sensor detection:
"Found `Nuvoton W83667HG-B (NCT5571D) Super IO Sensors'      Success!
    (address 0x290, driver `w83627ehf')"

I'm not sure what tool to use to dump more information about your chip, to
help identify it.  Perhaps someone else on the list can point to a tool
like lspci that would show a list of the devices on the bus, but i don't
know of one.

lm-sensors.org seems to be down at the moment, but a google cached version
of www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/SUMMARY  says:
11 "If your sensor chip is not detected by sensors-detect, please contact us
12 (see http://www.lm-sensors.org/wiki/AuthorsAndContributors)

It goes on to say to only contact them if you're _sure_ there is a sensor
chip on your board, which i think the line from your sensors-detect output
i copied/pasted above verifies.
(see 'supported chips' cached version:
http://webcache.googleusercontent.com/search?q=cache:IFkiufprRy0J:www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/SUMMARY+&cd=5&hl=en&ct=clnk&gl=us

Hope this helps
Camden



On Wed, Nov 28, 2012 at 4:03 AM, Fred Grosskopf
<fredgrosskopf@lavabit.com>wrote:

> Hi folks,
>
> i'm desperatly trying to get some fancontrol working for my laptop
> which has an Intel HM77 chipset.
>
> I followed the http://en.gentoo-wiki.com/wiki/Lm_sensors guide.
>
> Everything "looks good" except after starting lm-sensors, pwmconfig
> says:
>
> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
>
> What is the problem, is my hardware to new? How to fix?
>
> Attached you can find my "sensors-detect" log as well all IC2 related
> kernel settings.
>
> Thanks a lot
>
> Fred
>
> --
> Germany
>
> IRC: fgro in freenode#gentoo
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

--0015175df1525cbfa804cf903434
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello, Fred-<div>I&#39;m by no means an expert, but it appears that the chi=
p you have is not yet supported by a driver in the version of lm-sensors yo=
u are running.</div><div><br></div><div>SuperIO chips seem to be usually th=
e chips that support PWM outs. =A0Looking at your superio section, we see t=
his:</div>

<div>&quot;Found unknown chip with ID 0x0b00&quot;</div><div><br></div><div=
>This would imply that lm-sensors is not aware of the chip that your laptop=
 has.</div><div>Here is the output from my superio sensor detection:</div>

<div>&quot;Found `Nuvoton W83667HG-B (NCT5571D) Super IO Sensors&#39; =A0 =
=A0 =A0Success!</div><div>=A0 =A0 (address 0x290, driver `w83627ehf&#39;)&q=
uot;</div><div><br></div><div>I&#39;m not sure what tool to use to dump mor=
e information about your chip, to help identify it. =A0Perhaps someone else=
 on the list can point to a tool like lspci that would show a list of the d=
evices on the bus, but i don&#39;t know of one.</div>

<div><br></div><div><a href=3D"http://lm-sensors.org">lm-sensors.org</a> se=
ems to be down at the moment, but a google cached version of=A0<a href=3D"h=
ttp://www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/SUMMARY">www.lm=
-sensors.org/browser/lm-sensors/trunk/doc/chips/SUMMARY</a> =A0says:</div>

<div>11 &quot;If your sensor chip is not detected by sensors-detect, please=
 contact us</div><div>12<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>(see <a href=3D"http://www.lm-sensors.org/wiki/AuthorsAndCont=
ributors">http://www.lm-sensors.org/wiki/AuthorsAndContributors</a>)</div>

<div><br></div><div>It goes on to say to only contact them if you&#39;re _s=
ure_ there is a sensor chip on your board, which i think the line from your=
 sensors-detect output i copied/pasted above verifies.</div><div>(see &#39;=
supported chips&#39; cached version:=A0<a href=3D"http://webcache.googleuse=
rcontent.com/search?q=3Dcache:IFkiufprRy0J:www.lm-sensors.org/browser/lm-se=
nsors/trunk/doc/chips/SUMMARY+&amp;cd=3D5&amp;hl=3Den&amp;ct=3Dclnk&amp;gl=
=3Dus">http://webcache.googleusercontent.com/search?q=3Dcache:IFkiufprRy0J:=
www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/SUMMARY+&amp;cd=3D5&a=
mp;hl=3Den&amp;ct=3Dclnk&amp;gl=3Dus</a></div>

<div><br></div><div>Hope this helps</div><div>Camden</div><div><br></div><d=
iv><br></div><div><br><div class=3D"gmail_quote">On Wed, Nov 28, 2012 at 4:=
03 AM, Fred Grosskopf <span dir=3D"ltr">&lt;<a href=3D"mailto:fredgrosskopf=
@lavabit.com" target=3D"_blank">fredgrosskopf@lavabit.com</a>&gt;</span> wr=
ote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi folks,<br>
<br>
i&#39;m desperatly trying to get some fancontrol working for my laptop<br>
which has an Intel HM77 chipset.<br>
<br>
I followed the <a href=3D"http://en.gentoo-wiki.com/wiki/Lm_sensors" target=
=3D"_blank">http://en.gentoo-wiki.com/wiki/Lm_sensors</a> guide.<br>
<br>
Everything &quot;looks good&quot; except after starting lm-sensors, pwmconf=
ig<br>
says:<br>
<br>
/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed<br>
<br>
What is the problem, is my hardware to new? How to fix?<br>
<br>
Attached you can find my &quot;sensors-detect&quot; log as well all IC2 rel=
ated<br>
kernel settings.<br>
<br>
Thanks a lot<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Fred<br>
<br>
--<br>
Germany<br>
<br>
IRC: fgro in freenode#gentoo<br>
</font></span><br>_______________________________________________<br>
lm-sensors mailing list<br>
<a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><=
br>
<a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=
=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>=
</blockquote></div><br></div>

--0015175df1525cbfa804cf903434--


--===============4317359195830302123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4317359195830302123==--
