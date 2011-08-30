From: Robert Casanova <robertcasanova@nanometrics.ca>
Date: Tue, 30 Aug 2011 15:25:42 +0000
Subject: [lm-sensors] [RESEND] LM73 hwmon driver i2c auto-detection problem
Message-Id: <CAOYRzauHk1j8ThGc8Cq32Jb21LS2iqtAnyD=H=9ZpVmk3RVw-Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1043115227761117469=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1043115227761117469==
Content-Type: multipart/alternative; boundary=20cf307f35fceb895504abba9fb7

--20cf307f35fceb895504abba9fb7
Content-Type: text/plain; charset=ISO-8859-1

We are trying to use the hwmon framework to read the temperature values out
of a LM73 device we have in our i2c bus on the OMAPL-138. It's current
address is 0x49.
The actual behavior for the LM73 driver seems to be to try to autodetect if
there are any other devices of that same type on the i2c bus by looking at
the std addresses where it could find one:
0x48, 0x49, 0x4a, 0x4c, 0x4d, 0x4e

What happens is that we have a different device with completely different
registers at @0x48 so when the autodetection method gets called it tries to
read 2bytes out of the register 0x07 and this other device has only 1byte of
data at that register, then the whole bus times out.

We have tried declaring the devices we have during our board setup
statically, for instance:
static const struct i2c_board_info __initconst i2c_devices[] = {
{
 I2C_BOARD_INFO("lm73", 0x49),
},
};

static __init void board_init(void) {
...
i2c_register_board_info(1/* i2c-0 above was registered i2c_davinci.1*/,
 i2c_devices,
ARRAY_SIZE(i2c_devices));
...
}

But even when the driver gets instantiated at the proper address 0x49 the
sensors_lm73_init gets called making the detect method to get called and
testing an address that could be an LM73 but is not and hanging the bus.

Has anyone found some of the same problems? Is there any way to avoid
completely the autodetection for the hwmon framework? Should the i2c
implementation be able to handle this situation gracefully?

Cheers,

Robert

PS: The other device has a factory non-modifiable address at 0x48.

--20cf307f35fceb895504abba9fb7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">We are trying to use the hwmon framework to read=
 the temperature values out of a LM73 device we have in our i2c bus on the =
OMAPL-138. It&#39;s current address is 0x49.<div>The actual=A0behavior=A0fo=
r the LM73 driver seems to be to try to autodetect if there are any other d=
evices of that same type on the i2c bus by looking at the std addresses whe=
re it could find one:<div>

0x48, 0x49, 0x4a, 0x4c,=A00x4d, 0x4e</div><div><br></div><div>What happens =
is that we have a different device with completely different registers at @=
0x48 so when the autodetection method gets called it tries to read 2bytes o=
ut of the register 0x07 and this other device has only 1byte of data at tha=
t register, then the whole bus times out.</div>

<div><br></div><div>We have tried declaring the devices we have during our =
board setup statically, for instance:</div><div><div>static const struct i2=
c_board_info __initconst i2c_devices[] =3D {</div><div><span style=3D"white=
-space:pre-wrap">	</span>{</div>

<div><span style=3D"white-space:pre-wrap">		</span>I2C_BOARD_INFO(&quot;lm7=
3&quot;, 0x49),</div><div><span style=3D"white-space:pre-wrap">	</span>},</=
div><div>};</div></div></div><div><br></div>
<div><div>static __init void board_init(void) {</div></div><div>...</div><d=
iv><span style=3D"white-space:pre-wrap">	</span>i2c_register_board_info(1/*=
 i2c-0 above was registered i2c_davinci.1*/,</div><div>
<div><span style=3D"white-space:pre-wrap">				</span>i2c_devices,</div><div=
><span style=3D"white-space:pre-wrap">				</span>ARRAY_SIZE(i2c_devices));<=
/div>
</div><div>...</div><div>}</div><div><br></div><div>But even when the drive=
r gets instantiated at the proper address 0x49 the sensors_lm73_init gets c=
alled making the detect method to get called and testing an address that co=
uld be an LM73 but is not and hanging the bus.</div>

<div><br></div><div>Has anyone found some of the same problems? Is there an=
y way to avoid completely the autodetection for the hwmon framework? Should=
 the i2c implementation be able to handle this situation gracefully?</div>

<div><br></div><div>Cheers,</div><div><br></div><font color=3D"#888888"><di=
v>Robert</div></font><div><br></div><div>PS: The other device has a factory=
 non-modifiable address at 0x48.</div></div>

--20cf307f35fceb895504abba9fb7--


--===============1043115227761117469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1043115227761117469==--
