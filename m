From: CCMaynard@aol.com
Date: Sun, 08 Apr 2007 13:41:05 +0000
Subject: [lm-sensors] Ticket 1833 Jean Delvare
Message-Id: <c11.11d1c026.334a8331@aol.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1854376572032817671=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============1854376572032817671==
Content-Type: multipart/alternative;
	boundary="part1_c11.11d1c026.334a8331_boundary"


--part1_c11.11d1c026.334a8331_boundary
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

In 2004 you (Jean Delvare) wrote an e-mail that I picked up on a google 
scan.. The short story is that I'm looking for an "HF T/R chip" (3-30 MHz) to 
integrate in to a project I'm working on for a communications project.. Who has an 
HF chip?  Regards, Charlie

Jean Delvare khali at linux-fr.org 
Mon Dec 6 20:23:34 CET 2004 
Previous message: Ticket 1833 
Next message: Ticket 1833 
Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] Hi Steven,

(Many, many thanks to the FNAL for nedit! I simply couldn't live without
it. You might not have suspected it so far but you have actually been
sponsoring the lm_sensors project for a while ;))

> According to winbond web site there are a couple of new chips 
> they recently released:
> 
> http://www.winbond.com.tw/E-WINBONDHTM/team/news.asp#03
> 
> Either W83627EHF or W83792D.  
> Any chance the chip is one of them?

The W83627EHF is most probably a variant of the W83627HF or THF, so it
would be a Super-I/O chip. Since you already have an HF chip it wouldn't
make much sense. Unless of course the HF is a misdetection and is
actually an EHF. Without a datasheet we cannot say.

We could probably take a guess if you would provide dumps for all three
chips:
isadump 0x295 0x296 (assuming that the Super-I/O chip is at 0x290)
i2cdump 0 0x2c
i2cdump 0 0x2f

One of the I2C chips is obviously an "alias" of the Super-I/O chip, this
should help find out which actually is.

The W83792D sounds much more credible to me. Again without a datasheet
we cannot confirm. However, Winbond themselves are working on a driver,
and said they would release a datasheet soon. Let's just wait until they
are done.

Stay tuned! :)

-- 
Jean Delvare
http://khali.linux-fr.org/




**************************************
 See what's free at http://www.aol.com.

--part1_c11.11d1c026.334a8331_boundary
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<HTML><FONT FACE=3Darial,helvetica><HTML><FONT  SIZE=3D2 PTSIZE=3D10 FAMILY=
=3D"SANSSERIF" FACE=3D"Arial" LANG=3D"0">In 2004 you (Jean Delvare) wrote an=
 e-mail that I picked up on a google scan.. The short story is that I'm look=
ing for an "HF T/R chip" (3-30 MHz) to integrate in to a project I'm working=
 on for a communications project.. Who has an HF chip?&nbsp; Regards, Charli=
e<BR>
<BR>
<B>Jean Delvare</B> <A HREF=3D"mailto:lm-sensors%40lm-sensors.org%3FSubject=
=3DTicket%201833%26In-Reply-To=3DPine.LNX.4.58.0412061148550.25485%40boxer.f=
nal.gov">khali at linux-fr.org </A><BR>
<I>Mon Dec 6 20:23:34 CET 2004</I> <BR>
Previous message: <A HREF=3D"http://lists.lm-sensors.org/pipermail/lm-sensor=
s/2004-December/009660.html">Ticket 1833 </A><BR>
Next message: <A HREF=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/20=
04-December/009663.html">Ticket 1833 </A><BR>
<B>Messages sorted by:</B> <A HREF=3D"http://lists.lm-sensors.org/pipermail/=
lm-sensors/2004-December/date.html#9662">[ date ]</A> <A HREF=3D"http://list=
s.lm-sensors.org/pipermail/lm-sensors/2004-December/thread.html#9662">[ thre=
ad ]</A> <A HREF=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/2004-De=
cember/subject.html#9662">[ subject ]</A> <A HREF=3D"http://lists.lm-sensors=
.org/pipermail/lm-sensors/2004-December/author.html#9662">[ author ]</A> Hi=20=
Steven,<BR>
<BR>
(Many, many thanks to the FNAL for nedit! I simply couldn't live without<BR>
it. You might not have suspected it so far but you have actually been<BR>
sponsoring the lm_sensors project for a while ;))<BR>
<BR>
&gt;<I> According to winbond web site there are a couple of new chips <BR>
</I>&gt;<I> they recently released:<BR>
</I>&gt;<I> <BR>
</I>&gt;<I> <A HREF=3D"http://www.winbond.com.tw/E-WINBONDHTM/team/news.asp#=
03">http://www.winbond.com.tw/E-WINBONDHTM/team/news.asp#03</A><BR>
</I>&gt;<I> <BR>
</I>&gt;<I> Either W83627EHF or W83792D.&nbsp; <BR>
</I>&gt;<I> Any chance the chip is one of them?<BR>
</I><BR>
The W83627EHF is most probably a variant of the W83627HF or THF, so it<BR>
would be a Super-I/O chip. Since you already have an<B> HF chip </B>it would=
n't<BR>
make much sense. Unless of course the HF is a misdetection and is<BR>
actually an EHF. Without a datasheet we cannot say.<BR>
<BR>
We could probably take a guess if you would provide dumps for all three<BR>
chips:<BR>
isadump 0x295 0x296 (assuming that the Super-I/O chip is at 0x290)<BR>
i2cdump 0 0x2c<BR>
i2cdump 0 0x2f<BR>
<BR>
One of the I2C chips is obviously an "alias" of the Super-I/O chip, this<BR>
should help find out which actually is.<BR>
<BR>
The W83792D sounds much more credible to me. Again without a datasheet<BR>
we cannot confirm. However, Winbond themselves are working on a driver,<BR>
and said they would release a datasheet soon. Let's just wait until they<BR>
are done.<BR>
<BR>
Stay tuned! :)<BR>
<BR>
-- <BR>
Jean Delvare<BR>
<A HREF=3D"http://khali.linux-fr.org/">http://khali.linux-fr.org/</A><BR>
<BR>
</FONT><BR><BR><BR>**************************************<BR> See what's fre=
e at http://www.aol.com.</HTML>

--part1_c11.11d1c026.334a8331_boundary--


--===============1854376572032817671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1854376572032817671==--
