From: Allen Edwards <allen.p.edwards@gmail.com>
Date: Mon, 23 Nov 2009 16:06:54 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <39eba8470911230806x28ec213dtd278812cfe44cb88@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8298101386793182777=="
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8298101386793182777==
Content-Type: multipart/alternative; boundary=001517741218cf893704790c049e

--001517741218cf893704790c049e
Content-Type: text/plain; charset=ISO-8859-1

>
> > Is this acceptable?
>
> Yes it is, even though I would be a little more cautious:
>
> if [ -x /usr/local/sbin/fancontrol -a -r /etc/fancontrol ]
> then
>        /usr/local/sbin/fancontrol
> fi
>
>
OK, thanks.  You have been a huge help and my wife is very happy with the
result.  That makes me happy as well!

As I understand it, /usr/local/sbin/fancontrol will not run without being
there or having its control file there so I am thinking I am OK without the
added protection you offer and I think I will leave things there unless I am
missing something other than clean programming style.

Again, thanks so much for your help.

Allen

--001517741218cf893704790c049e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"im=
">&gt; Is this acceptable?<br>
<br>
</div><div class=3D"im">Yes it is, even though I would be a little more cau=
tious:<br>
<br>
if [ -x /usr/local/sbin/fancontrol -a -r /etc/fancontrol ]<br>
then<br>
 =A0 =A0 =A0 =A0/usr/local/sbin/fancontrol<br>
fi<br>
<br></div></blockquote><div><br></div><div>OK, thanks. =A0You have been a h=
uge help and my wife is very happy with the result. =A0That makes me happy =
as well!</div><div><br></div><div>As I understand it, /usr/local/sbin/fanco=
ntrol will not run without being there or having its control file there so =
I am thinking I am OK without the added protection you offer and I think I =
will leave things there unless I am missing something other than clean prog=
ramming style.=A0</div>

</div><br><div>Again, thanks so much for your help.</div><div><br></div><di=
v>Allen</div><div><br></div>

--001517741218cf893704790c049e--


--===============8298101386793182777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8298101386793182777==--
