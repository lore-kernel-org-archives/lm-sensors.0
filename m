From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-ali1563 driver
Message-Id: <20040419220156.671f2eeb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415202451.3df53f20.khali@linux-fr.org>
In-Reply-To: <20040415202451.3df53f20.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > 2* It would be great to add support for it to our userspace tool
> > "sensors-detect". Basically, all it takes is to add the correct PCI
> > ID to the list of supported PCI adapters. I guess that the PCI ID is
> > 10B9:1563. Am I correct? Would you agree to test the updated script
> > once I am done with it?
> 
> Yes, that is the correct ID. And, I would be happy to test the script.

Please grab it from here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

Providing you have a recent enough version of lm_sensors (2.8.2+)
installed, it should work. Let me know if it doesn't.

The script should see the adapter and propose you to load the
i2c-ali1563 driver, and do it if possible.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
