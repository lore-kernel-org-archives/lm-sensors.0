From: Dean Loros <autocrosser1@gmail.com>
Date: Fri, 20 Feb 2009 06:10:51 +0000
Subject: Re: [lm-sensors] More information on Gigabyte GA-EX58-UD4P
Message-Id: <499E496B.1010707@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2622940037415373735=="
List-Id: <lm-sensors.vger.kernel.org>
References: <49986A9C.6000606@gmail.com>
In-Reply-To: <49986A9C.6000606@gmail.com>
To: lm-sensors@vger.kernel.org

--===============2622940037415373735==
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
Thank you for the information Jean---I assumed that the force_id
option went into /etc/sensors.conf &amp; /etc/sensors3.conf--I inserted
it in a way I
thought was correct &amp; got "Error: Line 1225: Invalid
keyword"....The
line looks like:&nbsp; options it87 force_id=0x8718<br>
<br>
I then tried to include it into /etc/modules &amp; got no response at
all...line looks like: <br>
<br>
# Chip drivers<br>
it87<br>
i2c-dev options it87 force_id=0x8718<br>
coretemp<br>
<br>
So I am at a loss as to where the option should be inserted--there is
not a modprobe file in Ubuntu--Running the current Jaunty testing 9.04
version for x86. Using the stock ubuntu Jaunty kernel--currently at
2.6.28.8--don't want to create a .29 kernel due to testing
requirements. We have to wait until 9.10 testing in two months to move
to .29.<br>
<br>
Thank you for your time..<br>
<br>
Dean Loros<br>
<br>
<br>
On 02/19/2009 09:06 AM, Jean Delvare wrote:<br>
<blockquote cite="mid:20090219180603.3494df35@hyperion.delvare"
 type="cite">
  <pre wrap="">Hi Dean,

On Sun, 15 Feb 2009 11:18:52 -0800, Dean Loros wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I went to the website &amp; got the most current sensors-detect....Important 
info follows:

Driver `to-be-written' (should be inserted):
   Detects correctly:
   * ISA bus, address 0x290
     Chip `ITE IT8720 Super IO Sensors' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
# no driver for ITE IT8720 Super IO Sensors yet
/usr/bin/sensors -s
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.


So my next question is:  What is the status of the ITE IT8720 driver &amp; 
what can I do to help the process along?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Please search for "IT8720F" on this page:
<a class="moz-txt-link-freetext"
 href="http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a>
It answers your first question.

If installing a bleeding-edge kernel isn't an option for you, you can
load the it87 driver with parameter force_id=0x8718. It will make the
it87 driver treat your IT8720F chip as if it were an IT8718F, which is
supported for a long time now. The IT8718F and IT8720F are essentially
compatible as far as the hardware monitoring block is concerned.

  </pre>
</blockquote>
<br>
</body>
</html>


--===============2622940037415373735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2622940037415373735==--
