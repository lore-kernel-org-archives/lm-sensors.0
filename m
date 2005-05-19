From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Winbond W83792D driver
Message-Id: <42586EF5.1030108@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm sorry I'm not really familiar  with how subclients were done in 2.6, or 2.6 drivers in general.
I did a diff  between your w83792d.c and w83781d.c in the 2.6.11 kernel. 
I saw some differences in xxx_detect_subclients(). These may or may not make a difference.
Be sure you don't have any compile warnings about wrong pointer types.
One of the other guys on the list may be able to help you better.
good luck.
mds


Huang0@Winbond.com.tw wrote:
> Dear MDS
> 
> 
> 
>>haha I thought I had checked it in but I hadn't. Sorry.
>>the only difference in the two links is one has line numbers.
>>have a great tuesday :)
> 
> 
> Yes, I can see it this time, Thanks. I don't like Tuesday very much,
> I like Friday more. :-)
> 
> Quoting MDS:
> 
>>Since I am familiar  with the subclient registration, I will make
> 
> those
> 
>>changes in CVS.
> 
> 
> My 792 driver for linux-2.6 need your help. My 792 driver works well
> before I add the subclient related codes. But after I add the subclient
> registration, it can NOT work now, the error message when I load 792
> driver module are:
> Unable to handle kernel paging request at virtual address 7be32e3a
> printing eip:
> c0158a1d
> ...... /* many error messages are omitted here */
> 
> And the 792 module can NOT be removed any more except I reboot the OS:
> [root@ /usr/src/linux]# rmmod w83792d
> ERROR: Module w83792d is in use
> 
> Would you please help me to check the subclient registration codes?
> since I'm not familiar with them. I added those codes by referring
> your codes in 792 driver for linux-2.4 and w83781d driver for linux-2.6.
> 
> The attachment w83792d_old.c is the version before I adding subclient
> Registration, you may compare them to find the modification.
> 
> Thanks
> Best Regards
> Chunhao
> 
