From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: HP ze4145
Message-Id: <20030210093632.5ac1fd2e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-2276317@euroseek.com>
In-Reply-To: <web-2276317@euroseek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I own an HP Pavilion ze4145 which uses the ALi M7101 PMU 
> (i2c-ali1535). Since this driver is still in beta stage, I 
> was wondering if you guys know about the omnibook module 
> written by Soos Peter (sp@osb.hu) and available at 
> http://sourceforge.net/projects/omke. By using this module 
> I can read (among other things) the CPU's temperature 
> using /proc/omnibook/temperature.

This is interesting. However, I doubt Peter Soos has rewritten a
complete I2C/SMBus system, so it is likely that he uses another method,
probably specific to HP laptops. I'll try to get in touch with him
however, to have a little bit more information, just in case it can help
Mark and Phil develop the driver a step further, who knows.

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
