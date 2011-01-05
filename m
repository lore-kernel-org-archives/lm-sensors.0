From: Joris Creyghton <jorisctn@gmail.com>
Date: Wed, 05 Jan 2011 14:35:57 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <1294238157.1892.19.camel@Asus5>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6885027932673880228=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
To: lm-sensors@vger.kernel.org


--===============6885027932673880228==
Content-Type: multipart/alternative; boundary="=-ib/CxyMQF2g90cAJVFEr"


--=-ib/CxyMQF2g90cAJVFEr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-01-05 at 15:08 +0100, Luca Tettamanti wrote:


> Hum, it appears to be a bug in the ACPI code, the method that reads
> the temperature does not know how to read the MCH temperature which
> would be HWT2 (the entry is present in the enumeration though):
> 
> Method (TGET, 1, NotSerialized)
> {
>     If (LEqual (Arg0, Zero))
>     {
>         Return (^^SIOR.HWT1 ())
>     }
> 
>     If (LEqual (Arg0, One))
>     {
>         Return (^^SIOR.HWT0 ())
>     }
> }
> 
> To complicate things the firmware provides both the old and the new
> ATK0110 interfaces, and the driver selects the old one. The new one
> seems to have the code to read all the sensors. I'll see what I can
> do.
> 
> Luca


Looking forward to your further findings.
Joris



--=-ib/CxyMQF2g90cAJVFEr
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
On Wed, 2011-01-05 at 15:08 +0100, Luca Tettamanti wrote:<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
Hum, it appears to be a bug in the ACPI code, the method that reads
the temperature does not know how to read the MCH temperature which
would be HWT2 (the entry is present in the enumeration though):

Method (TGET, 1, NotSerialized)
{
    If (LEqual (Arg0, Zero))
    {
        Return (^^SIOR.HWT1 ())
    }

    If (LEqual (Arg0, One))
    {
        Return (^^SIOR.HWT0 ())
    }
}

To complicate things the firmware provides both the old and the new
ATK0110 interfaces, and the driver selects the old one. The new one
seems to have the code to read all the sensors. I'll see what I can
do.

Luca
</PRE>
</BLOCKQUOTE>
<BR>
Looking forward to your further findings.<BR>
Joris<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-ib/CxyMQF2g90cAJVFEr--



--===============6885027932673880228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6885027932673880228==--

