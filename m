From: Joris Creyghton <jorisctn@gmail.com>
Date: Mon, 10 Jan 2011 20:01:36 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <1294689696.1916.31.camel@Asus5>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8472409878842222550=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
To: lm-sensors@vger.kernel.org


--===============8472409878842222550==
Content-Type: multipart/alternative; boundary="=-edvvYELbhoLh5qToeVGf"


--=-edvvYELbhoLh5qToeVGf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-01-10 at 19:56 +0100, Jean Delvare wrote:

> Hi Joris,
> 
> On Mon, 10 Jan 2011 19:48:38 +0100, Joris Creyghton wrote:
> > Thank you for your work on the driver.
> > I really would like to test it ASAP, but I don't know how.
> > I'm a Linux newbie so I'm afraid I must ask you a recipe for this task.
> > Maybe you can point me to some links where the necessary steps are
> > explained.
> > I'm familiar with the process of compiling and linking to obtain
> > executable code but have no experience in testing drivers in Linux.
> > 
> > I'm planning to add an empty disc to my system and install a fresh
> > Ubuntu 10.10 64 bit desktop on it just for test purposes and to make
> > sure that I won't blow up my regular system.
> 
> You can pick any example Makefile on my site, e.g.:
> http://khali.linux-fr.org/devel/misc/w83795/Makefile
> 
> Change
>   DRIVER := w83795
> to
>   DRIVER := asus_atk0110
> 
> put both files in a temporary directory, then type "make". You'll need
> make, gcc and configured kernel headers installed. When the build is
> successful, you can test the module as root with:
> 
> # rmmod asus_atk0110
> # insmod ./asus_atk0110.ko
> 
> Hope that helps,


Bon soir Jean,

Thank you for your suggestions!
I'll install the new disk and dummy system tomorrow morning and then try
your recipe.
I'll report the results or return with some more questions.

Joris

--=-edvvYELbhoLh5qToeVGf
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
On Mon, 2011-01-10 at 19:56 +0100, Jean Delvare wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Hi Joris,

On Mon, 10 Jan 2011 19:48:38 +0100, Joris Creyghton wrote:
&gt; Thank you for your work on the driver.
&gt; I really would like to test it ASAP, but I don't know how.
&gt; I'm a Linux newbie so I'm afraid I must ask you a recipe for this task.
&gt; Maybe you can point me to some links where the necessary steps are
&gt; explained.
&gt; I'm familiar with the process of compiling and linking to obtain
&gt; executable code but have no experience in testing drivers in Linux.
&gt; 
&gt; I'm planning to add an empty disc to my system and install a fresh
&gt; Ubuntu 10.10 64 bit desktop on it just for test purposes and to make
&gt; sure that I won't blow up my regular system.

You can pick any example Makefile on my site, e.g.:
<A HREF="http://khali.linux-fr.org/devel/misc/w83795/Makefile">http://khali.linux-fr.org/devel/misc/w83795/Makefile</A>

Change
  DRIVER := w83795
to
  DRIVER := asus_atk0110

put both files in a temporary directory, then type &quot;make&quot;. You'll need
make, gcc and configured kernel headers installed. When the build is
successful, you can test the module as root with:

# rmmod asus_atk0110
# insmod ./asus_atk0110.ko

Hope that helps,
</PRE>
</BLOCKQUOTE>
<BR>
Bon soir Jean,<BR>
<BR>
Thank you for your suggestions!<BR>
I'll install the new disk and dummy system tomorrow morning and then try your recipe.<BR>
I'll report the results or return with some more questions.<BR>
<BR>
Joris
</BODY>
</HTML>

--=-edvvYELbhoLh5qToeVGf--



--===============8472409878842222550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8472409878842222550==--

