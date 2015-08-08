From: Phil Perry <phil@elrepo.org>
Date: Sat, 08 Aug 2015 14:44:35 +0000
Subject: Re: [lm-sensors] EXTERNAL: Re:  coretemp driver
Message-Id: <55C615D3.2010208@elrepo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <830397DA32E1A0479077F4D3642B448B62D86C73@HVXDSP41.us.lmco.com>
In-Reply-To: <830397DA32E1A0479077F4D3642B448B62D86C73@HVXDSP41.us.lmco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/08/15 15:20, Guenter Roeck wrote:
> 
>>
>> We are running RedHawk5.4.11, 2.6.31.13, based on RHEL5.4 x86, on an
>> IBM HS23.
>> Executing sensors showed no output at all, no sensors detected.
>> I looked at coretemp.c and saw that the HS23 CPU, 32nm, CPUID= 0X2D,
>> was not supported and in fact coretemp was reporting that in
> /var/log/messages.
>> I added 0x2D to coretemp.c and rebuilt the kernel to see if we could
> even read
>> a sensor. That worked and now there is a temperature reported for each
>> CPU.

Additionally, you don't need to patch and recompile the whole kernel for
just one driver - you can build your patched coretemp driver out of tree.

>> However, with the "workaround" I don't have any confidence in the
> accuracy
>> of the output of course. Is there a patch I can apply to the kernel
> source
>> that will update coretemp.c and related source code?
> 
> The upstream driver has been rewritten pretty much completely since then.
> I had a quick look, but back-porting the latest version to 2.6.31
> would be a major effort.
> 
> I think the best you can do is to stick with what you did.
> 
> Guenter
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
