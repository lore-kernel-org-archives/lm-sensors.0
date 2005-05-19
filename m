From: cminyard@mvista.com (Corey Minyard)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C Part 1 - Remove some redundancy from the i2c-core.c
Message-Id: <424C73C7.4020400@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42418B36.5030407@mvista.com> <20050323224430.634e0a75.khali@linux-fr.org>
In-Reply-To: <20050323224430.634e0a75.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

Ok, I have taken some time from suffering (packaging perl modules) to 
get back to this.

Here's a new patch with the debug calls removed, as you requested.

Thanks,

-Corey

Jean Delvare wrote:

>Hi Corey,
>
>  
>
>>Call i2c_transfer() from i2c_master_send() and i2c_master_recv()
>>to avoid the redundant code that was in all three functions.
>>    
>>
>
>I like this. You're right, there is code duplication here, which we can
>get rid of, so let's do so. I'd only have one comments about your patch:
>
>You can get rid of the dev_dbg calls in i2c_master_send() and
>i2c_master_recv() altogether IMHO. I recently updated i2c_transfer() to
>make it more verbose in debug mode [1], so the debug messages in
>i2c_master_send() and i2c_master_recv() are mostly redundant now as far
>as I can see.
>
>[1] http://archives.andrew.net.au/lm-sensors/msg29859.html
>
>Thanks,
>  
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c_remove_redundant_check.diff
Type: text/x-patch
Size: 2866 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050331/3af46141/i2c_remove_redundant_check.bin
