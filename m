From: pierre-olivier.gaillard@fr.thalesgroup.com (P.O. Gaillard)
Date: Wed, 22 Jun 2005 10:15:20 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <42B91DBE.40505@fr.thalesgroup.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Huang0@Winbond.com.tw wrote:

> Hi Fabien
>
> I check the motherboard SuperMicro P8SCT
> http://www.supermicro.com/products/motherboard/P4/E7221/P8SCT.cfm
> and it's user manual:
> http://www.supermicro.com/manuals/motherboard/E7221/MNL-0776.pdf
> and do NOT find w83792d chip but w83627hf chip, Are you sure that your
> motherboard
> contains the 792 chip?
> 
Indeed, Ken Wo from Supermicro Nederland was kind enough to tell us about it and 
we saw that :
  - we can load the w83792d module on the P8SCT
  - doing sensors -u shows results from both chips and the ones from the w83792d 
are the ones that seem right (i.e. 40 Celsius instead of -1 Celsius)

So, it's pretty clear the there is a w83792d somewhere on the motherboard and 
that the temperature sensors and fans are connected to it.

	thank you for writing the driver which allows us to choose this motherboard for 
our project.

	sincerely,

	P.O. Gaillard


