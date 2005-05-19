From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: PC87366 sensor driver?
Message-Id: <20040418153402.0a837c0a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082293815.2121.9.camel@tderooy>
In-Reply-To: <1082293815.2121.9.camel@tderooy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I just got an Opteron board (http://www.rioworks.com/HDAMB.htm) which
> uses the NS PC87366 for its sensors.
> 
> Running sensors-detect finds it on the ISA bus, and told me to ask for
> the driver, so here I go ;-)
> 
> I am running kernel 2.6.5 with Fedora Core 2 test 2 and lm_sensors
> 2.8.6

We have no driver for Linux 2.6 yet :(

If you upgrade to CVS:
  http://secure.netroedge.com/~lm78/download.html#cvs
sensor-detect should tell you which of the three logical devices (fans,
voltages and temperatures) are activated on your system.

That's about it, for now.

If sensors-detect confirms that one or more logical devices are used,
you have three options:

1* Try a 2.4 kernel + i2c patch + lm_sensors CVS.

2* Try to port our preliminary driver by yourself. Instructions are
found in Documentation/i2c/porting-clients in the 2.6 kernel tree.

3* Wait for us or someone else to port and/or extend the existing
driver. Nobody is working on it at the moment.

Note that our preliminary driver only supports fans (monitoring and
control) at the moment, and has not been much tested. I do not plan to
extend the driver unless I have at least one motivated tester for
voltages and/or temperatures. And I do not plan to port the driver to
2.6 before it is reasonably tested and extended.

Good luck ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
