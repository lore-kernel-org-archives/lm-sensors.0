From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: [ltp] Installing linux, fear of lm_sensors
Message-Id: <20030106100206.5f3526f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.3.96.1030105162839.3796D-100000@Ren.netroedge.com>
In-Reply-To: <Pine.LNX.3.96.1030105162839.3796D-100000@Ren.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 2.6.0 has the Thinkpad/IBM hardware detect stuff and it's been
> confirmed by our IBM person, right? 

It hadn't yet IIRC. The first version to be somewhat faulty-IBM-proof
was 2.6.5 and I would even recommend 2.7.0 which has several bugfixes
and improvements (such as the use of ACPI for detection) with regard to
this topic.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
