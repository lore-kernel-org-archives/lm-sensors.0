From: Joris Creyghton <jorisctn@gmail.com>
Date: Mon, 10 Jan 2011 18:48:38 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <1294685318.1916.11.camel@Asus5>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1919906686952361597=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
To: lm-sensors@vger.kernel.org


--===============1919906686952361597==
Content-Type: multipart/alternative; boundary="=-PrIQphPrhbrk0Gdh4/Ti"


--=-PrIQphPrhbrk0Gdh4/Ti
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-01-10 at 16:25 +0100, Luca Tettamanti wrote:

> On Wed, Jan 5, 2011 at 3:08 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> > To complicate things the firmware provides both the old and the new
> > ATK0110 interfaces, and the driver selects the old one. The new one
> > seems to have the code to read all the sensors. I'll see what I can
> > do.
> 
> I'm attaching a modified version of the driver; I've added a parameter
> to override the default detection logic, to test load it with new_if=1
> 
> Luca


Hello Luca,

Thank you for your work on the driver.
I really would like to test it ASAP, but I don't know how.
I'm a Linux newbie so I'm afraid I must ask you a recipe for this task.
Maybe you can point me to some links where the necessary steps are
explained.
I'm familiar with the process of compiling and linking to obtain
executable code but have no experience in testing drivers in Linux.

I'm planning to add an empty disc to my system and install a fresh
Ubuntu 10.10 64 bit desktop on it just for test purposes and to make
sure that I won't blow up my regular system.

Joris



--=-PrIQphPrhbrk0Gdh4/Ti
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
On Mon, 2011-01-10 at 16:25 +0100, Luca Tettamanti wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
On Wed, Jan 5, 2011 at 3:08 PM, Luca Tettamanti &lt;<A HREF="mailto:kronos.it@gmail.com">kronos.it@gmail.com</A>&gt; wrote:
&gt; To complicate things the firmware provides both the old and the new
&gt; ATK0110 interfaces, and the driver selects the old one. The new one
&gt; seems to have the code to read all the sensors. I'll see what I can
&gt; do.

I'm attaching a modified version of the driver; I've added a parameter
to override the default detection logic, to test load it with new_if=1

Luca
</PRE>
</BLOCKQUOTE>
<BR>
Hello Luca,<BR>
<BR>
Thank you for your work on the driver.<BR>
I really would like to test it ASAP, but I don't know how.<BR>
I'm a Linux newbie so I'm afraid I must ask you a recipe for this task.<BR>
Maybe you can point me to some links where the necessary steps are explained.<BR>
I'm familiar with the process of compiling and linking to obtain executable code but have no experience in testing drivers in Linux.<BR>
<BR>
I'm planning to add an empty disc to my system and install a fresh Ubuntu 10.10 64 bit desktop on it just for test purposes and to make sure that I won't blow up my regular system.<BR>
<BR>
Joris<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-PrIQphPrhbrk0Gdh4/Ti--



--===============1919906686952361597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1919906686952361597==--

