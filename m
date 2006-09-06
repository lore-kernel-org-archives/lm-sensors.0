From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 06 Sep 2006 18:08:33 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520609061108k54989720w76d0d64fedc289d9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just realized that the patch I sent is against the newest w83627ehf
driver, which is not in the kernel yet. However, the .c file includes
all the patches. Please use that file.

The "No such device" error is probably here in the source code:
		dev_err(dev, "unknown CHIP_ID (0x%02x)\n", i);
		err = -ENODEV;
		goto exit_remove;

This error occurs if the chip is not recognized in w83627ehf_detect():

	/* Detect w83627ehf (10 VIN) and w83627dhg (9 VIN) */
	i = w83627ehf_read_value(client, W83627EHF_REG_CHIP_ID);
	if (i = 0xa1) {	/* w83627ehf */
		dev_dbg(dev, "detected W83627EHF/EHG (A1)\n");
		data->num_in = 10;
	}
	else if (i = 0xc1) {	/* w83627dhg */
		dev_dbg(dev, "detected W83627DHG (C1)\n");
		data->num_in = 9;
	}
	else {
		dev_err(dev, "unknown CHIP_ID (0x%02x)\n", i);
		err = -ENODEV;
		goto exit_remove;
	}

You should see the "unknown CHIP_ID" message in dmesg. You may need to
turn on driver debug messages, although I thought dev_err() will show
up in dmesg even with them off.

Can you please send the output of "lspci -n"?

Thanks,
David

