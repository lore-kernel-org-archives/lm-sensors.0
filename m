From: James Scott Jr <skoona@verizon.net>
Date: Mon, 22 Oct 2007 02:11:32 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from	'sensors'
Message-Id: <1193019092.2754.2.camel@homedev.skoona.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1136606374521985660=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
To: lm-sensors@vger.kernel.org


--===============1136606374521985660==
Content-Type: multipart/alternative; boundary="=-+R4UXbaY/B4GnsZaXlPQ"


--=-+R4UXbaY/B4GnsZaXlPQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Jean,

Thanks for the update on how and where the coretemp-* module gets its
values.  Understanding this makes the 10°C not seems too great a
difference.

James,

On Sun, 2007-10-21 at 20:43 +0200, Jean Delvare wrote:

> On Sun, 21 Oct 2007 06:35:05 -0700 (PDT), JAMES SCOTT wrote:
> > Jean; The abituguru3... sensors output showed 'CPU 40c' and coretemp...
> > details the same CPU around '50c'.  So, I have output, it is formatted
> > correctly.  However, I believe the reported value is wrong.  10c is a
> > huge difference in values - which is correct?
> 
> 10°C isn't that big, it really depends what the different sensors
> measure exactly. It is possible that all temperatures are correct and
> just not measuring the same thing. The coretemp driver reports the CPU
> core temperature, which is presumably the hottest point of the CPU. The
> abituguru driver, OTOH, may be reporting the temperature in the CPU
> socket, or the temperature of a thermal diode close to the CPU or
> inside the CPU but not in the core. It is expected that the reported
> temperature is lower.
> 
> > I did not find the coretemp-isa-* in the sensors.conf file.  Do you
> > know where the computes for this module are setup?
> 
> No computes are needed for the coretemp, the temperatures are reported
> directly by the driver.
> 

--=-+R4UXbaY/B4GnsZaXlPQ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.3">
</HEAD>
<BODY>
Jean,<BR>
<BR>
Thanks for the update on how and where the coretemp-* module gets its values.&nbsp; Understanding this makes the 10<FONT COLOR="#000000">&#176;</FONT>C not seems too great a difference.<BR>
<BR>
James,<BR>
<BR>
On Sun, 2007-10-21 at 20:43 +0200, Jean Delvare wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">On Sun, 21 Oct 2007 06:35:05 -0700 (PDT), JAMES SCOTT wrote:</FONT>
<FONT COLOR="#000000">&gt; Jean; The abituguru3... sensors output showed 'CPU 40c' and coretemp...</FONT>
<FONT COLOR="#000000">&gt; details the same CPU around '50c'.  So, I have output, it is formatted</FONT>
<FONT COLOR="#000000">&gt; correctly.  However, I believe the reported value is wrong.  10c is a</FONT>
<FONT COLOR="#000000">&gt; huge difference in values - which is correct?</FONT>

<FONT COLOR="#000000">10&#176;C isn't that big, it really depends what the different sensors</FONT>
<FONT COLOR="#000000">measure exactly. It is possible that all temperatures are correct and</FONT>
<FONT COLOR="#000000">just not measuring the same thing. The coretemp driver reports the CPU</FONT>
<FONT COLOR="#000000">core temperature, which is presumably the hottest point of the CPU. The</FONT>
<FONT COLOR="#000000">abituguru driver, OTOH, may be reporting the temperature in the CPU</FONT>
<FONT COLOR="#000000">socket, or the temperature of a thermal diode close to the CPU or</FONT>
<FONT COLOR="#000000">inside the CPU but not in the core. It is expected that the reported</FONT>
<FONT COLOR="#000000">temperature is lower.</FONT>

<FONT COLOR="#000000">&gt; I did not find the coretemp-isa-* in the sensors.conf file.  Do you</FONT>
<FONT COLOR="#000000">&gt; know where the computes for this module are setup?</FONT>

<FONT COLOR="#000000">No computes are needed for the coretemp, the temperatures are reported</FONT>
<FONT COLOR="#000000">directly by the driver.</FONT>

</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-+R4UXbaY/B4GnsZaXlPQ--



--===============1136606374521985660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1136606374521985660==--

