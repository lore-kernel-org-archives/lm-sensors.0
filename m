From: mds@mds.gotdns.com (Mark Studebaker)
Date: Sat, 29 Oct 2005 21:33:57 +0000
Subject: [lm-sensors] 87431 update
Message-Id: <4363CE84.7000606@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <435BD852.9040703@mds.gotdns.com>
In-Reply-To: <435BD852.9040703@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Mark Studebaker wrote:
> 
>>Great news,
>>I've successfully implemented bmcsensors-over-IPMI-over-SMB, working
>>on the Intel Server donated by Aweta.
> 
> 
> Cool. Congrats :)
> 
> 
> 
>>HW:
>>    Intel Server Platform SR1325TP1-E w/ 6300ESB SMBus and PC87431 at 0x42
> 
> 
> Please will you go through mailing list and notify other people that were fighting with it?
> (I'm CCing Uli) and I think some of other asked in ticket system.
> 

will do


> Unfortunately I'm not very skilled on this IMPI/BMC field. Please could you write the general HOWTO for
> people with server boards? (and for me to point them to this howto)
> 

not a bad idea but for now here are the short answers:

> 1) How to know they have bmc, ipmi ..

sensors-detect will tell them if they have a KCS or SMIC IPMI interface.
The 87431 is a IPMI-over-SMBus chip and I'll be working on sensors-detect
support for it.

> 2) what patches they need

I updated  the new drivers page to specifically identify the patches required for 87431.

> 3) how to obtain results.
> 

load modules, type 'sensors' :)

> Thank you very much.
> 
> Regards
> Rudolf


