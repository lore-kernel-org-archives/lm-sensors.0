From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with Arima HDAMA Opteron Motherboard
Message-Id: <20031022204000.65d3b920.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The problem is that the i2c-amd756 driver doesn't have the PCI entries
> 
> for the AMD8111 in it.  The AMD8111 has *two* SMBus interfaces on it. 
> One is SMBus 2.0 and the other is the amd756 compatible bus that most 
> commonly has devices connected to it.
> 
> (...)
> 
> So it fails to attach to the chip and you don't have the BUS you need
> to see the devices.
> 
> I've been meaning to submit a patch for this, but I haven't had the
> time to get one together.  The patch is very simple.

Philip,

That would be really great if you could find some time to commit that
patch, especially if it is simple. This isn't the first user complaining
about that problem.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
