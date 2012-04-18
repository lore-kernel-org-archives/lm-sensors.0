From: Martin Suchanek <martin.suc@googlemail.com>
Date: Wed, 18 Apr 2012 13:11:47 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <CAGqf2iJY=Wxu+NOM17MZyx31StZW-UmuRPvUABombm00gouCkg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3562295561591180803=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3562295561591180803==
Content-Type: multipart/alternative; boundary=14dae9340fcf35404304bdf3cc1e

--14dae9340fcf35404304bdf3cc1e
Content-Type: text/plain; charset=UTF-8

On Wed, Apr 18, 2012 at 12:22 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 18 Apr 2012 11:20:40 +0100, Martin Suchanek wrote:
> > This '/libiconv\.so$' gave me error "/bin/sh: Syntax error: Unterminated
> > quoted string". I do not know why ?
>
> My bad, I should have tested more carefully. I tested the command
> outside of "make" and it worked, but "make" interprets '$' so it needs
> special care.
>
> Updated patch follows, hopefully it will work OK this time:
>
> ---
>  prog/sensors/Module.mk |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lm-sensors.orig/prog/sensors/Module.mk      2008-03-26
> 14:37:44.000000000 +0100
> +++ lm-sensors/prog/sensors/Module.mk   2012-04-18 13:17:51.978110528 +0200
> @@ -37,7 +37,7 @@ INCLUDEFILES += $(PROGSENSORSSOURCES:.c=
>  REMOVESENSORSBIN := $(patsubst
> $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/%,$(PROGSENSORSTARGETS))
>  REMOVESENSORSMAN := $(patsubst
> $(MODULE_DIR)/%,$(DESTDIR)$(PROGSENSORSMAN1DIR)/%,$(PROGSENSORSMAN1FILES))
>
> -LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then
> echo \-liconv; else echo; fi)
> +LIBICONV := $(shell if /sbin/ldconfig -p | grep -q '/libiconv\.so$$' ;
> then echo \-liconv; else echo; fi)
>
>  $(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
>        $(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.c=.ro) $(LIBICONV)
> -Llib -lsensors
>
>
> compiled/installed succesfully.
Should I test it by some way ?

(
There is one warning within sudo make install:
******************************************************************************
Warning: Library directory /usr/local/lib is not in /etc/ld.so.conf!
         Add it and run /sbin/ldconfig for the userspace tools to work.
******************************************************************************
I have checked /etc/ld.so.conf and it contains include
/etc/ld.so.conf.d/*.conf which actually include /usr/local/bin in
/etc/ld.so.conf.d/libc.conf
)

cheers,
Martin

> --
> Jean Delvare
>

--14dae9340fcf35404304bdf3cc1e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Apr 18, 2012 at 12:22 PM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@li=
nux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Wed, 18 Apr 2012 11:20:40 +0100, Martin Suchanek wrote=
:<br>
&gt; This &#39;/libiconv\.so$&#39; gave me error &quot;/bin/sh: Syntax erro=
r: Unterminated<br>
&gt; quoted string&quot;. I do not know why ?<br>
<br>
</div>My bad, I should have tested more carefully. I tested the command<br>
outside of &quot;make&quot; and it worked, but &quot;make&quot; interprets =
&#39;$&#39; so it needs<br>
special care.<br>
<br>
Updated patch follows, hopefully it will work OK this time:<br>
<div class=3D"im"><br>
---<br>
=C2=A0prog/sensors/Module.mk | =C2=A0 =C2=A02 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
--- lm-sensors.orig/prog/sensors/Module.mk =C2=A0 =C2=A0 =C2=A02008-03-26 1=
4:37:44.000000000 +0100<br>
</div>+++ lm-sensors/prog/sensors/Module.mk =C2=A0 2012-04-18 13:17:51.9781=
10528 +0200<br>
<div class=3D"im">@@ -37,7 +37,7 @@ INCLUDEFILES +=3D $(PROGSENSORSSOURCES:=
.c=3D<br>
=C2=A0REMOVESENSORSBIN :=3D $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/=
%,$(PROGSENSORSTARGETS))<br>
=C2=A0REMOVESENSORSMAN :=3D $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(PROGSENS=
ORSMAN1DIR)/%,$(PROGSENSORSMAN1FILES))<br>
<br>
-LIBICONV :=3D $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then =
echo \-liconv; else echo; fi)<br>
</div>+LIBICONV :=3D $(shell if /sbin/ldconfig -p | grep -q &#39;/libiconv\=
.so$$&#39; ; then echo \-liconv; else echo; fi)<br>
<div><div></div><div class=3D"h5"><br>
=C2=A0$(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=3D.ro) lib/$(LIBSHBASE=
NAME)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.=
c=3D.ro) $(LIBICONV) -Llib -lsensors<br>
<br>
<br></div></div></blockquote><div>compiled/installed succesfully.<br>Should=
 I test it by some way ?<br><br>(<br>There is one warning within sudo make =
install:<br>***************************************************************=
***************<br>
Warning: Library directory /usr/local/lib is not in /etc/ld.so.conf!<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add it and run /sbin/ldconfig=
 for the userspace tools to work.<br>**************************************=
****************************************<br>
I have checked  /etc/ld.so.conf and it contains include /etc/ld.so.conf.d/*=
.conf which actually include /usr/local/bin in /etc/ld.so.conf.d/libc.conf<=
br>)<br><br>cheers,<br>Martin<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<div><div class=3D"h5">
--<br>
</div></div><font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br>

--14dae9340fcf35404304bdf3cc1e--


--===============3562295561591180803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3562295561591180803==--
