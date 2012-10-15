From: Simon Tims <si@cog24.com>
Date: Mon, 15 Oct 2012 15:12:48 +0000
Subject: Re: [lm-sensors] Patching help
Message-Id: <CAPevXiuSmPj61ff8tPpkhNEXj4zUesi3tp7qH=X1zKD2t33kfA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8686889383359265663=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
In-Reply-To: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8686889383359265663==
Content-Type: multipart/alternative; boundary=f46d0438909575761c04cc1a781a

--f46d0438909575761c04cc1a781a
Content-Type: text/plain; charset=ISO-8859-1

On 11 September 2012 15:19, Jean Delvare <khali@linux-fr.org> wrote:

>  Hi Simon,
>>
>> Please don't top-post.
>>
>> On Sun, 9 Sep 2012 20:11:41 +0100, Simon Tims wrote:
>> > Yes, that does give more detail:
>> >
>> > /boot/config-3.0.0-12-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.0.0-16-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.0.0-17-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.0.0-19-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.0.0-20-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.0.0-21-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.0.0-22-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.0.0-24-generic-pae:CONFIG_I2C_PIIX4=m
>> > /boot/config-3.2.0-29-generic-pae:CONFIG_I2C_PIIX4=m
>>
>> So your kernel has the i2c-piix4 driver compiled as a module. You
>> should see it as file:
>>
>> /lib/modules/3.2.0-29-generic-pae/kernel/drivers/i2c/busses/i2c-piix4.ko
>>
>> Please confirm you have this file.
>>
>> Next step is to have a standalone replacement of that driver with
>> support for the additional SMBus channels. Thomas (Cc'd) is supposedly
>> working on this, once the code goes upstream, I will make a standalone
>> i2c-piix4 driver available for download.
>>
>> --
>> Jean Delvare
>>
>
>
> Hi Jean
>
> Yes, that file does indeed exist at the location you specify.
>
> I look forward to the standalone driver, and thank you (and everyone
>  who contributes to this project) for your assistance and guidance.
>
> Simon
>

Hi everyone

Is there any more development of the standalone i2c-piix4 driver?

Thank you

Simon

--f46d0438909575761c04cc1a781a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11 September 2012 15:19, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:khali@linux-fr.org" target=3D"_blank">khali@linux-fr.org</a>&gt;</spa=
n> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Simon,<br>
<br>
Please don&#39;t top-post.<br>
<br>
On Sun, 9 Sep 2012 20:11:41 +0100, Simon Tims wrote:<br>
&gt; Yes, that does give more detail:<br>
&gt;<br>
&gt; /boot/config-3.0.0-12-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.0.0-16-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.0.0-17-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.0.0-19-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.0.0-20-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.0.0-21-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.0.0-22-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.0.0-24-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
&gt; /boot/config-3.2.0-29-generic-pae:CONFIG_I2C_PIIX4=3Dm<br>
<br>
So your kernel has the i2c-piix4 driver compiled as a module. You<br>
should see it as file:<br>
<br>
/lib/modules/3.2.0-29-generic-pae/kernel/drivers/i2c/busses/i2c-piix4.ko<br=
>
<br>
Please confirm you have this file.<br>
<br>
Next step is to have a standalone replacement of that driver with<br>
support for the additional SMBus channels. Thomas (Cc&#39;d) is supposedly<=
br>
working on this, once the code goes upstream, I will make a standalone<br>
i2c-piix4 driver available for download.<br>
<span><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br><div><br></div><div>Hi Jean</div><div>=
<br></div><div>Yes, that file does indeed exist at the location you specify=
.</div><div><br></div><div>I look forward to the standalone driver, and tha=
nk you (and everyone</div>


<div>=A0who contributes to this project)=A0for your assistance and guidance=
.</div><span><font color=3D"#888888"><div><br></div><div>Simon</div></font>=
</span></blockquote><div><br></div><div>Hi everyone</div><div>
<br>Is there any more development of the standalone i2c-piix4 driver?<br><b=
r>Thank you=A0</div></div><br><div>Simon</div>

--f46d0438909575761c04cc1a781a--


--===============8686889383359265663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8686889383359265663==--
