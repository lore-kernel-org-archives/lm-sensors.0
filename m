From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040126223030.2ebb35c2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The problem is, that the voltage values still need to get devided by
> 10.
> 
> Shall I scale the values by 1000 for kernel 2.6.1 and by 100 for
> kernel 2.4.22 and remove the factor 1000 from sensors.conf?

Yes, that's the idea.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
