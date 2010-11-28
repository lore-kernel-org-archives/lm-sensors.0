From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Sun, 28 Nov 2010 12:10:58 +0000
Subject: Re: [lm-sensors] how to rename sensor variables
Message-Id: <287762.42165.qm@web111726.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2084337009024465155=="
List-Id: <lm-sensors.vger.kernel.org>
References: <771591.69512.qm@web111709.mail.gq1.yahoo.com>
In-Reply-To: <771591.69512.qm@web111709.mail.gq1.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============2084337009024465155==
Content-Type: multipart/alternative; boundary="0-1937042652-1290946258=:42165"

--0-1937042652-1290946258=:42165
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>chip "k10temp-pci-*"=0A>=A0=A0 label temp1 "CPU0"=0A>=A0=A0=A0 label temp2=
 "CPU1"=0A>=A0=A0=A0 ignore temp3=0A=A0=0AThanks for that. It did the job=
=0A=A0=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A_______________________________=
_=0AFrom: Jean-Philippe Orsini <jeanfi@gmail.com>=0ATo: lm-sensors@lm-senso=
rs.org=0ASent: Sun, November 28, 2010 3:19:24 PM=0ASubject: Re: [lm-sensors=
] how to rename sensor variables=0A=0AOn 11/28/2010 08:39 AM, Mahmood Nader=
an wrote:=0A> There is nothing about k10temp in sensors3.conf.=0AI guess yo=
u can add an entry in the configuration file, something like:=0A=0Achip "k1=
0temp-pci-*"=0A=A0=A0=A0 label temp1 "CPU0"=0A=A0=A0=A0 label temp2 "CPU1"=
=0A=A0=A0=A0 ignore temp3=0A=0Aman sensors.conf should give you more inform=
ation.=0A=0ARegards,=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 JeanFI.=0A=0A___=
____________________________________________=0Alm-sensors mailing list=0Alm=
-sensors@lm-sensors.org=0Ahttp://lists.lm-sensors.org/mailman/listinfo/lm-s=
ensors=0A=0A=0A=0A      
--0-1937042652-1290946258=:42165
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt"><P>&gt;chip "k10temp-pci-*"<BR>&gt;&nbsp;&nbsp; label temp1 "CPU0"<B=
R>&gt;&nbsp;&nbsp;&nbsp; label temp2 "CPU1"<BR>&gt;&nbsp;&nbsp;&nbsp; ignor=
e temp3</P>=0A<P>&nbsp;</P>=0A<P>Thanks for that. It did the job<BR>&nbsp;<=
/P>=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" color=3D#0080f=
f size=3D2 face=3D"arial, helvetica, sans-serif"><STRONG>// Naderan *Mahmoo=
d;</STRONG></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV style=3D"FONT-FAMIL=
Y: tahoma, new york, times, serif; FONT-SIZE: 12pt"><BR>=0A<DIV style=3D"FO=
NT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"><FONT size=3D2 =
face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"FONT-WEIGHT: bold">From:=
</SPAN></B> Jean-Philippe Orsini &lt;jeanfi@gmail.com&gt;<BR><B><SPAN style=
=3D"FONT-WEIGHT: bold">To:</SPAN></B> lm-sensors@lm-sensors.org<BR><B><SPAN=
 style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Sun, November 28, 2010 3:19:2=
4 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subject:</SPAN></B> Re: [lm-se=
nsors] how to rename sensor variables<BR></FONT><BR>On 11/28/2010 08:39 AM,=
 Mahmood Naderan wrote:<BR>&gt; There is nothing about k10temp in sensors3.=
conf.<BR>I guess you can add an entry in the configuration file, something =
like:<BR><BR>chip "k10temp-pci-*"<BR>&nbsp;&nbsp;&nbsp; label temp1 "CPU0"<=
BR>&nbsp;&nbsp;&nbsp; label temp2 "CPU1"<BR>&nbsp;&nbsp;&nbsp; ignore temp3=
<BR><BR>man sensors.conf should give you more information.<BR><BR>Regards,<=
BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; JeanFI.<B=
R><BR>_______________________________________________<BR>lm-sensors mailing=
 list<BR><A
 href=3D"mailto:lm-sensors@lm-sensors.org" ymailto=3D"mailto:lm-sensors@lm-=
sensors.org">lm-sensors@lm-sensors.org</A><BR>http://lists.lm-sensors.org/m=
ailman/listinfo/lm-sensors<BR></DIV></DIV></div><br>=0A=0A      </body></ht=
ml>
--0-1937042652-1290946258=:42165--


--===============2084337009024465155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2084337009024465155==--
