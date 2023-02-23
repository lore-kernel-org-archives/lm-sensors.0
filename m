From: mike mccool <mc@acm.org>
Date: Thu, 23 Feb 2023 22:30:24 +0000
Subject: kernel modules
Message-Id: <Y/fpAAvvSZxIJnPF@linux4>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

i am using lm-sensors/sensors on an AMD AM4 motherboard w/ 5700G APU
and ubuntu 22.04

i added kernel module 'drivetemp' to get temp data from the 10 SATA
drives on this box. i would like to filter-out(ignore) the drivetemp
output from /usr/bin/sensors but cannot. the keyword 'chip' does not
work so 'ignore' statements have no effect.

please add a new keyword, eg, 'module', so that it would be possible
to craft filters like this:

module "drivetemp-scsi-0-*"
   ignore temp1

or

module "k10temp-pci-00c3"
   ignore Tctl

or

module "nvme-pci-2600"
   ignore Sensor 1
   ignore Sensor 2

regards
