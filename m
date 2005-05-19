From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: False detection of sensors on MSI K7N2 Delta-L (NForce2)!
Message-Id: <20040930150918.M57696@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <415BD873.8010303@gmx.de>
In-Reply-To: <415BD873.8010303@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 Sep 2004 14:55:17 +0200, Jan Schiefer wrote
> Temporary you should put a line saying that the w83781d may work too 
> if a secondary w82627hf has been found into sensors-detect script.

Unfortunately, doing that isn't easy due to the internal structure of the
sensors-detect script. And we don't want to make too important changes for a
temporary problem.

Actually, I'd more happily hack the driver itself in case the cleaner
Super-I/O support doesn't come fast enough.

-- 
Jean Delvare
http://khali.linux-fr.org/
