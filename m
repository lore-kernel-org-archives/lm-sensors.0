From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <20030806190950.6326aa8f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I would like to add support for the Keywest to our sensors-detect
script. I wonder if I should add it to the detectable adapters list or
to the undetectable adapters list. Is there any way to detect it?
Usually, we detect the adapters by matching a given PCI
manufacturer:device ID and function.

Also, since you seem to have much knowledge about Linux PPC, maybe you
could help us on another problem. We have some dump tools that come with
the lm_sensors package, and one of them, isadump, doesn't seem to
compile on PPC. Could you take a look and tell us if you know how to fix
it? Or maybe this tool is of no use on PPC systems?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
