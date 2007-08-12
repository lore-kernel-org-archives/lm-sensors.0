From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Sun, 12 Aug 2007 11:24:02 +0000
Subject: Re: [lm-sensors] lm_sensors on CentOS 4.5
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C832117@orca.penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7DCD3.48DE76D3"
List-Id: <lm-sensors.vger.kernel.org>
References: <46BE20BD.6040906@gmail.com>
In-Reply-To: <46BE20BD.6040906@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============1345394329793816462==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7DCD3.48DE76D3"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7DCD3.48DE76D3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If you have an IPMI BMC you may find the IPMI tools easier to use =
directly.  You will need OpenIPMI-utils rpm installed.

# service ipmi start
# ipmitool sdr elist

Ipmitool comes with good built in help text.

:v)

--=20
Philip Pokorny, RHCE
Director of Field Engineering=20
Penguin Computing  http://www.penguincomputing.com

 -----Original Message-----
From: 	Martin Minka [mailto:martin.minka@gmail.com]
Sent:	Sunday, August 12, 2007 04:11 AM Pacific Standard Time
To:	Juerg Haefliger
Cc:	lm-sensors@lm-sensors.org
Subject:	Re: [lm-sensors] lm_sensors on CentOS 4.5

Juerg,
thank you for the tip, but to install bmcsensors on CentOS is too much=20
for my skills.

Could you give me one more hint ?

Sincerely,
Martin

Juerg Haefliger wrote:
> Hi Martin,
>
>
>  =20
>> hello,
>> I have problem to install lm_sensors on CentOS 4.5 (Linux =
2.6.9-42.ELsmp).
>> I am getting error message "FATAL: Module bmcsensors not found." =
after I
>> enter "modprobe bmcsensors".
>>    =20
>
> The bmcsensors module is not part of the kernel.
>
>
>  =20
>> Could somebody help me out with this ?
>>    =20
>
> Google is your friend. Try http://bmcsensors-26.sourceforge.net/.
>
> ...juerg
>
>
>  =20
>> Sincerely,
>> Martin Minka
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>>    =20
>
>  =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

------_=_NextPart_001_01C7DCD3.48DE76D3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<TITLE>Re: [lm-sensors] lm_sensors on CentOS 4.5</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>If you have an IPMI BMC you may find the IPMI tools =
easier to use directly.&nbsp; You will need OpenIPMI-utils rpm =
installed.<BR>
<BR>
# service ipmi start<BR>
# ipmitool sdr elist<BR>
<BR>
Ipmitool comes with good built in help text.<BR>
<BR>
:v)<BR>
<BR>
--<BR>
Philip Pokorny, RHCE<BR>
Director of Field Engineering<BR>
Penguin Computing&nbsp; <A =
HREF=3D"http://www.penguincomputing.com">http://www.penguincomputing.com<=
/A><BR>
<BR>
&nbsp;-----Original Message-----<BR>
From: &nbsp; Martin Minka [<A =
HREF=3D"mailto:martin.minka@gmail.com">mailto:martin.minka@gmail.com</A>]=
<BR>
Sent:&nbsp;&nbsp; Sunday, August 12, 2007 04:11 AM Pacific Standard =
Time<BR>
To:&nbsp;&nbsp;&nbsp;&nbsp; Juerg Haefliger<BR>
Cc:&nbsp;&nbsp;&nbsp;&nbsp; lm-sensors@lm-sensors.org<BR>
Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Re: [lm-sensors] =
lm_sensors on CentOS 4.5<BR>
<BR>
Juerg,<BR>
thank you for the tip, but to install bmcsensors on CentOS is too =
much<BR>
for my skills.<BR>
<BR>
Could you give me one more hint ?<BR>
<BR>
Sincerely,<BR>
Martin<BR>
<BR>
Juerg Haefliger wrote:<BR>
&gt; Hi Martin,<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;<BR>
&gt;&gt; hello,<BR>
&gt;&gt; I have problem to install lm_sensors on CentOS 4.5 (Linux =
2.6.9-42.ELsmp).<BR>
&gt;&gt; I am getting error message &quot;FATAL: Module bmcsensors not =
found.&quot; after I<BR>
&gt;&gt; enter &quot;modprobe bmcsensors&quot;.<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;<BR>
&gt; The bmcsensors module is not part of the kernel.<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;<BR>
&gt;&gt; Could somebody help me out with this ?<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;<BR>
&gt; Google is your friend. Try <A =
HREF=3D"http://bmcsensors-26.sourceforge.net/">http://bmcsensors-26.sourc=
eforge.net/</A>.<BR>
&gt;<BR>
&gt; ...juerg<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;<BR>
&gt;&gt; Sincerely,<BR>
&gt;&gt; Martin Minka<BR>
&gt;&gt;<BR>
&gt;&gt; _______________________________________________<BR>
&gt;&gt; lm-sensors mailing list<BR>
&gt;&gt; lm-sensors@lm-sensors.org<BR>
&gt;&gt; <A =
HREF=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://l=
ists.lm-sensors.org/mailman/listinfo/lm-sensors</A><BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;<BR>
<BR>
_______________________________________________<BR>
lm-sensors mailing list<BR>
lm-sensors@lm-sensors.org<BR>
<A =
HREF=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://l=
ists.lm-sensors.org/mailman/listinfo/lm-sensors</A><BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7DCD3.48DE76D3--


--===============1345394329793816462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1345394329793816462==--
