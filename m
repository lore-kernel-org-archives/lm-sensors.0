From: "pepe@fernandezfreire.com" <pepe@fernandezfreire.com>
Date: Wed, 28 Oct 2009 16:25:02 +0000
Subject: Re: [lm-sensors] Help needed with lm-sensors & 9.10 & Asus M2N
Message-Id: <69c4cb750910280925s20435eceg3718e12467d08955@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8570718433274205302=="
List-Id: <lm-sensors.vger.kernel.org>
References: <69c4cb750910280749l54d2260egbe1189689ac25e9@mail.gmail.com>
In-Reply-To: <69c4cb750910280749l54d2260egbe1189689ac25e9@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8570718433274205302==
Content-Type: multipart/alternative; boundary=0014852ae20b9bbf4f0477013cd4

--0014852ae20b9bbf4f0477013cd4
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the information

So I'll change my grub tonight. Quite strange, because in 9.04 I can
control my fans fairly.

Thanks again!


-----
asus_atk0110 should work with your board (and is loaded
automatically). Fan control is not supported by the driver though, so
if you want that you must pass acpi_enforce_resources=lax on kernel
command line and blacklist asus_atk0110 module.

Luca

--0014852ae20b9bbf4f0477013cd4
Content-Type: text/html; charset=ISO-8859-1

<pre>Thanks for the information<br><br>So I&#39;ll change my grub tonight. Quite strange, because in 9.04 I can control my fans fairly.<br><br>Thanks again!<br><br><br>-----<br>asus_atk0110 should work with your board (and is loaded<br>
automatically). Fan control is not supported by the driver though, so<br>if you want that you must pass acpi_enforce_resources=lax on kernel<br>command line and blacklist asus_atk0110 module.<br><br>Luca<br><br></pre>

--0014852ae20b9bbf4f0477013cd4--


--===============8570718433274205302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8570718433274205302==--
