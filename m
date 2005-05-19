From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407012122120.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



I think we can get rid off the Extened family and extended model

I just found:

The terms effective family and effective model describe the expanded 8-bit
family and 8-bit model numbers as computed using the extended family,
family, extended model, and model fields.

So if family is 0xF just add extended family to it
and extended model bit concat with model.

ef_family = ext_fam + 0xF
ef_model = ext_model<<4 + model

I found this in AMD Processor Recognition Application Note page 28.

On the other hand on page 75 of Intel Processor Identification
and the CPUID Instruction Application Note 485
in the code is if model is 0xF extended model is printed.

I havent seen any CPU with family F model F and with some ext model
specified did someone?

Maybe we can do that computation in case of family F and save two fields
from table for all cases.

Any ideas, comments?

Regards

Rudolf

