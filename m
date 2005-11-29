From: mkgu_2005@yahoo.ca (MK GU)
Date: Tue, 29 Nov 2005 17:18:53 +0000
Subject: [lm-sensors] i2c_i801: a new function for 32-byte memory based
Message-Id: <20051129161715.32918.qmail@web31203.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

  Hi I2C_I801 users and developers,
   
  During the implementation of my project, I've tried a new function, which is extracted from i2c_i801.c and modified for using the 32-byte memory and supporting the block rea/write process call and block read/write transactions. 
  I've tested this function with ICH6. Hope this function useful and helpful to you. Attached is the sorce code of this function. To try this new function, copy the code in the attachment to the i2c_i801.c and make some minor changes to the function i801_access() to call this function for block transactions and to include the case I2C_SMBUS_BLOCK_PROC_CALL / I2C_SMBUS_BLOCK_PROC_CALL_PEC.
   
  Best Regards
  Mingkun Gu
   


		
---------------------------------
Find your next car at Yahoo! Canada Autos
-------------- next part --------------
/* 
   This function was extracted from i2c_i801.c and modified for SMBus 32-bytes
   memory based block transactions with supporting the block read/write process
   call. This function has been tested with ICH6 SMBus controller.
 */
 
/* new constant defines */
#define SMBAUXCTL_E32B		2
#define I801_BLOCK_PROC_CALL	0x1C
#define I801_BLOCK_PROC_LAST	0x3C

