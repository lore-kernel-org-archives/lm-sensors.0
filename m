From: anything@daanwillems.nl (Daan Willems)
Date: Thu, 29 Jun 2006 18:05:35 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS K8N-VM
Message-Id: <44A4166F.7060309@daanwillems.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A326F3.3070300@winbond.com>
In-Reply-To: <44A326F3.3070300@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok great! Will this patch apply to a vanilla 2.6.17.1 kernel?
Is it planned for a future update of the vanilla kernel?

Yuan Mu wrote:
> Hi Daan,
>>
>> Thanks for your quick response. I am using latest vanilla kernels from 
>> kernel.org (so 2.6.17.1 now). Which version will support the voltage 
>> stuff in the w83627 driver?
>> Btw I also tried some patches for the 410 chip on the nforce2 driver 
>> that I found in the lmsensors archive, but those didn't bring me 
>> anything either.
> Sorry, It seems the voltage support has been added to the w83627ehf 
> driver only 6 days ago ;)
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/hwmon/w83627ehf.c 
> 
> 
> You can also get the patch from the link.
> 

