From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 27 Sep 2006 10:15:59 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <20060927101559.GA20829@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 27, 2006 at 08:20:51AM +0200, Rudolf Marek wrote:

> Please add this two printk to this code:
> 
>               data->therm_status = eax;
>               printk("EAX from  MSR %x\n", eax);
> 
>                  /* update only if data has been valid */
>                  if (eax & 0x80000000) {
> 			printk("in temp condition\n");

Uhhhh... add them WHERE?

BTW, the hw monitoring chip on my motherboard (Asus P5B Deluxe WiFi) already
does report CPU temp.

Michael

-- 

San Francisco, CA

