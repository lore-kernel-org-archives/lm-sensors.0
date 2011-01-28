From: Phillip Susi <psusi@cfl.rr.com>
Date: Fri, 28 Jan 2011 04:51:00 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <4D424B34.6090309@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/27/2011 12:14 PM, Jean Delvare wrote:
>>> I am surprised by the tRAS though, it seems way too high, there may be a
>>> bug in the script.
>>
>> It should be 6-8-6-24.
>
> Really? Is this what memtest86 is report? It's a long time since I last
> saw a memory module with the 3 first digits not being the same.

memtest86 seems to hang or reboot.  I am now quite confused because the 
part number that I ordered was OCZ3P11600C6LV4GK and was listed on 
newegg as having 6-8-6-24 timings.  That is the part number listed on 
the retail packaging, but the SPD decodes with decode-dimms ( release 
3.0.3 ) as having part number OCZ3P1600C6LV2G with 7-7-7-33 timing.  The 
Asus bios has an SPD decode utility that agrees with the part number, 
but shows 7-7-7 for cas, trcp, trp, but 16 for tras, not 33.  Despite 
showing tRas as 16 in the SPD, it defaults to driving it at 18.  It also 
lists a bunch of additional timings, none of which are 33.  I can find 
neither part number on OCZ's web site.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
