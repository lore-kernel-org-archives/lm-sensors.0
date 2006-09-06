From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 06 Sep 2006 18:38:07 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060906203807.dad64215.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> The "No such device" error is probably here in the source code:
> 		dev_err(dev, "unknown CHIP_ID (0x%02x)\n", i);
> 		err = -ENODEV;
> 		goto exit_remove;
> 
> This error occurs if the chip is not recognized in w83627ehf_detect():
> 
> 	/* Detect w83627ehf (10 VIN) and w83627dhg (9 VIN) */
> 	i = w83627ehf_read_value(client, W83627EHF_REG_CHIP_ID);
> 	if (i = 0xa1) {	/* w83627ehf */
> 		dev_dbg(dev, "detected W83627EHF/EHG (A1)\n");
> 		data->num_in = 10;
> 	}
> 	else if (i = 0xc1) {	/* w83627dhg */
> 		dev_dbg(dev, "detected W83627DHG (C1)\n");
> 		data->num_in = 9;
> 	}
> 	else {
> 		dev_err(dev, "unknown CHIP_ID (0x%02x)\n", i);
> 		err = -ENODEV;
> 		goto exit_remove;
> 	}

No, actually the error occurs before that. You didn't add the Super-I/O
ID of the W83627DHG in w83627ehf_find, so that function will return
-ENODEV.

-- 
Jean Delvare

