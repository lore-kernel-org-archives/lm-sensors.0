From: Dean Loros <autocrosser1@gmail.com>
Date: Fri, 20 Feb 2009 15:06:13 +0000
Subject: Re: [lm-sensors] More information on Gigabyte GA-EX58-UD4P
Message-Id: <499EC6E5.7080804@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3790327452502426274=="
List-Id: <lm-sensors.vger.kernel.org>
References: <49986A9C.6000606@gmail.com>
In-Reply-To: <49986A9C.6000606@gmail.com>
To: lm-sensors@vger.kernel.org

--===============3790327452502426274==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Thank you Jean---<br>
<br>
I added to the file: /etc/modprobe.d/options &amp; it worked very
well---I'm really waiting for 2.6.29 to be released for testing in
Ubuntu.<br>
<br>
&nbsp;<br>
<br>
On 02/20/2009 12:25 AM, Jean Delvare wrote:
<blockquote cite="mid:20090220092509.76dd20b2@hyperion.delvare"
 type="cite">
  <pre wrap="">Hi Dean,

On Thu, 19 Feb 2009 22:10:51 -0800, Dean Loros wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Thank you for the information Jean---I assumed that the force_id
option went into /etc/sensors.conf &amp; /etc/sensors3.conf--I inserted
it in a way I thought was correct &amp; got "Error: Line 1225: Invalid
keyword"....The line looks like:  options it87 force_id=0x8718
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Huu, no, it doesn't go into /etc/sensors3.conf...

  </pre>
  <blockquote type="cite">
    <pre wrap="">I then tried to include it into /etc/modules &amp; got no response at all...line looks like:

# Chip drivers
it87
i2c-dev options it87 force_id=0x8718
coretemp
    </pre>
  </blockquote>
  <pre wrap=""><!---->
... and presumably not into /etc/modules either, although I am no
Debian specialist.

  </pre>
  <blockquote type="cite">
    <pre wrap="">So I am at a loss as to where the option should be inserted--there
is not a modprobe file in Ubuntu--Running the current Jaunty testing
9.04 version for x86. Using the stock ubuntu Jaunty kernel--currently
at 2.6.28.8--don't want to create a .29 kernel due to testing
requirements. We have to wait until 9.10 testing in two months to
move to .29.

Thank you for your time..
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Add the following line to either /etc/modprobe.conf or any file under
directory /etc/modprobe.d:

options it87 force_id=0x8718

Then cycle the it87 driver (rmmod it87 &amp;&amp; modprobe it87). This should
do the trick.

  </pre>
</blockquote>
<br>
</body>
</html>


--===============3790327452502426274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3790327452502426274==--
