From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407021045330.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Fri, 2 Jul 2004, Jean Delvare wrote:

>
> >> What is 0xFF is ever a valid value for eff_model?
> >
> >No, model is 4 bit :)
>
> That's not what your code below suggests:
>
>     m = ((eax & 0x000000F0)>>4);
>     m+=((eax & 0x000F0000)>>16)<<4;
>
> That's 8-bit to me.

Oh yes. FF is very last model, there can ever be... (4 bits model, 4bits
extended model)

> Do Intel agree with that?

Intel says that extened family is used when family is 0xF, and extened
model is used when model is 0xF. AMD says that extended model AND family
is used when family is 0xf. Havent seen any CPU with model F, starting
from P4 all have family F anyway.

>
> I don't think it's safe to follow AMD here. It means that we cannot
> differenciate between, say, (m=0xf, xm=0) and (m=0xe, xm=1).

Because extended family is used iff ( read as if and only if) family is
fixed to 0xF. So I think it is safe.

> That's fine with me. Just do some defines for these so as to make the
> code more readable (but I don't expect the values to change, ever).

I will do.

>
> Oh, BTW, maybe you could start implementing the architecture dispatcher?
> Your code is valid only for X86, isn't it? So you'd need to detect
> that and provide a default callback function for other architectures.

I will try.

> Another remark: you've defined an enum for VRM values. Interesting but
> we don't use it in our i2c_vid code so far. We use numerical values. I
> see no benefit in using symbolic values first and having to convert
> these to our numbers right after. I'd suggest you use the numerical
> values directly (they are rather explicit anyway). Alternatively I think
> you can force values to match in your enum directly.
>

I can use numbers later. Only tell me VRM_INTEL_8x should be which ?

Also we dont have any number for itanums for example...

Thank you for the comments. I will try to implement them today, before I
leave to offline world :)


Regards

Rudolf
