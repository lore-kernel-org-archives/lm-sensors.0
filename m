From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <200407020822.i628MuVK047377@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> What is 0xFF is ever a valid value for eff_model?
>
>No, model is 4 bit :)

That's not what your code below suggests:

    m = ((eax & 0x000000F0)>>4);
    m+=((eax & 0x000F0000)>>16)<<4;

That's 8-bit to me.

>> >    f+=((eax & 0x00F00000)>>20);
>>
>> No <<4 here?
>
>
>No according to AMD paper is family "additive", model is "concat" so
>thatswhy it is shifted by 4;

Do Intel agree with that?

I don't think it's safe to follow AMD here. It means that we cannot
differenciate between, say, (m=0xf, xm=0) and (m=0xe, xm=1). What if
these end up having different DRM? Using "concat" for the family
doesn't cost much as far as I can see, maybe additional lines in the
table by frankly I doubt it.

>I'm not sure if we can leave 0x000F0000 such things there...

That's fine with me. Just do some defines for these so as to make the
code more readable (but I don't expect the values to change, ever).

Oh, BTW, maybe you could start implementing the architecture dispatcher?
Your code is valid only for X86, isn't it? So you'd need to detect
that and provide a default callback function for other architectures.

Another remark: you've defined an enum for VRM values. Interesting but
we don't use it in our i2c_vid code so far. We use numerical values. I
see no benefit in using symbolic values first and having to convert
these to our numbers right after. I'd suggest you use the numerical
values directly (they are rather explicit anyway). Alternatively I think
you can force values to match in your enum directly.

Thanks,
Jean Delvare
