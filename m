From: Martin Suchanek <martin.suc@googlemail.com>
Date: Wed, 18 Apr 2012 10:20:40 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <CAGqf2iKOfoEEFou5XzpLek3T4Ga3ZRWUs+Jx_9txniVb6gnPgQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8383379682345642584=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8383379682345642584==
Content-Type: multipart/alternative; boundary=14dae93407f94101d804bdf16837

--14dae93407f94101d804bdf16837
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 17, 2012 at 12:34 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Martin,
>
> Again, please keep the discussion list in Cc, for the interest of
> other readers and the archives.


Sorry, my bad habits within emailing with proprietary technical support -
they have always interest about vice versa.

>
> On Mon, 16 Apr 2012 18:13:38 +0100, Martin Suchanek wrote:
> > > Please list all files that match /usr/lib/libiconv.so.*, and for each
> > > of them, check which package provides it.
> > >
> > only
> > /usr/lib/libiconv.so.2 ... php-5.3-fcgi-zend-server package
>
> Hmm, OK. Very odd to have a generic library in such a specific package.
> I presume this package isn't part of Ubuntu but is a proprietary
> package from Zend?
>
> Yes , it is proprietary package from Zend


>  > Then as a test you can edit prog/sensors/Module.mk, search for the
> > > following line:
> > >
> > > LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then
> > > echo \-liconv; else echo; fi)
> > >
> > > Replace with:
> > >
> > > LIBICONV :=
> > >
> > > and try building again. Obviously this can't be a definitive fix but at
> > > least it will tell us if you really need libiconv or not.
> > >
> > compiled ok
> >
> > Is there some conflict ?
>
> Not really a conflict, rather the build system is confused because
> libiconf.so.2 is available at runtime but libiconf.so isn't available
> for build-time linking. I think we should ignore libiconv in this case,
> and hope it's not needed. Please revert the previous change and try the
> following patch instead, I'll apply it if it works for you.
>
> ---
>  prog/sensors/Module.mk |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lm-sensors.orig/prog/sensors/Module.mk      2008-03-26
> 14:37:44.000000000 +0100
> +++ lm-sensors/prog/sensors/Module.mk   2012-04-17 13:32:29.857884198 +0200
> @@ -37,7 +37,7 @@ INCLUDEFILES += $(PROGSENSORSSOURCES:.c=
>  REMOVESENSORSBIN := $(patsubst
> $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/%,$(PROGSENSORSTARGETS))
>  REMOVESENSORSMAN := $(patsubst
> $(MODULE_DIR)/%,$(DESTDIR)$(PROGSENSORSMAN1DIR)/%,$(PROGSENSORSMAN1FILES))
>
> -LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then
> echo \-liconv; else echo; fi)
> +LIBICONV := $(shell if /sbin/ldconfig -p | grep -q '/libiconv\.so$' ;
> then echo \-liconv; else echo; fi)
>
>  $(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
>        $(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.c=.ro) $(LIBICONV)
> -Llib -lsensors
>
>
> --
>
This '/libiconv\.so$' gave me error "/bin/sh: Syntax error: Unterminated
quoted string". I do not know why ?

add info - /sbin/ldconfig -p | grep 'libiconv' returned:
    libiconv_hook.so.1 (libc6,x86-64) => /usr/lib/libiconv_hook.so.1
    libiconv_hook.so (libc6,x86-64) => /usr/lib/libiconv_hook.so
    libiconv.so.2 (libc6,x86-64) => /usr/lib/libiconv.so.2


Regards,
Martin


> Jean Delvare
>

--14dae93407f94101d804bdf16837
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Apr 17, 2012 at 12:34 PM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=
=3D"_blank">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">


Hi Martin,<br>
<br>
Again, please keep the discussion list in Cc, for the interest of<br>
other readers and the archives.=C2=A0</blockquote><div><br>Sorry, my bad ha=
bits within emailing with proprietary technical support - they have always =
interest about vice versa.<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">

<div><br>
On Mon, 16 Apr 2012 18:13:38 +0100, Martin Suchanek wrote:<br>
&gt; &gt; Please list all files that match /usr/lib/libiconv.so.*, and for =
each<br>
&gt; &gt; of them, check which package provides it.<br>
&gt; &gt;<br>
&gt; only<br>
&gt; /usr/lib/libiconv.so.2 ... php-5.3-fcgi-zend-server package<br>
<br>
</div>Hmm, OK. Very odd to have a generic library in such a specific packag=
e.<br>
I presume this package isn&#39;t part of Ubuntu but is a proprietary<br>
package from Zend?<br>
<div><br></div></blockquote><div>Yes , it is proprietary package from Zend<=
br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0p=
t 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div>
&gt; Then as a test you can edit prog/sensors/Module.mk, search for the<br>
&gt; &gt; following line:<br>
&gt; &gt;<br>
&gt; &gt; LIBICONV :=3D $(shell if /sbin/ldconfig -p | grep -q libiconv\\.s=
o ; then<br>
&gt; &gt; echo \-liconv; else echo; fi)<br>
&gt; &gt;<br>
&gt; &gt; Replace with:<br>
&gt; &gt;<br>
&gt; &gt; LIBICONV :=3D<br>
&gt; &gt;<br>
&gt; &gt; and try building again. Obviously this can&#39;t be a definitive =
fix but at<br>
&gt; &gt; least it will tell us if you really need libiconv or not.<br>
&gt; &gt;<br>
&gt; compiled ok<br>
&gt;<br>
&gt; Is there some conflict ?<br>
<br>
</div>Not really a conflict, rather the build system is confused because<br=
>
libiconf.so.2 is available at runtime but libiconf.so isn&#39;t available<b=
r>
for build-time linking. I think we should ignore libiconv in this case,<br>
and hope it&#39;s not needed. Please revert the previous change and try the=
<br>
following patch instead, I&#39;ll apply it if it works for you.<br>
<br>
---<br>
=C2=A0prog/sensors/Module.mk | =C2=A0 =C2=A02 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
--- lm-sensors.orig/prog/sensors/Module.mk =C2=A0 =C2=A0 =C2=A02008-03-26 1=
4:37:44.000000000 +0100<br>
+++ lm-sensors/prog/sensors/Module.mk =C2=A0 2012-04-17 13:32:29.857884198 =
+0200<br>
@@ -37,7 +37,7 @@ INCLUDEFILES +=3D $(PROGSENSORSSOURCES:.c=3D<br>
=C2=A0REMOVESENSORSBIN :=3D $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/=
%,$(PROGSENSORSTARGETS))<br>
=C2=A0REMOVESENSORSMAN :=3D $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(PROGSENS=
ORSMAN1DIR)/%,$(PROGSENSORSMAN1FILES))<br>
<br>
-LIBICONV :=3D $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then =
echo \-liconv; else echo; fi)<br>
+LIBICONV :=3D $(shell if /sbin/ldconfig -p | grep -q &#39;/libiconv\.so$&#=
39; ; then echo \-liconv; else echo; fi)<br>
<br>
=C2=A0$(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=3D.ro) lib/$(LIBSHBASE=
NAME)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.=
c=3D.ro) $(LIBICONV) -Llib -lsensors<br>
<font color=3D"#888888"><br>
<br>
--<br></font></blockquote><div>This &#39;/libiconv\.so$&#39; gave me error =
&quot;/bin/sh: Syntax error: Unterminated quoted string&quot;. I do not kno=
w why ?<br><br>add info - /sbin/ldconfig -p | grep &#39;libiconv&#39; retur=
ned:<br>
=C2=A0=C2=A0=C2=A0 libiconv_hook.so.1 (libc6,x86-64) =3D&gt; /usr/lib/libic=
onv_hook.so.1<br>=C2=A0=C2=A0=C2=A0 libiconv_hook.so (libc6,x86-64) =3D&gt;=
 /usr/lib/libiconv_hook.so<br>=C2=A0=C2=A0=C2=A0 libiconv.so.2 (libc6,x86-6=
4) =3D&gt; /usr/lib/libiconv.so.2<br><br><br>Regards,<br>
Martin<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt=
 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><fo=
nt color=3D"#888888">
Jean Delvare<br>
</font></blockquote></div><br>

--14dae93407f94101d804bdf16837--


--===============8383379682345642584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8383379682345642584==--
