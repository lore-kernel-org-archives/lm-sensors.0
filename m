From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Fri, 23 Dec 2011 14:44:35 +0000
Subject: [lm-sensors] i2c errors while updating sensors
Message-Id: <CACW_hTZsv2LQmjDYWoU715cmodvdyx2Nkem18GuN+WPvFRRbUw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3127019325689337712=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3127019325689337712==
Content-Type: multipart/alternative; boundary=20cf307abe9fa92c1a04b4c374ff

--20cf307abe9fa92c1a04b4c374ff
Content-Type: text/plain; charset=ISO-8859-1

I was peeking at lm75/lm80 i2c error message handing.

The problem I am facing is that I am using lm75 for temperature monitoring
and lm80 for temperature and fan tacho monitoring.
This is an embedded (powerpc) system using a 2.6.38 kernel, and accessing
the sensors through the sysfs interface.

The customer wants to be able to detect if someone accidently disconnects
the fan (or the monitoring chip dies).
I know i2c is not hot pluggable, but would have expected to be able to
detect this error condition

However, from peeking at the sources, it seems I am not.


lm75.c says (function lm75_update_device)
        for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
            int status;

            status = lm75_read_value(client, LM75_REG_TEMP[i]);
            if (status < 0)
                dev_dbg(&client->dev, "reg %d, err %d\n",
                        LM75_REG_TEMP[i], status);
            else
                data->temp[i] = status;
        }
        data->last_updated = jiffies;
        data->valid = 1;
So there is an error message if dbg is on, but a user will still get the
old data as temp[i] is not updated.

Wouldn't it be nice to e.g. add a (bool) attribute data-valid or or so and
drop that to 0 on a read fail (or maybe 3 subsequent read fails)?
Or is there a better way do detect such a problem in user space (e.g. by
putting an "error" value in the var)

I've also peeked at lm80.c
Here the situation seems to be a little bit worse.
E.g. I see:

static int lm80_read_value(struct i2c_client *client, u8 reg)
{
    return i2c_smbus_read_byte_data(client, reg);
}

...

        data->temp =
            (lm80_read_value(client, LM80_REG_TEMP) << 8) |
            (lm80_read_value(client, LM80_REG_RES) & 0xf0);

but i2c_smbus_read_byte_data may return a negative value upon error.
To me it seems this is not going to return a sensible value in case the
read fails (and also not e.g. something like -1)

Is this desired? Should this be fixed? Or is there a better way to do so?
If needed, I can have a stab at the code to fix it, but in that case I
would appreciate some guidance in the direction of the preferred solution
(so my work is not rejected because it was felt a faulty solution).

Best regards & seasons greetings,
Frans

--20cf307abe9fa92c1a04b4c374ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I was peeking at lm75/lm80 i2c error message handing.<br><br>The problem I =
am facing is that I am using lm75 for temperature monitoring and lm80 for t=
emperature and fan tacho monitoring.<br>This is an embedded (powerpc) syste=
m using a 2.6.38 kernel, and accessing the sensors through the sysfs interf=
ace.<br>
<br>The customer wants to be able to detect if someone accidently disconnec=
ts the fan (or the monitoring chip dies).<br>I know i2c is not hot pluggabl=
e, but would have expected to be able to detect this error condition<br>
<br>However, from peeking at the sources, it seems I am not.<br><br><br>lm7=
5.c says (function lm75_update_device)<br>=A0=A0=A0=A0=A0=A0=A0 for (i =3D =
0; i &lt; ARRAY_SIZE(data-&gt;temp); i++) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 int status;<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D lm75=
_read_value(client, LM75_REG_TEMP[i]);<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (status &lt; 0)<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(&amp;client-&gt;dev, &quot;reg %d, err =
%d\n&quot;,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 LM75_REG_TEMP[i], status);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
lse<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data-&gt;temp[i] =3D s=
tatus;<br>
=A0=A0=A0=A0=A0=A0=A0 }<br>=A0=A0=A0=A0=A0=A0=A0 data-&gt;last_updated =3D =
jiffies;<br>=A0=A0=A0=A0=A0=A0=A0 data-&gt;valid =3D 1;<br>So there is an e=
rror message if dbg is on, but a user will still get the old data as temp[i=
] is not updated.<br><br>Wouldn&#39;t it be nice to e.g. add a (bool) attri=
bute data-valid or or so and drop that to 0 on a read fail (or maybe 3 subs=
equent read fails)?<br>
Or is there a better way do detect such a problem in user space (e.g. by pu=
tting an &quot;error&quot; value in the var)<br><br>I&#39;ve also peeked at=
 lm80.c<br>Here the situation seems to be a little bit worse.<br>E.g. I see=
:<br>
<br>static int lm80_read_value(struct i2c_client *client, u8 reg)<br>{<br>=
=A0=A0=A0 return i2c_smbus_read_byte_data(client, reg);<br>}<br><br>...<br>=
<br>=A0=A0=A0=A0=A0=A0=A0 data-&gt;temp =3D<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 (lm80_read_value(client, LM80_REG_TEMP) &lt;&lt; 8) |<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (lm80_read_value(client, LM80_REG_RES) &a=
mp; 0xf0);<br><br>but i2c_smbus_read_byte_data may return a negative value =
upon error.<br>To me it seems this is not going to return a sensible value =
in case the read fails (and also not e.g. something like -1)<br>
<br>Is this desired? Should this be fixed? Or is there a better way to do s=
o?<br>If needed, I can have a stab at the code to fix it, but in that case =
I would appreciate some guidance in the direction of the preferred solution=
 (so my work is not rejected because it was felt a faulty solution).<br>
<br>Best regards &amp; seasons greetings,<br>Frans<br>

--20cf307abe9fa92c1a04b4c374ff--


--===============3127019325689337712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3127019325689337712==--
