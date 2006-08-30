From: hvw59601@care2.com (Hugo Vanwoerkom)
Date: Wed, 30 Aug 2006 13:26:50 +0000
Subject: [lm-sensors] nforce3 250gb vs. 250 support
Message-Id: <ed43mr$5qk$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ed2l9u$vlq$1@sea.gmane.org>
In-Reply-To: <ed2l9u$vlq$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hugo Vanwoerkom wrote:
>> Hi,
>>
>> Looking in kernel 2.6.17 I see in module i2c-nforce2.c that it supports 
>> the nforce3 250gb MCP, but I find nothing about the nforce3 250 chip.
>>
>> Does that mean the latter is not supported? I am looking at 2 mobo's 
>> that have it and want to make sure support is available before I buy.
> 
> I think so.
> 
>   SUPPORTED DEVICES PCI ID
> 28 nForce2 MCP 0064
> 29 nForce2 Ultra 400 MCP 0084
> 30 nForce3 Pro150 MCP 00D4
> 31 nForce3 250Gb MCP 00E4
> 32 nForce4 MCP 0052
> 33 nForce4 MCP-04 0034
> 34 nForce4 MCP51 0264
> 35 nForce4 MCP55 0368
> 
> In fact this all numbers I found in PCI ID database. Plus I found:
> 03eb	MCP61 SMBus
> 0446	MCP65 SMBus
> 
> you may  google for lspci -n
> You may check those numbers.
> 
> On the other hand when it is not supported we may support it. It turns out that 
> there are no changes in the register layout.
> 
> Regards
> Rudolf

Thanks Rudolf

H











