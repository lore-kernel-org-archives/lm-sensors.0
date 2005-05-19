From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Any update on a driver for the PCA9555?
Message-Id: <20040119225406.764faf32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <CEA6A588893A0A47915874C1E8FF2307A4CBA1@rtp-msexch-01.rtp.extremenetworks.com>
In-Reply-To: <CEA6A588893A0A47915874C1E8FF2307A4CBA1@rtp-msexch-01.rtp.extremenetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> What happened was that our motherboard (Which actually has an SMBus
> header on it to hook dohickeys up to) seems to have the SMBus
> controller disabled (it doesn't show up in lspci or anywhere, and
> nothign seems to be able to identify anything), so we scratched our
> plans to use the PCA9555.

I think this is something common that can usually be solved. See
prog/hotplug in our lm_sensors package if you're interested. I guess
it's a bit late though.

> I can provide the driver to you if you like, but again, I can't
> guarantee that it will even compile (however, if it doesn't, the fixes
> are probably just minor things like syntax errors).  I think I have
> everything down to where it should be pretty easy to get working.
> 
> If you would like the file, just reply and I'll forward the source on
> to you.

Yes, please send it. Especially Timothy seems to be interested.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
