From: Ivan Yulaev <ivany@dinigroup.com>
Date: Fri, 16 Mar 2012 21:28:39 +0000
Subject: [lm-sensors] Question regarding designing hardware for use with lm-sensors
Message-Id: <4F63B087.6010205@dinigroup.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5698071688927855824=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5698071688927855824==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Calibri">Dear lm-sensors mailing list members,<br>
<br>
I'm an engineer currently working on the design of a small FPGA board
that will be hosted in a PCIe slot. For our previous products we've
rolled our own temperature monitoring software. For a new project, I'd
like to try designing our board such that lm-sensors can query the
temperature of the board. I'm very shaky on my understanding of how
lm-sensors queries the temperature of a PCIe card, f.ex. a graphics
card. Here is my mental model, which needs filling in:<br>
<br>
lm-sensors ---&gt; ????? --- (iic bus) --&gt; iic temp sensor<br>
<br>
My first impulse was to host the temperature sensor on the SMBus pins
on the PCIe slot directly, ADM1033 comes to mind. However, it looks
like I need to use a sensor that implements ARP, which is not very
common. Also it looks like lm-sensors does not really support ARP so
this seems like it would be an uphill fight.<br>
<br>
For graphics cards and other PCIe subsystems, is the iic temp sensor
hosted on the card's PCIe controller chip and queried through the main
PCIe data interface then? And the "dedicated" SMbus lines on the PCIe
interface are unused? If so, is the model then something like this?<br>
<br>
lm-sensors ---&gt; vendor-provided driver for PCIe product ---&gt; PCIe
data interface ---&gt; PCIe controller on daughter card --- (iic bus)
---&gt; temp sensor<br>
<br>
If so, it seems like I'd have to provide some (standard?) hooks in my
PCIe driver for the temperature sensor, that allow me to communicate to
the IIC bus on the card. And I need to have corresponding registers on
my card's controller that can be used to talk to the IIC lines there.<br>
<br>
</font><font face="Calibri">I'd also appreciate it if you could refer
me
to any documentation that would be useful for understanding the general
field of this inquiry, the PCI Express specification wasn't very useful
in this regard.</font><br>
<font face="Calibri"><br>
Thanks in advance. I apologize for my lack of understanding in this
area. <br>
</font>
<pre class="moz-signature" cols="72">-- 
Sincerely,
Ivan Yulaev

</pre>
</body>
</html>


--===============5698071688927855824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5698071688927855824==--
