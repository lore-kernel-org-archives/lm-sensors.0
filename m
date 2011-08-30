From: Robert Casanova <robertcasanova@nanometrics.ca>
Date: Tue, 30 Aug 2011 18:20:58 +0000
Subject: Re: [lm-sensors] [RESEND] LM73 hwmon driver i2c auto-detection
Message-Id: <CAOYRzavnOZ1fV5CH-eb=b-Ne7nvfViO7+EjzcKe+RiUzT7zGqw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8850580465808920979=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOYRzauHk1j8ThGc8Cq32Jb21LS2iqtAnyD=H=9ZpVmk3RVw-Q@mail.gmail.com>
In-Reply-To: <CAOYRzauHk1j8ThGc8Cq32Jb21LS2iqtAnyD=H=9ZpVmk3RVw-Q@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8850580465808920979==
Content-Type: multipart/alternative; boundary=90e6ba21232bbd9f7904abbd12d5

--90e6ba21232bbd9f7904abbd12d5
Content-Type: text/plain; charset=ISO-8859-1

Actually that was one of my options but I couldn't find some i2c-dummy
driver or something similar, but now that you pointed out I've found a
compatible driver for that device and as Guenter said it does reserve the
address not being available to the i2c subsystem for auto-detection.

If there was no compatible driver (or not yet) for a device in my same
situation is there some sort of a generic driver to fill it up?

Thanks

On 30 August 2011 13:05, Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> On Tue, Aug 30, 2011 at 11:25:42AM -0400, Robert Casanova wrote:
> > We are trying to use the hwmon framework to read the temperature values
> out of
> > a LM73 device we have in our i2c bus on the OMAPL-138. It's current
> address is
> > 0x49.
> > The actual behavior for the LM73 driver seems to be to try to autodetect
> if
> > there are any other devices of that same type on the i2c bus by looking
> at the
> > std addresses where it could find one:
> > 0x48, 0x49, 0x4a, 0x4c, 0x4d, 0x4e
> >
> > What happens is that we have a different device with completely different
> > registers at @0x48 so when the autodetection method gets called it tries
> to
> > read 2bytes out of the register 0x07 and this other device has only 1byte
> of
> > data at that register, then the whole bus times out.
> >
> > We have tried declaring the devices we have during our board setup
> statically,
> > for instance:
> > static const struct i2c_board_info __initconst i2c_devices[] = {
> > {
> > I2C_BOARD_INFO("lm73", 0x49),
> > },
> > };
> >
> > static __init void board_init(void) {
> > ...
> > i2c_register_board_info(1/* i2c-0 above was registered i2c_davinci.1*/,
> > i2c_devices,
> > ARRAY_SIZE(i2c_devices));
> > ...
> > }
> >
> > But even when the driver gets instantiated at the proper address 0x49 the
> > sensors_lm73_init gets called making the detect method to get called and
> > testing an address that could be an LM73 but is not and hanging the bus.
> >
> > Has anyone found some of the same problems? Is there any way to avoid
> > completely the autodetection for the hwmon framework? Should the i2c
> > implementation be able to handle this situation gracefully?
> >
> Did you try to instantiate the _other_ device ? That should take care of
> the problem.
>
> Instantiating the LM73 at address 0x49 won't help, since the i2c core code
> will still
> attempt to auto-detect the chip at address 0x48.
>
> Guenter
>
>

--90e6ba21232bbd9f7904abbd12d5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Actually that was one of my options but I couldn&#39;t find some i2c-dummy =
driver or something similar, but now that you pointed out I&#39;ve found a =
compatible driver for that device and as=A0<meta http-equiv=3D"content-type=
" content=3D"text/html; charset=3Dutf-8">Guenter=A0said it does reserve the=
 address not being available to the i2c subsystem for auto-detection.<div>
<br></div><div>If there was no compatible driver (or not yet) for a device =
in my same situation is there some sort of a generic driver to fill it up?<=
/div><div><br></div><div>Thanks<br><br><div class=3D"gmail_quote">On 30 Aug=
ust 2011 13:05, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:guent=
er.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Tue, A=
ug 30, 2011 at 11:25:42AM -0400, Robert Casanova wrote:<br>
&gt; We are trying to use the hwmon framework to read the temperature value=
s out of<br>
&gt; a LM73 device we have in our i2c bus on the OMAPL-138. It&#39;s curren=
t address is<br>
&gt; 0x49.<br>
&gt; The actual behavior for the LM73 driver seems to be to try to autodete=
ct if<br>
&gt; there are any other devices of that same type on the i2c bus by lookin=
g at the<br>
&gt; std addresses where it could find one:<br>
&gt; 0x48, 0x49, 0x4a, 0x4c, 0x4d, 0x4e<br>
&gt;<br>
&gt; What happens is that we have a different device with completely differ=
ent<br>
&gt; registers at @0x48 so when the autodetection method gets called it tri=
es to<br>
&gt; read 2bytes out of the register 0x07 and this other device has only 1b=
yte of<br>
&gt; data at that register, then the whole bus times out.<br>
&gt;<br>
&gt; We have tried declaring the devices we have during our board setup sta=
tically,<br>
&gt; for instance:<br>
&gt; static const struct i2c_board_info __initconst i2c_devices[] =3D {<br>
&gt; {<br>
&gt; I2C_BOARD_INFO(&quot;lm73&quot;, 0x49),<br>
&gt; },<br>
&gt; };<br>
&gt;<br>
&gt; static __init void board_init(void) {<br>
&gt; ...<br>
&gt; i2c_register_board_info(1/* i2c-0 above was registered i2c_davinci.1*/=
,<br>
&gt; i2c_devices,<br>
&gt; ARRAY_SIZE(i2c_devices));<br>
&gt; ...<br>
&gt; }<br>
&gt;<br>
&gt; But even when the driver gets instantiated at the proper address 0x49 =
the<br>
&gt; sensors_lm73_init gets called making the detect method to get called a=
nd<br>
&gt; testing an address that could be an LM73 but is not and hanging the bu=
s.<br>
&gt;<br>
&gt; Has anyone found some of the same problems? Is there any way to avoid<=
br>
&gt; completely the autodetection for the hwmon framework? Should the i2c<b=
r>
&gt; implementation be able to handle this situation gracefully?<br>
&gt;<br>
</div></div>Did you try to instantiate the _other_ device ? That should tak=
e care of the problem.<br>
<br>
Instantiating the LM73 at address 0x49 won&#39;t help, since the i2c core c=
ode will still<br>
attempt to auto-detect the chip at address 0x48.<br>
<font color=3D"#888888"><br>
Guenter<br>
<br>
</font></blockquote></div><br></div>

--90e6ba21232bbd9f7904abbd12d5--


--===============8850580465808920979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8850580465808920979==--
