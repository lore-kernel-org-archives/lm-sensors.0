From: Alistair Strachan <alistair@devzero.co.uk>
Date: Thu, 14 Mar 2013 01:03:03 +0000
Subject: Re: [lm-sensors] [PATCH 2/9] hwmon: Fix 'Macros with complex values' checkpatch errors
Message-Id: <CABgp7kPf8wLMXi3An4vnWOtXUyhe1cxeHbw70uRms+N8afqEyg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7779538730843656358=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1363221864-15284-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1363221864-15284-3-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org

--===============7779538730843656358==
Content-Type: multipart/alternative; boundary=20cf30780cf0aa801a04d7d81529

--20cf30780cf0aa801a04d7d81529
Content-Type: text/plain; charset=UTF-8

On 13 March 2013 17:44, Guenter Roeck <linux@roeck-us.net> wrote:

> Fix:
>
> ERROR: Macros with complex values should be enclosed in parenthesis
>
> when it is seen due to complex code and not due to multi-line variable
> declarations.
>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Alistair John Strachan <alistair@devzero.co.uk>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>

LGTM.

Acked-by: Alistair John Strachan <alistair@devzero.co.uk>

-- 
Cheers,
Alistair.

--20cf30780cf0aa801a04d7d81529
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 13 March 2013 17:44, Guenter Roeck <span dir=3D"ltr">&l=
t;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.ne=
t</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
Fix:<br>
<br>
ERROR: Macros with complex values should be enclosed in parenthesis<br>
<br>
when it is seen due to complex code and not due to multi-line variable<br>
declarations.<br>
<br>
Cc: Hans de Goede &lt;<a href=3D"mailto:hdegoede@redhat.com">hdegoede@redha=
t.com</a>&gt;<br>
Cc: Alistair John Strachan &lt;<a href=3D"mailto:alistair@devzero.co.uk">al=
istair@devzero.co.uk</a>&gt;<br>
Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net">linu=
x@roeck-us.net</a>&gt;<br></blockquote><div><br>
LGTM.<br>
<br>
Acked-by: Alistair John Strachan &lt;<a href=3D"mailto:alistair@devzero.co.=
uk">alistair@devzero.co.uk</a>&gt;<br><br></div></div>-- <br>Cheers,<br>Ali=
stair.
</div></div>

--20cf30780cf0aa801a04d7d81529--


--===============7779538730843656358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7779538730843656358==--
