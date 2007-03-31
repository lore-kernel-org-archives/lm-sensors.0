From: Aldo Caruso <acaruso@argencasas.com>
Date: Sat, 31 Mar 2007 14:00:53 +0000
Subject: Re: [lm-sensors] ITE IT8718F Super IO Sensors
Message-Id: <460E6995.7080101@argencasas.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3091366445540184659=="
List-Id: <lm-sensors.vger.kernel.org>
References: <460C6782.7010603@argencasas.com>
In-Reply-To: <460C6782.7010603@argencasas.com>
To: lm-sensors@vger.kernel.org

--===============3091366445540184659==
Content-Type: text/html; charset=US-ASCII
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=US-ASCII" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Jean,<br>
<br>
&nbsp; Thanks for your answer. Debian etch is using kernel 2.6.18, and that
may be the cause of the problem. I'll wait until the new kernel is
released and keep you informed.<br>
<br>
Best regards,<br>
<br>
Aldo<br>
<br>
Jean Delvare wrote:
<blockquote cite="mid20070331152447.081cff4c.khali@linux-fr.org"
 type="cite">
  <pre wrap="">Hi Aldo,

On Thu, 29 Mar 2007 22:27:30 -0300, Aldo Caruso wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi,

  I'm running debian on a Penium IV with a P4M800PRO-M motherboard.
  I run sensors-detect and this is the result :

//--------------------------------------------------------------
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0400'
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8718F Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-viapro
# Chip drivers
eeprom
it87
#----cut here----
//--------------------------------------------------------------

I let the program add the former lines to /etc/modules, I reboot, I run 
sensors and this is the result:
//--------------------------------------------------------------
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
//--------------------------------------------------------------

Doing lsmod I found all the above modules listed.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Which kernel are you running? If you look at:
  <a class="moz-txt-link-freetext" href="http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a>
you'll see that support for the ITE IT8718F is only available since
kernel 2.6.19.

  </pre>
</blockquote>
</body>
</html>


--===============3091366445540184659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3091366445540184659==--
