From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: re. Ticket # 1935
Message-Id: <424628DE.6070701@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1110994813.5974.16.camel@localhost.localdomain>
In-Reply-To: <1110994813.5974.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

very sorry, I meant  the reference _above_ (i.e. the link to the mail archive in the ticket).
the module is prog/hotplug/p4_smbus.c in the lm_sensors package.
If you don't  have it you'll have to download it.
Yes you will need to recompile. follow the instructions  in prog/hotplug.
mds

Vesko T. Tomov wrote:
>   Hi,
> 
> Thanks for the reply.  I am sorry if I am asking ignorant questions but 
> I am not sure what to do.  You wrote:
> 
> the answers in the followups to the reference below should work.
> 
> first you need to fix p4b_smbus so that it will find and enable the smabus device.
> Once you see the 24c3 device in lspci, then try the driver.
> If things still don?t work email us, ref. your ticket number.
> MDS 3/15/05
> 
> I am not sure which reference you are talking about (is it the one I was referring to?).  Also, there are no files that contain p4b on my computer,
> so I am not sure what I need to fix.  I am running Fedora 3, kernel 2.6.10-1.770_FC3. Finally, once I fix it, do I need to recompile anything?  Yes, I am a newbie!
> 
> Thanks again.
> 
> Vesko
> 

