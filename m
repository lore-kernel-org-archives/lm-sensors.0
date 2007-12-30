From: "Dave Bender" <codehero@gmail.com>
Date: Sun, 30 Dec 2007 22:16:23 +0000
Subject: Re: [lm-sensors] abituguru3 does not work with Abit IX38
Message-Id: <1fe498980712301416u76ea1ea1g34ede70163cb476@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6859978213044335261=="
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071229T015954-296@post.gmane.org>
In-Reply-To: <loom.20071229T015954-296@post.gmane.org>
To: lm-sensors@vger.kernel.org

--===============6859978213044335261==
Content-Type: multipart/alternative; 
	boundary="----=_Part_17030_26483299.1199052983593"

------=_Part_17030_26483299.1199052983593
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Hans,
  I have followed up on Rudolf's work and and am compiling QEMU now. There's
a of territory to cover but at least it revolves around outb statements. I
will post my results when I find somthing

Dave

On Dec 30, 2007 4:29 AM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:

> David Bender wrote:
> > Hans de Goede <j.w.r.degoede <at> hhs.nl> writes:
> >
> >> I'm afraid that the abituguru3 driver only supports reading sensors and
> >> sensors settings, the pwm part is completely unsupported, not even
> >> reading the settings is supported.
> >
> > I am willing to spend a few hours staring at assembly before I break
> down and
> > buy their guru control panel.
> >
> > Is there anyway to read the microcode on the uguru uC?
> >
> > Perhaps looking at the BIOS code may help? I am sure there must be some
> routine
> > for communicating with their uC in that code.
> >
>
> David,
>
> The current abituguru and abituguru3 drivers both have been written by me
> after
> other people ran the windows software under a debugger and stepped through
> the
> relevant code. So I guess thats one possible way to proceed, don't ask me
> for
> help there though, as said others (Louis Kruger in the case of the uguru3)
> were
> so kind todo the grunt work, I merely turned there results into a usable
> driver.
>
> I will of course be happy to extend said driver with your results,
> although you
> might want to consider doing that yourself as I don't own an uguru3
> motherboard.
>
> Thanks & Regards,
>
> Hans
>

------=_Part_17030_26483299.1199052983593
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Hans,<br>&nbsp; I have followed up on Rudolf&#39;s work and and am compiling QEMU now. There&#39;s a of territory to cover but at least it revolves around outb statements. I will post my results when I find somthing<br><br>
Dave<br><br><div class="gmail_quote">On Dec 30, 2007 4:29 AM, Hans de Goede &lt;<a href="mailto:j.w.r.degoede@hhs.nl">j.w.r.degoede@hhs.nl</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
David Bender wrote:<br><div class="Ih2E3d">&gt; Hans de Goede &lt;j.w.r.degoede &lt;at&gt; <a href="http://hhs.nl" target="_blank">hhs.nl</a>&gt; writes:<br>&gt;<br>&gt;&gt; I&#39;m afraid that the abituguru3 driver only supports reading sensors and
<br>&gt;&gt; sensors settings, the pwm part is completely unsupported, not even<br>&gt;&gt; reading the settings is supported.<br>&gt;<br></div>&gt; I am willing to spend a few hours staring at assembly before I break down and
<br>&gt; buy their guru control panel.<br>&gt;<br>&gt; Is there anyway to read the microcode on the uguru uC?<br>&gt;<br>&gt; Perhaps looking at the BIOS code may help? I am sure there must be some routine<br>&gt; for communicating with their uC in that code.
<br>&gt;<br><br>David,<br><br>The current abituguru and abituguru3 drivers both have been written by me after<br>other people ran the windows software under a debugger and stepped through the<br>relevant code. So I guess thats one possible way to proceed, don&#39;t ask me for
<br>help there though, as said others (Louis Kruger in the case of the uguru3) were<br>so kind todo the grunt work, I merely turned there results into a usable driver.<br><br>I will of course be happy to extend said driver with your results, although you
<br>might want to consider doing that yourself as I don&#39;t own an uguru3 motherboard.<br><br>Thanks &amp; Regards,<br><font color="#888888"><br>Hans<br></font></blockquote></div><br>

------=_Part_17030_26483299.1199052983593--


--===============6859978213044335261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6859978213044335261==--
