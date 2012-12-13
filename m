From: David Hubbard <david.c.hubbard@gmail.com>
Date: Thu, 13 Dec 2012 22:40:22 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <CAC-0EqiDVUDQTBX0VWsdRU9+K+eUs1tuH1CFDJNKGwvyyo2j4Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5748585274577042010=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5748585274577042010==
Content-Type: multipart/alternative; boundary=0016e6d27188abbcea04d0c3997d

--0016e6d27188abbcea04d0c3997d
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter,

On Thu, Dec 13, 2012 at 3:13 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Dec 13, 2012 at 02:27:57PM -0700, David Hubbard wrote:
> > Hi Guenter,
> >
> > On Thu, Dec 13, 2012 at 9:07 AM, Guenter Roeck <groeck-dsl@sbcglobal.net
> >wrote:
> >
> > > On Thu, Dec 13, 2012 at 01:00:30AM -0700, David Hubbard wrote:
> > > > I'd like to send the same patch again but add signed-off-by this
> time :)
> > > I
> > > > apologize.
> > > >
> > > > * * * * *
> > > >
> > > > Add experimental support for the it8603e chip (Asus f2a85-m
> motherboard)
> > > > Write only tested for pwmN and pwmN_enable.
> > > > Read tested, but the following appear broken:
> > > >   alarms
> > > >   fanN_alarm
> > > >   inN_alarm
> > > >   inN_max
> > > >   inN_min
> > > >   intrusionN_alarm
> > > >   pwmN_auto_channels_temp
> > > >   pwmN_freq
> > >
> > > I don't think it is a good idea to report attributes which "appear to
> be
> > > broken". At least for the voltage limits and the alarms it should be
> > > relatively
> > > easy to find out if they work/don't work. Whatever doesn't work should
> not
> > > be
> > > there.
> > >
> >
> > They don't work but I don't know why. Until we have a datasheet, I'd like
> > to leave them in the *experimental* driver and wait for a second opinion
> > from someone who actually has the chip.
> >
> >
> > >
> > > >   temp3_input (there is no 3rd analog temp input to the chip)
> > > >
> > > Other IT87xx chips report the AMDSTI/PCH temperature as one of the
> inputs.
> > > This
> > > is usually configurable.
> > >
> > >
> > Ok, fine with me.
> >
> > Another question is to what extend we can depend on the logic in
> > > it87_find() to
> > > detect enabled chip features. It might make more sense to create
> another
> > > if case
> > > in that function to handle the IT8603 separately.
> > >
> >
> > it87_find() seems to have identified the correct features of the IT8603.
> I
> > don't understand your concern with the way it is currently working.
> >
> "they don't work ... " and "identified the correct features" seems to
> somewhat contradict each other.
>
>
Oh, okay. That's easy. "They don't work," but "it87_find() seems to have
identified the correct features" -- the features exist, independently
confirmed by the OEM Asus BIOS. So it87_find() reports data consistent with
the Asus BIOS. I'd like to leave them in the experimental driver because I
think it87_find() is operating correctly.

All that needs to be done to get them to work is a datasheet or equivalent
technical description of the I/O interface. I don't think Asus is going to
provide one, but another motherboard with the same chip could be extremely
useful for A/B testing.

Thanks,
David

--0016e6d27188abbcea04d0c3997d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guenter,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Thu, Dec 13, 2012 at 3:13 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=
=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, Dec 13, 2012 at 02:27:57PM -0700, David Hubbard wrote:<br>
&gt; Hi Guenter,<br>
&gt;<br>
&gt; On Thu, Dec 13, 2012 at 9:07 AM, Guenter Roeck &lt;<a href=3D"mailto:g=
roeck-dsl@sbcglobal.net">groeck-dsl@sbcglobal.net</a>&gt;wrote:<br>
&gt;<br>
&gt; &gt; On Thu, Dec 13, 2012 at 01:00:30AM -0700, David Hubbard wrote:<br=
>
&gt; &gt; &gt; I&#39;d like to send the same patch again but add signed-off=
-by this time :)<br>
&gt; &gt; I<br>
&gt; &gt; &gt; apologize.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; * * * * *<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Add experimental support for the it8603e chip (Asus f2a85-m =
motherboard)<br>
&gt; &gt; &gt; Write only tested for pwmN and pwmN_enable.<br>
&gt; &gt; &gt; Read tested, but the following appear broken:<br>
&gt; &gt; &gt; =A0 alarms<br>
&gt; &gt; &gt; =A0 fanN_alarm<br>
&gt; &gt; &gt; =A0 inN_alarm<br>
&gt; &gt; &gt; =A0 inN_max<br>
&gt; &gt; &gt; =A0 inN_min<br>
&gt; &gt; &gt; =A0 intrusionN_alarm<br>
&gt; &gt; &gt; =A0 pwmN_auto_channels_temp<br>
&gt; &gt; &gt; =A0 pwmN_freq<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t think it is a good idea to report attributes which &q=
uot;appear to be<br>
&gt; &gt; broken&quot;. At least for the voltage limits and the alarms it s=
hould be<br>
&gt; &gt; relatively<br>
&gt; &gt; easy to find out if they work/don&#39;t work. Whatever doesn&#39;=
t work should not<br>
&gt; &gt; be<br>
&gt; &gt; there.<br>
&gt; &gt;<br>
&gt;<br>
&gt; They don&#39;t work but I don&#39;t know why. Until we have a datashee=
t, I&#39;d like<br>
&gt; to leave them in the *experimental* driver and wait for a second opini=
on<br>
&gt; from someone who actually has the chip.<br>
&gt;<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; =A0 temp3_input (there is no 3rd analog temp input to the ch=
ip)<br>
&gt; &gt; &gt;<br>
&gt; &gt; Other IT87xx chips report the AMDSTI/PCH temperature as one of th=
e inputs.<br>
&gt; &gt; This<br>
&gt; &gt; is usually configurable.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Ok, fine with me.<br>
&gt;<br>
&gt; Another question is to what extend we can depend on the logic in<br>
&gt; &gt; it87_find() to<br>
&gt; &gt; detect enabled chip features. It might make more sense to create =
another<br>
&gt; &gt; if case<br>
&gt; &gt; in that function to handle the IT8603 separately.<br>
&gt; &gt;<br>
&gt;<br>
&gt; it87_find() seems to have identified the correct features of the IT860=
3. I<br>
&gt; don&#39;t understand your concern with the way it is currently working=
.<br>
&gt;<br>
</div></div>&quot;they don&#39;t work ... &quot; and &quot;identified the c=
orrect features&quot; seems to<br>
somewhat contradict each other.<br>
<span class=3D"HOEnZb"></span><br></blockquote><div><br>Oh, okay. That&#39;=
s easy. &quot;They don&#39;t work,&quot; but &quot;it87_find() seems to hav=
e identified the correct features&quot; -- the features exist, independentl=
y confirmed by the OEM Asus BIOS. So it87_find() reports data consistent wi=
th the Asus BIOS. I&#39;d like to leave them in the experimental driver bec=
ause I think it87_find() is operating correctly.<br>
<br>All that needs to be done to get them to work is a datasheet or equival=
ent technical description of the I/O interface. I don&#39;t think Asus is g=
oing to provide one, but another motherboard with the same chip could be ex=
tremely useful for A/B testing.<br>
<br>Thanks,<br>David <br></div></div></div>

--0016e6d27188abbcea04d0c3997d--


--===============5748585274577042010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5748585274577042010==--
