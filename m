From: "Wan, Huaxu" <huaxu.wan@intel.com>
Date: Tue, 18 May 2010 05:07:20 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current
Message-Id: <625BA99ED14B2D499DC4E29D8138F150181F574C31@shsmsx502.ccr.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_000_625BA99ED14B2D499DC4E29D8138F150181F574C31shsmsx502ccrc_"
List-Id: <lm-sensors.vger.kernel.org>
References: <20100517094136.094800562@osadl.org>
In-Reply-To: <20100517094136.094800562@osadl.org>
To: lm-sensors@vger.kernel.org

--===============1113717577558413995==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_625BA99ED14B2D499DC4E29D8138F150181F574C31shsmsx502ccrc_"

--_000_625BA99ED14B2D499DC4E29D8138F150181F574C31shsmsx502ccrc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

The TjMax of N270 is 90C, according the official documents [1][2].

.
[1]http://ark.intel.com/Product.aspx?id=3D36331&processor=3DN270&spec-codes=
=3DSLB73
[2]http://download.intel.com/design/processor/datashts/319977.pdf

Thanks
Huaxu

________________________________
From: Dmitry Gromov [mailto:gromovd@gmail.com]
Sent: Tuesday, May 18, 2010 12:48 PM
To: Carsten Emde
Cc: Andrew Morton; LKML; LM Sensors; Wan, Huaxu
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current Int=
el processors

Hi!

On Mon, May 17, 2010 at 05:41, Carsten Emde <C.Emde@osadl.org<mailto:C.Emde=
@osadl.org>> wrote:
Hi!

Here comes the current version of the coretemp patches. Huaxu did the initi=
al
work; Jean suggested to submit them directly to Andrew.

I made some style changes as advised by checkpatch.

The patches have been tested successfully on Core 2 Duo and Quad, and on
Nehalem and Nehalem/Westmere where temperature readings were plausible and
changed with load as expected. When tested on an Atom processor (N270), the
temperature values were identical to previous versions of the coretemp
module and also changed with load. However, the readings should be higher
by 10 to 15C as compared to the outside temperature of the processor. Huaxu=
,
could you check? I would guess TjMax to be 105 instead of 90C in these
processors.


I apologize, if I ask a stupid question, but are you saying that TjMax in c=
oretemp.c should be set to higher value than Tcase-max value specified in I=
ntel documents?

Thanks!

--
DG
NJ


--_000_625BA99ED14B2D499DC4E29D8138F150181F574C31shsmsx502ccrc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.5945" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial>Hi,</FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial>The TjMax of N270 is 90C, ac=
cording the=20
official documents [1][2].</FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT=20
face=3DArial><BR>.<BR>[1]http://ark.intel.com/Product.aspx?id=3D36331&amp;p=
rocessor=3DN270&amp;spec-codes=3DSLB73<BR>[2]http://download.intel.com/desi=
gn/processor/datashts/319977.pdf</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial>Thanks<BR>Huaxu</FONT></DIV>=
<BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #000000 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> Dmitry Gromov [mailto:gromovd@g=
mail.com]=20
  <BR><B>Sent:</B> Tuesday, May 18, 2010 12:48 PM<BR><B>To:</B> Carsten=20
  Emde<BR><B>Cc:</B> Andrew Morton; LKML; LM Sensors; Wan,=20
  Huaxu<BR><B>Subject:</B> Re: [lm-sensors] [PATCH 0/2] hwmon: Update coret=
emp=20
  to current Intel processors<BR></FONT><BR></DIV>
  <DIV></DIV><FONT color=3D#3333ff><FONT size=3D2><FONT=20
  face=3Dgeorgia,serif>Hi!<BR></FONT></FONT></FONT><BR>
  <DIV class=3Dgmail_quote>On Mon, May 17, 2010 at 05:41, Carsten Emde <SPA=
N=20
  dir=3Dltr>&lt;<A href=3D"mailto:C.Emde@osadl.org">C.Emde@osadl.org</A>&gt=
;</SPAN>=20
  wrote:<BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(2=
04,204,204) 1px solid">Hi!<BR><BR>Here=20
    comes the current version of the coretemp patches. Huaxu did the=20
    initial<BR>work; Jean suggested to submit them directly to Andrew.<BR><=
BR>I=20
    made some style changes as advised by checkpatch.<BR><BR>The patches ha=
ve=20
    been tested successfully on Core 2 Duo and Quad, and on<BR>Nehalem and=
=20
    Nehalem/Westmere where temperature readings were plausible and<BR>chang=
ed=20
    with load as expected. When tested on an Atom processor (N270),=20
    the<BR>temperature values were identical to previous versions of the=20
    coretemp<BR>module and also changed with load. However, the readings sh=
ould=20
    be higher<BR>by 10 to 15C as compared to the outside temperature of the=
=20
    processor. Huaxu,<BR>could you check? I would guess TjMax to be 105 ins=
tead=20
    of 90C in these<BR>processors.<BR><BR></BLOCKQUOTE>
  <DIV><BR>I apologize, if I ask a stupid question, but are you saying that=
=20
  TjMax in coretemp.c should be set to higher value than Tcase-max value=20
  specified in Intel documents?<BR></DIV></DIV><BR>Thanks!<BR><BR>--=20
  <BR>DG<BR>NJ<BR><BR></BLOCKQUOTE></BODY></HTML>

--_000_625BA99ED14B2D499DC4E29D8138F150181F574C31shsmsx502ccrc_--


--===============1113717577558413995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1113717577558413995==--
