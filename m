From: adaplas@hotpop.com (Antonino A. Daplas)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <200503180411.12456.adaplas@hotpop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 17 March 2005 00:37, Jean Delvare wrote:
> Hi Tony,
>
>
> Tony, Miles' original report is here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m1076667232062&w=2
> Sorry for providing the link before.
>

Before I go on debugging, a few questions, as my knowledge of the i2c
framework is quite limited:

This particular bug seems to be triggered in i2c_dev_init when calling
i2c_add_driver.

1. nvidiafb gets loaded before i2c_dev_init(), and when setting up i2c,
calls i2c_bit_add_bus. Is this safe to do? 

2.  In i2c_add_driver, there is a call to list_add_tail.  Is this acceptable
without doing a LIST_HEAD_INIT first?  Or is the list_head initialized
somewhere?

Tony
 
> Thanks,

