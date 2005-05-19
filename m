From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: AW: Ticket # 15731: bmcsensors panics  with Dell Poweredge 1750
Message-Id: <408DB351.7090202@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <FA095C015271B64E99B197937712FD020B0159@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD020B0159@freedom.grz.icomedias.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Martin,

thanks for taking the time to explain it to me, that's exactly what I needed.
I've reviewed, tested, and checked in the patch.
I have a couple of questions on the poweredge 1750-specific changes
that Y.J. added, if you have his email address would
you please send it to me?

thanks again
mds



Martin Bene wrote:
> Hi Mark,
> 
> 
>>I don't fully understand... sorry if I'm slow.
>>is the problem doing mallocs from an interrupt context or non-atomic
>>mallocs?
>>what's non-atomic about the malloc?
>>how did we get in an interrupt context?
> 
> 
> Being no kernel programmer this is fairly hard form me to answer; lets
> see how far I get :-)
> 
> The problem is non-atomic kmallocs from an interrupt context. 
> 
> Non-atomic refers to the flags specified in the kmalloc call (GFP_ATOMIC
> vs. GFP_KERNEL) (Ref. http://lwn.net/Articles/22909/)
> 
> Scanning for sensors is triggered by sending an ipmi message in
> bmcsensors_reserve_sdr. Building the list of sensors and finally
> creating the required proc entries happens on subsequent reception of
> ipmi messages in the ipmi call-back. If I understand correctly how
> things interact, that would be in an interrupt context.
> 
> Where bmcsensors blows up when trying to register lots of sensors is the
> 
> -> bmcsensors_command (which is the i2c-ipmi call-back)
> -> bmcsensors_msg_handler
> -> bmcsensors_rcv_msg
> -> bmcsensors_rcv_sdr_msg
> -> bmcsensors_build_proc_table
> -> i2c_register_entry
> -> create_proc_entry
> -> proc_create
> -> kmalloc
> 
> sequence. 
> 
> My limited understanding of kernel programming is that if memory is
> allocated in an interrupt context, GFP_ATOMIC must be used. 
> 
> While the kmallocs done directly by bmcsensors_build_proc_table would be
> fixable, the calls in proc_create_entry are obviously not changeable.
> This makes proc_create and its callers unsafe for use in an interrupt
> context.
> 
> The patch works around this limitation by creating a separate kernel
> thread from sm_bmcsensors_init and calling bmcsensors_build_proc_table
> from this thread after scanning for sesnsors has finished.
> 
> Hope I've managed to adequately explain what I think is wrong.
> 
> Bye, Martin
> 
