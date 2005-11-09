From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Wed, 09 Nov 2005 22:17:36 +0000
Subject: [lm-sensors] [PATCH 0/3] improve i2c probing
Message-Id: <20051109221449.34ceea1e@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 Hello,

  I've took the patch series proposed by Nathan Lutchansky [1]
  in august, applied some of the suggestions which were emerged
 from its discussion and added a little improvement.

  The original patches are available at [2]. I added some
 more code in order to let an adapter specify which of its
 addresses should be probed for which driver.
 
  This is useful for platform devices and, probably, video
 cards. 

  quoting Nathan..

"Currently, when a new i2c bus needs to be probed, the i2c subsystem
calls the attach_adapter callback for each loaded i2c client driver,
which must call the i2c_probe function with a list of addresses to be
probed and another callback for reporting detected devices:

    static int foo_attach_adapter(struct i2c_adapter *adapter)
    {
            if (!(adapter->class & I2C_CLASS_HWMON))
                    return 0;
            return i2c_probe(adapter, &addr_data, foo_detect);
    }

Virtually every i2c client driver uses exactly the same code, so there's
little point in requiring them all to implement this callback.  The
first patch in this series adds two new fields to the i2c_driver
structure, `address_data' and `detect_client', and if they are set by
the driver, the i2c core will automatically call i2c_probe using those
fields as the second and third argument.  If the `class' field of the
i2c_driver structure is set, it will be compared with the adapter class
first.

Patches 2 and 3 add these fields to the i2c_driver initializer in the
i2c hwmon and misc i2c chip drivers and remove the corresponding
attach_adapter callbacks."

[1]
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013320.html

[2]
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013321.html
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013322.html
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013323.html

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

