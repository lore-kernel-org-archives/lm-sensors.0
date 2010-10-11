From: Patrick Nagelschmidt <dto@gmx.net>
Date: Mon, 11 Oct 2010 20:54:26 +0000
Subject: Re: [lm-sensors] IT8721F/IT8758E support
Message-Id: <4CB37982.4060301@gmx.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7875740404028455127=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101011221911.38c8a3d7@endymion.delvare>
In-Reply-To: <20101011221911.38c8a3d7@endymion.delvare>
To: lm-sensors@vger.kernel.org

--===============7875740404028455127==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    On 11.10.2010 22:19, Jean Delvare wrote:
    <blockquote cite="mid:20101011221911.38c8a3d7@endymion.delvare"
      type="cite">
      <pre wrap="">Hi Patrick, Jae, Virgil,

I am done adding support for the IT8721F/IT8758E to the it87 Linux
driver. You can download a stand-alone version of the driver at:
  <a class="moz-txt-link-freetext" href="http://khali.linux-fr.org/devel/misc/it87/">http://khali.linux-fr.org/devel/misc/it87/</a>

Please test and report :) Beware the code is untested so far, as I
don't have this chip at hand.

Patrick, note that with an Asus board, it is entirely possible that the
it87 driver can't be loaded due to ACPI requesting the I/O ports
(you'll get a warning in the kernel log in that case) and you have to
use the asus_atk0110 driver instead.

</pre>
    </blockquote>
    Hi Jean,<br>
    <br>
    you're right:<br>
    <blockquote>it87: Found IT8721F chip at 0x290, revision 1<br>
      ACPI: resource it87 [io&nbsp; 0x0295-0x0296] conflicts with ACPI region
      SIOE [??? 0x00000290-0x000002af flags 0x45]<br>
      ACPI: If an ACPI driver is available for this device, you should
      use it instead of the native driver<br>
    </blockquote>
    but the asus_atk0110 did the trick:<br>
    <blockquote>k10temp-pci-00c3<br>
      Adapter: PCI adapter<br>
      temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +25.2&deg;C&nbsp; (high = +70.0&deg;C, crit = +99.5&deg;C)<br>
      <br>
      atk0110-acpi-0<br>
      Adapter: ACPI interface<br>
      Vcore Voltage:&nbsp;&nbsp;&nbsp;&nbsp; +1.33 V&nbsp; (min =&nbsp; +0.85 V, max =&nbsp; +1.60 V)<br>
      &nbsp;+3.3 Voltage:&nbsp;&nbsp;&nbsp;&nbsp; +3.33 V&nbsp; (min =&nbsp; +2.97 V, max =&nbsp; +3.63 V)<br>
      &nbsp;+5 Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.89 V&nbsp; (min =&nbsp; +4.50 V, max =&nbsp; +5.50 V)<br>
      &nbsp;+12 Voltage:&nbsp;&nbsp;&nbsp;&nbsp; +12.08 V&nbsp; (min = +10.20 V, max = +13.80 V)<br>
      CPU FAN Speed:&nbsp;&nbsp;&nbsp; 2280 RPM&nbsp; (min =&nbsp; 600 RPM)<br>
      CHASSIS FAN Speed: 511 RPM&nbsp; (min =&nbsp; 600 RPM)<br>
      CPU Temperature:&nbsp;&nbsp; +34.0&deg;C&nbsp; (high = +60.0&deg;C, crit = +95.0&deg;C)<br>
      MB Temperature:&nbsp;&nbsp;&nbsp; +37.0&deg;C&nbsp; (high = +45.0&deg;C, crit = +75.0&deg;C)<br>
    </blockquote>
    Btw, can you detect the mainboard vendor? If you can it would
    probably be a solution to recommend using this module for
    asus-owners in general. As it seems lm-sensors is capable of much
    more than the scan makes you think in the first place when it
    announces it has no driver for the sensor found :)<br>
    <br>
    Thanks for your efforts, greatly appreciate the fast reaction :)<br>
    <br>
    Br,<br>
    &nbsp;Patrick<br>
    <br>
  </body>
</html>


--===============7875740404028455127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7875740404028455127==--