static int i801_block_e32b_transaction(union i2c_smbus_data *data, 
					char read_write, int command)
{
	int i, len;
	int smbcmd;
	int temp;
	int result = 0;
	int timeout = 0;
	unsigned char hostc;

	if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
		if (read_write = I2C_SMBUS_WRITE) {
			/* set I2C_EN bit in configuration register */
			pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
			pci_write_config_byte(I801_dev, SMBHSTCFG,
					      hostc | SMBHSTCFG_I2C_EN);
		} else {
			dev_err(&I801_dev->dev,
				"I2C_SMBUS_I2C_BLOCK_READ not DB!\n");
			return -1;
		}
	}

	/* enable the E32B bit in SMBAUXCNT register*/
	temp = inb_p(SMBAUXCTL);
	temp |= SMBAUXCTL_E32B;
	outb_p(temp, SMBAUXCTL); 
		
	dev_dbg(&I801_dev->dev, "Block (pre): CNT=%02x, CMD=%02x, "
		"ADD=%02x, DAT0=%02x, BLKDAT=%02x\n",
		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
		inb_p(SMBHSTDAT0), inb_p(SMBBLKDAT));
			
	/* for block process calls, write data packets first */
	if   ((command = I2C_SMBUS_BLOCK_PROC_CALL) ||
	      (command = I2C_SMBUS_BLOCK_PROC_CALL_PEC)) {
		read_write = I2C_SMBUS_WRITE;
		outb_p(((inb(SMBHSTADD) & 0xfe)) | (read_write & 0x01),
		       SMBHSTADD);
	}
	
	if (read_write = I2C_SMBUS_WRITE) {
		len = data->block[0];
		if (len < 1)
			len = 1;
		if (len > 32)
			len = 32;
		outb_p(len, SMBHSTDAT0); 
		
		/* set up 32 byte buffer for writing */
		for (i=1; i <= len; i++) 
			outb_p(data->block[i], SMBBLKDAT);
	} 

	if(isich4 && command != I2C_SMBUS_I2C_BLOCK_DATA) {
		/* set 32 byte buffer */
	}

	if ((command = I2C_SMBUS_BLOCK_PROC_CALL) ||
	    (command = I2C_SMBUS_BLOCK_PROC_CALL_PEC) )
		smbcmd = I801_BLOCK_PROC_CALL;
	else
		smbcmd = I801_BLOCK_DATA;

	if ((command = I2C_SMBUS_BLOCK_DATA_PEC) ||
	    (command = I2C_SMBUS_BLOCK_PROC_CALL_PEC) )
		smbcmd |= I801_PEC_EN;
	
	outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);

	/* Make sure the SMBus host is ready to start transmitting */
	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
	if ((temp=inb_p(SMBHSTSTS) & 0xff) != 0x00) {
		dev_dbg(&I801_dev->dev, "Clear SMBus STS register (%02x).... \n", temp);
		outb_p(temp, SMBHSTSTS);
			
		if ((temp=inb_p(SMBHSTSTS) & 0x1f) != 0x00) {
			dev_err(&I801_dev->dev, "Reset failed! (%02x)\n", temp);
			result = -1;
                        goto END;
		}
	}

	outb_p(inb(SMBHSTCNT) | I801_START, SMBHSTCNT);

	/* We will always wait for a fraction of a second! */
	timeout = 0;
	do 
	{
		msleep(1);
		temp = inb_p(SMBHSTSTS);
	}
	    while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));

	/* If the SMBus is still busy, we give up */
	if (timeout >= MAX_TIMEOUT) {
		result = -1;
		dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
	}
	if (temp & 0x10) {
		result = -1;
		dev_dbg(&I801_dev->dev,
			"Error: Failed bus transaction (0x%x)!\n", temp);
	} 
	else if (temp & 0x08) {
		result = -1;
		dev_err(&I801_dev->dev, "Bus collision (0x%x)!\n", temp);
	} 
	else if (temp & 0x04) {
		result = -1;
		dev_dbg(&I801_dev->dev, "Error: no response (0x%x)!\n", temp);
	}


	if   ((command = I2C_SMBUS_BLOCK_PROC_CALL) ||
	      (command = I2C_SMBUS_BLOCK_PROC_CALL_PEC))
	{
		/* reset the 32 byte buffer pointer as advised by Intel */
	    	temp = inb_p(SMBHSTCNT); 
		read_write = I2C_SMBUS_READ;
	}	

	/* read data from the 32 byte buffer */
	if ((result >= 0) && (read_write = I2C_SMBUS_READ)) {
		len = inb_p(SMBHSTDAT0);
		if (len < 1)
			len = 1;
		if (len > 32)
			len = 32;
		data->block[0] = len;

		/* Retrieve/store value in SMBBLKDAT */
		for (i=1; i <= len; i++) {		
			data->block[i] = inb_p(SMBBLKDAT);			

			/* Tell ICH6 that this byte is the last byte for the block */
			if (i = len) {
				if ((command = I2C_SMBUS_BLOCK_PROC_CALL) ||
				    (command = I2C_SMBUS_BLOCK_PROC_CALL_PEC))
					smbcmd = I801_BLOCK_PROC_LAST;
				else
					smbcmd = I801_BLOCK_LAST;
				temp = (smbcmd | inb_p(SMBHSTCNT));
				outb_p(temp, SMBHSTCNT);
			}
		}
	}

	if ((temp=inb_p(SMBHSTSTS) & 0x1d) != 0x00) {
		dev_dbg(&I801_dev->dev,
			"SMBus busy (%02x). Resetting... \n", temp);
		outb_p(temp, SMBHSTSTS);
	}
	
	if ((temp=inb_p(SMBHSTSTS) & 0x1d) != 0x00) {
		dev_dbg(&I801_dev->dev,
			"Bad status (%02x) at end of transaction\n", temp);
	}
	
	dev_dbg(&I801_dev->dev, "Block (post): CNT=%02x, CMD=%02x, "
		"ADD=%02x, DAT0=%02x, BLKDAT=%02x\n",
		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
		inb_p(SMBHSTDAT0), inb_p(SMBBLKDAT));

	if (result < 0)
		goto END;

#ifdef HAVE_PEC
	if (isich4 && 
	    ((command = I2C_SMBUS_BLOCK_DATA_PEC) ||
	    (command = I2C_SMBUS_BLOCK_PROC_CALL_PEC))) {
		/* wait for INTR bit as advised by Intel */
		timeout = 0;
		do {
			msleep(1);
			temp = inb_p(SMBHSTSTS);
		} while ((!(temp & 0x02))
			   && (timeout++ < MAX_TIMEOUT));

		if (timeout >= MAX_TIMEOUT) 
			dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
		outb_p(temp, SMBHSTSTS); 
	}
#endif
	result = 0;
END:
	/* disable the E32B bit in SMBAUXCNT register*/
	temp = inb_p(SMBAUXCTL);
	temp &= ~SMBAUXCTL_E32B;
	outb_p(temp, SMBAUXCTL); 
		
	if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
		/* restore saved configuration register value */
		pci_write_config_byte(I801_dev, SMBHSTCFG, hostc);
	}
	return result;
}
