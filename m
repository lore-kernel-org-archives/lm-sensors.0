From: Joris Creyghton <jorisctn@gmail.com>
Date: Mon, 17 Jan 2011 20:17:56 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <1295295476.2045.7.camel@Asus5>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1086697521663443871=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
To: lm-sensors@vger.kernel.org


--===============1086697521663443871==
Content-Type: multipart/alternative; boundary="=-EA67omPjYA5J5vZbU6zX"


--=-EA67omPjYA5J5vZbU6zX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Luca,

On Mon, 2011-01-17 at 13:49 +0100, Luca Tettamanti wrote:


> Sorry for the delay :)

No problem :-) 

> I've updated the driver to automatically select the correct interface
> on your board.
> Compile and load it without any additional parameter.

It's working fine.

I have looked into your source and would like to suggest to change the
comment in line 33, which reads:

    /* Old interface has broken fan monitoring */

The main problem with the old interface was that it didn't communicate
the MCH temperature. The MCH happens to be the hottest component on this
MB, so I want to keep an eye on it.

The confusion about the labeling of the different fans is rather
trivial.
There are 6 fan connectors on the MB, all properly labeled. One of them
has the label NB_fan, although there is no North Bridge fan on this
board. That's just careless of Asus. I think I connected one of the
chassis fans to this connector.

So I would suggest that you change the comment in line 33 to:

    /* Old interface has broken MCH temperature monitoring */

When you think it is usefull I can verify whether the different fan
connector labels are properly displayed in the BIOS output and in the
output of the sensors command.

Joris





--=-EA67omPjYA5J5vZbU6zX
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
Hi Luca,<BR>
<BR>
On Mon, 2011-01-17 at 13:49 +0100, Luca Tettamanti wrote:<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
Sorry for the delay :)
</PRE>
</BLOCKQUOTE>
No problem :-) 
<BLOCKQUOTE TYPE=CITE>
<PRE>
I've updated the driver to automatically select the correct interface
on your board.
Compile and load it without any additional parameter.
</PRE>
</BLOCKQUOTE>
It's working fine.<BR>
<BR>
I have looked into your source and would like to suggest to change the comment in line 33, which reads:<BR>
<BR>
&nbsp;&nbsp;&nbsp; /* Old interface has broken fan monitoring */<BR>
<BR>
The main problem with the old interface was that it didn't communicate the MCH temperature. The MCH happens to be the hottest component on this MB, so I want to keep an eye on it.<BR>
<BR>
The confusion about the labeling of the different fans is rather trivial.<BR>
There are 6 fan connectors on the MB, all properly labeled. One of them has the label NB_fan, although there is no North Bridge fan on this board. That's just careless of Asus. I think I connected one of the chassis fans to this connector.<BR>
<BR>
So I would suggest that you change the comment in line 33 to:<BR>
<BR>
&nbsp;&nbsp;&nbsp; /* Old interface has broken MCH temperature monitoring */<BR>
<BR>
When you think it is usefull I can verify whether the different fan connector labels are properly displayed in the BIOS output and in the output of the sensors command.<BR>
<BR>
Joris<BR>
<BR>
<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-EA67omPjYA5J5vZbU6zX--



--===============1086697521663443871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1086697521663443871==--

