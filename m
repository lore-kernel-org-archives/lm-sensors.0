From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Mon, 02 Jan 2012 11:23:14 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <CACW_hTZGgD7TPJYHSe-O3QCxcpcDR9E_yvtrf3KRifU9wH=8Kw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4330973408564356522=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============4330973408564356522==
Content-Type: multipart/alternative; boundary=20cf30780d1af8faea04b589cee9

--20cf30780d1af8faea04b589cee9
Content-Type: text/plain; charset=ISO-8859-1

Oops:

Forgot to mention this in the commit message but this:

  static struct lm80_data *lm80_update_device(struct device *dev)
>  {
>
> [...]

>
> +       if (!data->valid)
> +       {
> +               /* last time failed: re-initialize the LM80 chip */
> +               lm80_init_client(client);
> +       }
>        if (time_after(jiffies, data->last_updated + 2 * HZ) ||
> !data->valid) {
>

was added to reinitialize the chip if the data is not valid.

This helps that if the device is disconnected temporarily it will give the
proper value again after being connected.

(this is tested with a small fan+LM80 pcb that is connected to the main
system with a connector so the fan can be serviced/replaced if needed
(which was the reason to author this patch in the first place)).

Best regards, Frans.

--20cf30780d1af8faea04b589cee9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oops:<br><br>Forgot to mention this in the commit message but this:<br><br>=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=A0
static struct lm80_data *lm80_update_device(struct device *dev)<br>
=A0{<br>
 <br></blockquote><div>[...] <br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
+ =A0 =A0 =A0 if (!data-&gt;valid)<br>
+ =A0 =A0 =A0 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* last time failed: re-initialize the LM80 c=
hip */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 lm80_init_client(client);<br>
+ =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 =A0if (time_after(jiffies, data-&gt;last_updated + 2 * HZ) || =
!data-&gt;valid) { <br></blockquote></div><br>was added to reinitialize the=
 chip if the data is not valid.<br><br>This helps that if the device is dis=
connected temporarily it will give the proper value again after being conne=
cted.<br>
<br>(this is tested with a small fan+LM80 pcb that is connected to the main=
 system with a connector so the fan can be serviced/replaced if needed (whi=
ch was the reason to author this patch in the first place)).<br><br>Best re=
gards, Frans.<br>

--20cf30780d1af8faea04b589cee9--


--===============4330973408564356522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4330973408564356522==--
