From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: W83L785 for 2.6 is written
Message-Id: <Pine.LNX.4.58.0409121938330.31786@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409032110560.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409032110560.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again!

I made some decent userspace patch to make listings more easy.
If you want you can patch it from here (againts lm_sensors 2.8.7):
http://www.assembler.cz/download/userspace_patch_try
(the patch is just plain shot, not for inclusion yet)

Here is the kernel driver unchanged from last time:
http://www.assembler.cz/download/w83l785_devel.tar.gz

To other people:
For what is VALUE(X) in static sensors_chip_feature ?
And second question. I didnt find anything in chips.c lib to support
temp sensor type? Did I missed something ?

Thanks

Rudolf

Output looks like this now, printing routine needs to be implemented:

#sensors
w83l785-i2c-1-2d
Adapter: SiS96x SMBus adapter at 0xe600
temp1: 40.00 (temp1)
  temp1_max: 80.00 (temp1_max)
  temp1_crit: 95.00 (temp1_crit)
  temp1_hyst_min: 75.00 (temp1_hyst_min)
temp2: 125.00 (temp2)
  temp2_max: 80.00 (temp2_max)
  temp2_crit: 127.00 (temp2_crit)
  temp2_hyst_min: 75.00 (temp2_hyst_min)
fan1_input: 0.00 (fan1_input)
  fan1_min: 0.00 (fan1_min)
  fan1_div: 2.00 (fan1_div)
fan2_input: 0.00 (fan2_input)
  fan2_min: 0.00 (fan2_min)
  fan2_div: 2.00 (fan2_div)
in0_input: 0.04 (in0_input)
  in0_min: 0.00 (in0_min)
  in0_max: 2.04 (in0_max)
in1_input: 0.04 (in1_input)
  in1_min: 0.00 (in1_min)
  in1_max: 2.04 (in1_max)
in2_input: 0.04 (in2_input)
  in2_min: 0.00 (in2_min)
  in2_max: 2.04 (in2_max)
in3_input: 1.10 (in3_input)
  in3_min: 0.00 (in3_min)
  in3_max: 2.04 (in3_max)

