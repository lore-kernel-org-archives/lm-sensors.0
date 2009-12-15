From: mikp <mikpolniak@roadrunner.com>
Date: Tue, 15 Dec 2009 20:36:29 +0000
Subject: [lm-sensors] w83627ehf driver fails for chipset w83667HG-A on Asus
Message-Id: <20091215153629.e8772e48.mikpolniak@roadrunner.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

modprobe w83627ehf FATAL: Error inserting w83627ehf
(/lib/modules/2.6.32/kernel/drivers/hwmon/w83627ehf.ko): No such device

sensors-detect only 'yes' response is:
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0xb353
    (logical device B has address 0x290, could be sensors)

Since this chipset is on the latest Asus P55 mainboard its probably a new version of the original supported chip. 

I see from the Devices page comments that support can probably be added to the w83627ehf driver. 

I am willing to test any attempts at supporting this chip. TIA.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
