From: ralf.roesch@rw-gmbh.de (=?US-ASCII?Q?Ralf_Rosch?=)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: AW: Fix in eeprom.c
Message-Id: <NHBBLBCCGMJFJIKAMKLHOEOBCBAA.ralf.roesch@rw-gmbh.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329193435.7d9a587d.khali@linux-fr.org>
In-Reply-To: <20040329193435.7d9a587d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

currently I'm only working with Linux MIPS 2.4 kernel, 
so it would be nice if you could forward the patch for 2.6.

I have seen another problem regarding (MIPS) architecture:
	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
				   sizeof(struct eeprom_data),
				   GFP_KERNEL))) {
		err = -ENOMEM;
		goto ERROR0;
	}

you request memory for two structures at a time.
The problem is, that the eeprom_data structure is not
aligned on an 8 byte boundary, which catches an 
unaligned kernel exception when working on the update_lock semaphore
on our machine (www.cantastic.de)
I would propose that you use two kmalloc() (kfree) for each
individual structure, which solves our problem.

regards
Ralf


> > what do you think about this fix?
> 
> You're correct. Nice catching. I've applied it to our CVS repository.
> 
> Will you send a patch to Greg KH for the eeprom driver in Linux 2.6, or
> do you want me to do so?
