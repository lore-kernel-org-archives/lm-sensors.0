From: "Jose M. Caballero" <caballeroguerrero@hotmail.es>
Date: Wed, 08 Dec 2010 13:47:56 +0000
Subject: [lm-sensors] W83667HG-B w83627ehf
Message-Id: <BLU0-SMTP144B1A48271E23900BFDB36CE2D0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4066174573202665096=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4066174573202665096==
Content-Type: multipart/alternative; boundary="=-wFggPq0vmSAvEW6TYhS0"

--=-wFggPq0vmSAvEW6TYhS0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've got the sensor W83667HG-B (I get it by sensors-detect) wich is
controlled by the driver w83627ehf (looking manually in sensors-detect @
5883) and I've got many problems installing it in ubuntu 10.10
(maverick) wich is the kernel 2.6.35-23 with no modifications. The
motherboard is AsRock H55M Pro.

Any help is welcome. I am new to all this but I don't want my
Motherboard fried, like the last one.

I first go to 

http://www.lm-sensors.org/wiki/iwizard/ManualInstall

And do it all carefully. I read the install archive and install all
dependencies and all that.

But when I go to:

http://www.lm-sensors.org/wiki/iwizard/Detection

I get some doubts:

there are no file /etc/modules.conf just a /etc/modules 
Is that the file? Should I create the file?
Similar happens to the file: /etc/rc* I just got a /etc/rc.local and
many directories /etc/rc*.d with a lot of files
So which is the file?

Must I substitute the sensors-detect provided 5861 by the patch 5883?

Should I copy the driver needed w83627ehf.c? Where?

Thanks for all.




--=-wFggPq0vmSAvEW6TYhS0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.1">
</HEAD>
<BODY>
<TT><FONT COLOR="#1a1a1a">I've got the sensor W83667HG-B (I get it by sensors-detect) wich is</FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">controlled by the driver w83627ehf (looking manually in sensors-detect @</FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">5883) and I've got many problems installing it in ubuntu 10.10</FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">(maverick) wich is the kernel 2.6.35-23 with no modifications. The</FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">motherboard is AsRock H55M Pro.</FONT></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">Any help is welcome. I am new to all this but I don't want my Motherboard fried, like the last one.</FONT></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">I first go to </FONT></TT><BR>
<BR>
<TT><A HREF="http://www.lm-sensors.org/wiki/iwizard/ManualInstall">http://www.lm-sensors.org/wiki/iwizard/ManualInstall</A></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">And do it all carefully. I read the install archive and install all</FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">dependencies and all that.</FONT></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">But when I go to:</FONT></TT><BR>
<BR>
<TT><A HREF="http://www.lm-sensors.org/wiki/iwizard/Detection">http://www.lm-sensors.org/wiki/iwizard/Detection</A></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">I get some doubts:</FONT></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">there are no file /etc/modules.conf just a /etc/modules </FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">Is that the file? Should I create the file?</FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">Similar happens to the file: /etc/rc* I just got a /etc/rc.local and many directories /etc/rc*.d with a lot of files</FONT></TT><BR>
<TT><FONT COLOR="#1a1a1a">So which is the file?</FONT></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">Must I substitute the sensors-detect provided 5861 by the patch 5883?</FONT></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">Should I copy the driver needed w83627ehf.c? Where?</FONT></TT><BR>
<BR>
<TT><FONT COLOR="#1a1a1a">Thanks for all.</FONT></TT><BR>
<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-wFggPq0vmSAvEW6TYhS0--


--===============4066174573202665096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4066174573202665096==--
