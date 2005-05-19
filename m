From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20040418085444.78913a09.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oh, and:

  if ($chip = 2) {
	# check for 'shadow' write-protect register at 0x30-37
	i2c_set_slave_addr($file,$addr - 0x20);
	if(i2c_smbus_write_quick($file,$SMBUS_WRITE) >= 0 &&
	   i2c_smbus_read_byte_data($file,0x80) = -1) {
		if($checksum = 0) {
			return (9, $addr - 0x20);
		} else {
			return (2, $addr - 0x20);
		}
	}
  }

Shouldn't you restore the original slave address before returning?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
