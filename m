From: Justin Chudgar <justin@justinzane.com>
Date: Sun, 07 Sep 2008 04:14:50 +0000
Subject: [lm-sensors] Fwd: Re:  Fwd: Re: c7temp module for lm-sensors
Message-Id: <200809062114.51128.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_6U1wIfV/SzC7aH4"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_6U1wIfV/SzC7aH4
Content-Type: multipart/alternative; boundary="Boundary-00=_6U1wIJpYH3tklV8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_6U1wIJpYH3tklV8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here is the output from "cpuid -r":
 eax in    eax      ebx      ecx      edx
00000000 00000001 746e6543 736c7561 48727561
00000001 000006d0 00000800 00004181 a7c9bbff
80000000 80000006 00000000 00000000 00000000
80000001 00000000 00000000 00000000 00100000
80000002 20202020 20202020 20202020 20202020
80000003 20202020 41495620 2d374320 7250204d
80000004 7365636f 20726f73 30303231 007a484d
80000005 00000000 08800880 40040140 40040140
80000006 00000000 00000000 0080a140 00000000

Vendor ID: "CentaurHauls"; CPUID level 1

Unknown vendor

and here is from "cpuid":
 eax in    eax      ebx      ecx      edx
00000000 00000001 746e6543 736c7561 48727561
00000001 000006d0 00000800 00004181 a7c9bbff
80000000 80000006 00000000 00000000 00000000
80000001 00000000 00000000 00000000 00100000
80000002 20202020 20202020 20202020 20202020
80000003 20202020 41495620 2d374320 7250204d
80000004 7365636f 20726f73 30303231 007a484d
80000005 00000000 08800880 40040140 40040140
80000006 00000000 00000000 0080a140 00000000

Vendor ID: "CentaurHauls"; CPUID level 1

Unknown vendor

This is from an HP Mini-note 2133 running Kubuntu Hardy with 2.6.24; and,=20
following is the output from "sensors":
c7temp-isa-0000
Adapter: ISA adapter
in0:         +0.84 V
temp1:        +0.0=B0C

I've loaded the c7temp module; but, no temperature is shown. I can get a te=
mp=20
from ACPI, however. Please let me know how I can help you get this working.=
=20
Thanks!

Justin Chudgar
IT Consultant
5040 Saddlehorn Rd, Weed, CA 96094





--Boundary-00=_6U1wIJpYH3tklV8
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd">
<html><head><meta name=3D"qrichtext" content=3D"1" /><style type=3D"text/cs=
s">
p, li { white-space: pre-wrap; }
</style></head><body style=3D" font-family:'DejaVu Sans'; font-size:10pt; f=
ont-weight:400; font-style:normal;">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Here is the=
 output from "cpuid -r":</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'dejavu sans mono';"> eax in    eax      ebx      ecx     =
 edx</span></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">00000000 00000001 746e6543 736c7561 48727561</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">00000001 000006d0 00000800 00004181 a7c9bbff</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000000 80000006 00000000 00000000 00000000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000001 00000000 00000000 00000000 00100000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000002 20202020 20202020 20202020 20202020</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000003 20202020 41495620 2d374320 7250204d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000004 7365636f 20726f73 30303231 007a484d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000005 00000000 08800880 40040140 40040140</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000006 00000000 00000000 0080a140 00000000</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">Vendor ID: "CentaurHauls"; CPUID level 1</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">Unknown vendor</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';"><br />and here is from "cpuid":</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'dejavu sans mono';"> eax in    eax      ebx      ecx     =
 edx</span></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">00000000 00000001 746e6543 736c7561 48727561</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">00000001 000006d0 00000800 00004181 a7c9bbff</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000000 80000006 00000000 00000000 00000000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000001 00000000 00000000 00000000 00100000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000002 20202020 20202020 20202020 20202020</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000003 20202020 41495620 2d374320 7250204d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000004 7365636f 20726f73 30303231 007a484d</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000005 00000000 08800880 40040140 40040140</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">80000006 00000000 00000000 0080a140 00000000</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">Vendor ID: "CentaurHauls"; CPUID level 1</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">Unknown vendor</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">This is fro=
m an HP Mini-note 2133 running Kubuntu Hardy with 2.6.24; and, following is=
 the output from "sensors":</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'dejavu sans mono';">c7temp-isa-0000</span></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">Adapter: ISA adapter</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">in0:         +0.84 V</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">temp1:        +0.0=B0C</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0; font-family:'dejavu sans mono';"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0; font-family:=
