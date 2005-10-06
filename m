From: lmsensors@lizardlogic.co.uk (Stig Telfer)
Date: Thu, 06 Oct 2005 12:46:56 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <0df0fd52cc4cf66bb208818606726170@lizardlogic.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Wow, this is getting to be quite a spring-cleaning now.

I have incorporated all your suggestions into this patch, except for 
these two:

* Jean: use of val & 255 in printk statement in pcf_isa_setbyte() - I 
think this is actually required because parameter val is an integer 
quantity and could have been sign-extended?  I would prefer to change 
the function parameter to u8, but this violates the types of struct 
i2c_algo_pcf_data.

* Greg: I haven't changed the printk and pr_debug calls yet, because 
there are some printk calls before a struct device is initialised (this 
is done when the device is registered to i2c_algo_pcf at the end of 
driver init).  What is the policy relating to driver output before 
there is an associated struct device initialised?

I took a look at the code with sparse, there were no reported problems. 
  However, am I right in thinking that sparse is x86-centric?  I was 
running the compilation on an Alpha system.  With more than a little 
irony considering the political harangue against gcc in the sparse 
documentation, it didn't compile on my RH8 x86 system: gcc gave an 
internal compiler error...

The attached patch is for code cleanup and is a direct replacement for 
patch 2.

Regards,
Stig Telfer

-------------- next part --------------
A non-text attachment was scrubbed...
Name: elektor-alpha-3.patch
Type: application/octet-stream
Size: 5054 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051006/196ffd32/elektor-alpha-3.obj
