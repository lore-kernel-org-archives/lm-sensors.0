From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: old Dell support
Message-Id: <20031011140717.48987f3b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310110353.h9B3r6815801@hostname.rru.com>
In-Reply-To: <200310110353.h9B3r6815801@hostname.rru.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have a Dell PE2200 server at home I'd like lmsensor
> support for.
> 
> I'm including output from "lspci" and "cat /proc/pci".
> My PC hardware experience is limited, esp. at the
> lower levels. 8^(

Never seen a device with that few PCI devices. My oldest system (a good
old home-made Pentium 200 system) has 7 of them, you have only 6.

> I'm guessing the host bridge is the only thing you
> might support.  Any chance of such support?  Obviously
> I can test.

From what I see, I don't think there is a I2C/SMBus subsystem on your
machine. Still you can try sensors-detect and see what it tells you, but
I wouldn't expect too much.

> We have just started using lmsensors
> at work (~250 linnux systems, at least a dozen MBs);
> we will be happy to pass along any results there as well.

Feedback is always appreciated, wether it's positive or negative. So
feel free to contact us to report how it is going, and ask for
improvements if needed.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