'dejavu sans mono';">I've loaded the c7temp module; but, no temperature is =
shown. I can get a temp from ACPI, however. Please let me know how I can he=
lp you get this working. Thanks!</p>
<hr />
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-weight:600;">Justin Chudgar</span></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">IT Consulta=
nt</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">5040 Saddle=
horn Rd, Weed, CA 96094</p>
<hr />
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p><=
/body></html>
--Boundary-00=_6U1wIJpYH3tklV8--

--Boundary-00=_6U1wIfV/SzC7aH4
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: "Juerg Haefliger" <juergh@gmail.com>: Re: [lm-sensors]
	Fwd: Re: c7temp module for lm-sensors
Content-Disposition: inline

Return-Path: <juergh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	happy.justinzane.local
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_PASS shortcircuit=no
	autolearn=failed version=3.2.5
X-Original-To: justin@justinzane.com
Delivered-To: justin@justinzane.com
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by happy.justinzane.com (Postfix) with ESMTP id ABDE418019814
	for <justin@justinzane.com>; Fri,  5 Sep 2008 13:26:11 -0700 (PDT)
Received: by fg-out-1718.google.com with SMTP id e21so358149fga.6
	for <justin@justinzane.com>; Fri, 05 Sep 2008 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to
	:subject:cc:in-reply-to:mime-version:content-type
	:content-transfer-encoding:content-disposition:references;
	bh=KI1Qbkg7CsLL0PDzH6pJBBsJnXakOmFpUNt1rxITopM=;
	b=H+Kxkih+Gy5a3ezLj2w5Rm69W1GJgxw1GdYN5WxQ0Xj+1QEXubA0feUwX/NWDN7HdM
	KKAOVChrHwuFMs+hCU1K6jS5mKPePhhJeGd/9YKJOtaaB1thIgj01irv7nZLDfzGsvGb
	pld4t0rdnVB2pDUW0nS4jAZyex93fFBuxMTr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
	:content-type:content-transfer-encoding:content-disposition
	:references;
	b=lbWWiQbNxz5B2PCMRSpxdvs6WSJN8LXRcdgGa0UB1kaiet52ZJ3IJTWHHEYKdaqhQj
	6bxlqKJvX9ES4H97Cu2SnX0251o63tLNUJXSr5mB2Gg5IJRK90IR0QqvchLiKeiu29GA
	LoJBKck41vIk2OqZM+eD0gt1nT/1KPg1EQlNA=
Received: by 10.180.207.7 with SMTP id e7mr9560209bkg.18.1220646589691;
	Fri, 05 Sep 2008 13:29:49 -0700 (PDT)
Received: by 10.180.232.12 with HTTP; Fri, 5 Sep 2008 13:29:49 -0700 (PDT)
Message-ID: <191fb4ca0809051329n7c27c310o624a8d467c3e5fd7@mail.gmail.com>
Date: Fri, 5 Sep 2008 13:29:49 -0700
From: "Juerg Haefliger" <juergh@gmail.com>
To: "Justin Chudgar" <justin@justinzane.com>
Subject: Re: [lm-sensors] Fwd: Re: c7temp module for lm-sensors
Cc: lm-sensors@lm-sensors.org
In-Reply-To: <200808301703.45017.justin@justinzane.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200808301703.45017.justin@justinzane.com>
X-Length: 3764
X-UID: 69430
X-KMail-Filtered: 42273

Justin,

Can you compile and run cpuid from http://www.etallen.com/cpuid.html?
Please run it with and without the '-r' option and send the output to the list.

Thanks
...juerg


On Sat, Aug 30, 2008 at 5:03 PM, Justin Chudgar <justin@justinzane.com> wrote:
>
> --
>
> ________________________________
>
> Justin Chudgar
>
> IT Consultant
>
> 5040 Saddlehorn Rd, Weed, CA 96094
>
> ________________________________
>
> ---------- Forwarded message ----------
> From: Hans de Goede <j.w.r.degoede@hhs.nl>
> To: Justin Chudgar <justin@justinzane.com>
> Date: Sat, 30 Aug 2008 08:11:47 +0200
> Subject: Re: c7temp module for lm-sensors
> Justin Chudgar wrote:
>>
>> Dear Hans:
>>
>> I am using this module on an HP Mini-note 2133 running Kubuntu 8.04.1 w/
>> 2.6.24.19. I get a voltage reading but no temperature. I would like to help
>> determine what is not working; but, I am unable to do so without assistance.
>>
>> Could you kindly direct me to the right resources. Thanks.
>>
>> Justin Chudgar
>>
>>
>
> Dear Justin,
>
> I'm not the maintainer of the c7temp driver, please send a mail to the
> lm_sensors list.
>
> Regards,
>
> Hans
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


--Boundary-00=_6U1wIfV/SzC7aH4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_6U1wIfV/SzC7aH4--
