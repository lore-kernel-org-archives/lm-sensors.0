From: hps@intermeta.de (Henning Schmiedehausen)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: p4b_smbus driver reworked
Message-Id: <1088267921.8247.3.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

this is a reworked and extended version of the prog/hotplug/p4b_smbus
driver. I needed to add support for the ICH3-M (as found in my Toshiba
Satellite 5200 Laptop) and did some work on the program logic. I didn't
want to kill the p4b code so I renamed the source, README and Makefile,
but basically this is the same as p4b.

Simply unpack into the lm_sensors tree, build it and enjoy. Feel free to
add it to the next releases of the lm_sensors package.

(I did read the notice about 2.4.23. However, Fedora is still on 2.4.22
so I feel that this is valuable to many non-p4b Fedora users).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
RHCE - Consultant - Jakarta Turbine Development  - hero for hire

"Fighting for one's political stand is an honourable action, but re-
 fusing to acknowledge that there might be weaknesses in one's
 position - in order to identify them so that they can be remedied -
 is a large enough problem with the Open Source movement that it
 deserves to be on this list of the top five problems." 
                       --Michelle Levesque, "Fundamental Issues with
                                    Open Source Software Development"

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i801smbus.tar.gz
Type: application/x-compressed-tar
Size: 5269 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040626/89935721/i801smbus.tar.bin
