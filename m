From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Ticket 1751
Message-Id: <20040813202907.3a21cacb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
In-Reply-To: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> (...)
> Is the output with the fault, it's not possible to get output without
> the fault, since as soon as lm_sensors is installed, the fault
> appears.

Aha, yes, of course. Stupid me.

Let's try a different approach then. Please compare (and post) values of
files:
  in*_min
  in*_max
  temp*_type
before and after the installation of the lm_sensors package.

I suspect that writing the voltage limits changes the thermal sensor
type as a side effect, but I could be wrong.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
