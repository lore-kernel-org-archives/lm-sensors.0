From: Andreas Hollmann <hollmann@in.tum.de>
Date: Mon, 03 Mar 2014 20:52:43 +0000
Subject: [lm-sensors] Possibility to read temperature sensor on registered DDR3 DIMMs?
Message-Id: <CAGz0_-1Y9Qos3qm8AAejhTxtZPeE9VH_ZCmscOY-R6QU-VkWDQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a 4-socket system with 256 GB RAM (32 x 8 GB).

Socket 0 shows unstable behavior when running the stream
benchmark. It runs well for some time and then the performance
drops to 50 %. It seems like throttling of some component.

The CPU temperatures are very low and therefore I consider
it a problem with one of the 8 DIMM modules on Socket 0.

Is there any way to read the temperature?

I checked the documentation on the DRAM [0] and it says
that there is a thermal sensor on the DIMM.

There is also some information on thermal sensor information
in [1]. It says: Support for integrating RDIMM thermal sensor
information into Intel SMI Status Frame.

Best regards,
Andreas Hollmann

System information:

4 x Intel(R) Xeon(R) CPU E7- 4870  @ 2.40GHz
[0] 32 x 8 GB Samsung M393B1K70CH0-CH9
[1] Intel 7500 Scalable Memory Buffer
[2] Mainboard X8QB6-F



[0] http://www.samsung.com/global/business/semiconductor/file/2011/product/2010/2/4/676543ds_ddr3_2gb_c-die_based_1_5v_rdimm_rev10.pdf

[1] http://www.intel.la/content/dam/doc/datasheet/7500-7510-7512-scalable-memory-buffer-datasheet.pdf

[2] http://www.supermicro.com/products/motherboard/Xeon7000/7500/X8QB6.cfm?SAS=Y

http://www.intel.com/content/dam/doc/platform-memory/ddr3-rdimm-nehalem-ex-validation-results.pdf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
