From: "John Beavers" <john@lightningsoftwaresolutions.com>
Date: Thu, 05 Jul 2007 21:52:52 +0000
Subject: [lm-sensors] Using libsensors in custom application
Message-Id: <000001c7bf4e$d7dce200$0500a8c0@LSSDESIGN>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5675582010154215226=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============5675582010154215226==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C7BF24.EF0923F0"

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C7BF24.EF0923F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
 
I'm trying to develop an application that can get the temperature of the CPU
/ MB and send it to another machine on the network for remote temperature
monitoring.  I've managed to compile and run a program that successfully
sends test data over the network, reads chip data like sensors (using the
same code), but I cannot get it to do both together.  Basically, I cannot
tell where / how sensors is getting the information it is outputting to the
screen.  I've tracked it down to m->fn(&name); in the do_a_print() function,
but I cannot see how that line prints out the chip information.  My question
is, is there a tutorial of how to use libsensors in an application
somewhere, or can you give me a brief explanation of how to get the CPU  &
MB temp from libsensors?
 
Thanks,
John Beavers

------=_NextPart_000_0001_01C7BF24.EF0923F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.3790.2920" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D890264621-05072007><FONT face=3DArial=20
size=3D2>Hello,</FONT></SPAN></DIV>
<DIV><SPAN class=3D890264621-05072007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D890264621-05072007><FONT face=3DArial size=3D2>I'm =
trying to=20
develop an application that can get the temperature of the CPU / MB and =
send it=20
to another machine on the network for remote temperature =
monitoring.&nbsp; I've=20
managed to compile and run a program that successfully sends test data =
over the=20
network, reads chip data like sensors (using the same code), but I =
cannot get it=20
to do both together.&nbsp; Basically, I cannot tell where / how sensors =
is=20
getting the information it is outputting to the screen.&nbsp; I've =
tracked it=20
down to m-&gt;fn(&amp;name); in the do_a_print() function, but I cannot =
see how=20
that line prints out the chip information.&nbsp; My question is, is =
there a=20
tutorial of how to use libsensors in an application somewhere, or can =
you give=20
me a brief explanation of how to get the CPU&nbsp; &amp; MB temp from=20
libsensors?</FONT></SPAN></DIV>
<DIV><SPAN class=3D890264621-05072007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D890264621-05072007><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D890264621-05072007><FONT face=3DArial size=3D2>John=20
Beavers</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_0001_01C7BF24.EF0923F0--



--===============5675582010154215226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5675582010154215226==--

