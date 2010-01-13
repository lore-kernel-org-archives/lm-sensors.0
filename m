From: Manuel Lamotte-Schubert <mls@pronego.com>
Date: Wed, 13 Jan 2010 14:49:35 +0000
Subject: ***SPAM (0.1)*** Re: Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <4B4DDD7F.70509@pronego.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8006772000001591053=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8006772000001591053==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Jean Delvare wrote:
<blockquote cite="mid:20100113153747.1dab14c5@hyperion.delvare"
 type="cite">
  <pre wrap="">On Wed, 13 Jan 2010 15:20:57 +0100, Manuel Lamotte-Schubert wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi all,

I have an ZOTAC ION ITX-B mainboard.
(<a class="moz-txt-link-freetext" href="http://pden.zotac.com/index.php?page=shop.product_details&flypage=flypage_images.tpl&product_id=168&category_id=15&option=com_virtuemart&Itemid=1">http://pden.zotac.com/index.php?page=shop.product_details&amp;flypage=flypage_images.tpl&amp;product_id=168&amp;category_id=15&amp;option=com_virtuemart&amp;Itemid=1</a>)

I'm running Debian Lenny stable, having lm-sensors installed, Version: 
1:3.0.2-1+b2.
The kernel version is 2.6.32, self-compiled

Here's some output I get:
# lspci
...
00:03.2 SMBus: nVidia Corporation Device 0aa2 (rev b1)
...

# sensors-detect
...
Found unknown SMBus adapter 10de:0aa2 at 0000:00:03.2.
...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
A more recent version of sensors-detect (lm-sensors 3.1.0 or later)
would not show this message. Anyway, as long as the kernel itself knows
about the device (and this is your case) it doesn't really matter.

  </pre>
  <blockquote type="cite">
    <pre wrap=""># lspci -vv -s 00:03.2
00:03.2 SMBus: nVidia Corporation Device 0aa2 (rev b1)
        Subsystem: Device 19da:a108
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast &gt;TAbort- 
&lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 4900 [size=64]
        Region 4: I/O ports at 4d00 [size=64]
        Region 5: I/O ports at 4e00 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: nForce2_smbus
        Kernel modules: i2c-nforce2
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The i2c-nforce2 is used for the device, so it's OK.

  </pre>
  <blockquote type="cite">
    <pre wrap=""># i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Any help would be appreciated, maybe I can help supporting it!
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You did not tell us which I2C/SMBus adapter i2c-0 was. But seeing the
chips at 0x50-0x57, I would guess this is your graphics adapter, rather
than the SMBus (unless you have 8 memory modules, but I wouldn't expect
that on any Zotac product.) The chip at 0x4c could be a temperature
monitoring chip, we'd need a dump to tell. But first just try a more
recent version of sensors-detect:
<a class="moz-txt-link-freetext" href="http://dl.lm-sensors.org/lm-sensors/files/sensors-detect">http://dl.lm-sensors.org/lm-sensors/files/sensors-detect</a>

And report the full output.

  </pre>
</blockquote>
<tt>Hi,<br>
<br>
Thank you for your response.<br>
<br>
In fact, actually some minutes before your repsonse I've already run
the most recent version of sensors-detect as you suggested.<br>
<br>
Here's the output:<br>
...<br>
Intel Atom thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>
&nbsp;&nbsp;&nbsp; (driver `coretemp')<br>
...<br>
Using driver `i2c-nforce2' for device 0000:00:03.2: nVidia Corporation
nForce SMBus (MCP79)<br>
...<br>
Next adapter: SMBus nForce2 adapter at 4d00 (i2c-0)<br>
Probing for `Winbond W83L771AWG/ASG'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>
&nbsp;&nbsp;&nbsp; (confidence 6, driver `to-be-written')<br>
...<br>
Driver `to-be-written':<br>
&nbsp; * Bus `SMBus nForce2 adapter at 4d00'<br>
&nbsp;&nbsp;&nbsp; Busdriver `i2c_nforce2', I2C address 0x4c<br>
&nbsp;&nbsp;&nbsp; Chip `Winbond W83L771AWG/ASG' (confidence: 6)<br>
<br>
Driver `coretemp':<br>
&nbsp; * Chip `Intel Atom thermal sensor' (confidence: 9)<br>
<br>
Note: there is no driver for Winbond W83L771AWG/ASG yet.<br>
Check <a class="moz-txt-link-freetext" href="http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a> for updates.<br>
<br>
<br>
This means that the sensor could be detected but there is no driver for
using it?<br>
<br>
Cheers,<br>
Manuel Lamotte-Schubert</tt>
</body>
</html>


--===============8006772000001591053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8006772000001591053==--
