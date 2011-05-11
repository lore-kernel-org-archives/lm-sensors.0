From: Steve.Glendinning@smsc.com
Date: Wed, 11 May 2011 18:53:59 +0000
Subject: Re: [lm-sensors] [PATCH] Document existing support for SMSC EMC2300
Message-Id: <OF0D100F13.1B9EE948-ONC125788D.0067D1E0-C125788D.0067D1E3@smsc.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2152312653383462213=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
To: lm-sensors@vger.kernel.org

--===============2152312653383462213==
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><DIV><DIV>Hi all,</DIV><DIV>&nbsp;</DIV><DIV>&gt;Datasheet says that 0=
x20, 0x23, 0x24, 0x43..0x45, and 0x4a..0x4d are<BR>&gt;all <BR>&gt;zero on =
the EMC2300. Most interesting would be 0x45, 0x4b, and 0x4d, <BR>&gt;which =
are initialized with 0x00 on the EMC2300 but 0xff for the <BR>&gt;EMC6D103S=
. <BR></DIV><DIV>The datasheet lies :-)</DIV><DIV>&nbsp;</DIV><DIV>They ret=
urn the same as the EMC6D103S, i.e. 0xff for 0x45, 0x4b, and 0x4d.</DIV><DI=
V>&nbsp;</DIV><DIV>&gt;&gt;&nbsp;&gt;&nbsp;EMC2300&nbsp;doesn't&nbsp;have&n=
bsp;all&nbsp;the&nbsp;voltage&nbsp;inputs&nbsp;that&nbsp;EMC6D103S&nbsp;has=
, <BR>&gt;&gt;&nbsp;&gt;&nbsp;so&nbsp;reports&nbsp;in0,&nbsp;in3&nbsp;and&n=
bsp;in4&nbsp;all&nbsp;as&nbsp;zero. <BR>&gt;&gt;&nbsp; <BR>&gt;&gt;&nbsp;Wo=
uldn't&nbsp;this&nbsp;be&nbsp;good&nbsp;way&nbsp;to&nbsp;differentiate&nbsp=
;between&nbsp;the&nbsp;parts?&nbsp;What <BR>&gt;&gt;&nbsp;values&nbsp;are&n=
bsp;returned&nbsp;by&nbsp;the&nbsp;EMC2300&nbsp;for&nbsp;registers&nbsp;0x2=
0,&nbsp;0x23,&nbsp;0x24, <BR>&gt;&gt;&nbsp;0x44,&nbsp;0x45,&nbsp;0x4a,&nbsp=
;0x4b&nbsp;0x4c&nbsp;and&nbsp;0x4d? <BR></DIV><DIV>I thought of this, yes t=
he missing&nbsp;voltage inputs all always return 0.&nbsp; I don't have an E=
MC6D103S handy though, so I'm not able to check its behaviour if those pins=
 are either not connected or connected to ground.&nbsp; Presumably it could=
 also return 0 in some cases so the detection would not be 100% foolproof?<=
/DIV><DIV>&nbsp;</DIV><DIV>I figured the safe option was to leave the extra=
 inputs visible, as I didn't want to risk blocking access to them on parts =
where they're present.</DIV><DIV><BR>&gt;&gt;&nbsp;BTW,&nbsp;if&nbsp;you&nb=
sp;could&nbsp;provide&nbsp;a&nbsp;register&nbsp;dump&nbsp;for&nbsp;the&nbsp=
;EMC2300&nbsp;(using<BR>&gt;the <BR>&gt;&gt;&nbsp;i2c-dev&nbsp;kernel&nbsp;=
driver&nbsp;and&nbsp;i2cdump&nbsp;tool&nbsp;from&nbsp;the&nbsp;i2c-tools&nb=
sp;package)<BR>&gt;that <BR>&gt;&gt;&nbsp;would&nbsp;be&nbsp;appreciated. <=
/DIV><DIV>&nbsp;</DIV><DIV>I'll see if I can get this dump for you tomorrow=
.</DIV><DIV>&nbsp;</DIV><DIV>Steve</DIV><DIV>&nbsp;</DIV></DIV></FONT>=


--===============2152312653383462213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2152312653383462213==--
