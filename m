From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Fix in eeprom.c
Message-Id: <20040330204007.48d1bd8a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329193435.7d9a587d.khali@linux-fr.org>
In-Reply-To: <20040329193435.7d9a587d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have seen another problem regarding (MIPS) architecture:
> 	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
> 				   sizeof(struct eeprom_data),
> 				   GFP_KERNEL))) {
> 		err = -ENOMEM;
> 		goto ERROR0;
> 	}
> 
> you request memory for two structures at a time.
> The problem is, that the eeprom_data structure is not
> aligned on an 8 byte boundary, which catches an 
> unaligned kernel exception when working on the update_lock semaphore
> on our machine (www.cantastic.de)
> I would propose that you use two kmalloc() (kfree) for each
> individual structure, which solves our problem.

This is quite a problem you reveal there. It happens that all our chip
drivers in both CVS and Linux 2.6 use this single memory allocation
method. This suggests that no i2c chip driver (at least coming from the
lm_sensors project) would work on any architecture not supporting
non-aligned memory accesses.

I'm a bit surprised that this would have been uncovered until today.
Greg, I would be interested in your opinion. Should we update all our
chip drivers to have two memory allocations instead of a single one for
this?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
