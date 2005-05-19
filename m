From: sebastian.hesselbarth@stud.uni-hannover.de (Sebastian Hesselbarth)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: R: i2c-sis5595.c, kernel 2.6.10
Message-Id: <41F2B4AD.30206@stud.uni-hannover.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050122192536.08fb5248.khali@linux-fr.org>
In-Reply-To: <20050122192536.08fb5248.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> As incredible as it may sound, I think you are right and the tests are
> wrong in i2c-sis5595. Most probably this driver never worked in the 2.6
> Linix kernel. It's really odd that nobody ever complained.
> 
> FYI, pci errors are not necessarily negative, some of them are positive.
> The only success value is PCIBIOS_SUCCESSFUL, AKA 0.
> 
> I've prepared a patch that should hopefully fix the i2c-sis5595 driver.
> Could you please give it a try and confirm that the driver works once
> you apply it?

The driver loads and adds the i2c device. i2cdetect -l tells:

i2c-1 unknown SMBus SIS5595 adapter at 5038 Algorithm unavailable
i2c-0 dummy   ISA main adapter              ISA bus algorithm


Is there any way to allow sensors to read out the internal voltage and 
temperature values from the sis5595's Data Acquisition Module ?
Or just check the i2c function (i2cdump !?)

> Thanks,

Regards,

Sebastian

