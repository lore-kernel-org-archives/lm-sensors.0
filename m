From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <42523ED7.2010301@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
In-Reply-To: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

One thing that comes to mind is that the mapping of VID to voltage is 
not a simple linear function.  For some of the standards it does funky 
things with some of the bits.  So you won't be able to use the simple 
math operators like the other scaling functions in sensors.conf.  You'd 
have to create a new, custom transform function that takes both the VID 
value and the VRM version.  sensors.conf has a relatively simple 
equation parser.  I'm not sure how easy it will be to add the VID to 
voltage function.

If we suck that into libsensors, then you *have* to use the library to 
convert the VID bit pattern into a voltage or re-implement the function 
in the userspace language of your choice (bash, perl, python, etc.) and 
since these VRM standards change seemingly with every CPU rev, all those 
user-space applications are going to be out of date at one point or another.

But the code that exists in the kernel sensor drivers today, checks the 
CPU, verifies which VRM standard applies to that rev of CPU and then 
produces the correct VID to voltage mapping automatically.

If you still want to proceed, I suggest you solve the sensors.conf side 
of the problem first.  Make sure you can scale a raw VID bit pattern 
into a voltage for use in setting CPU core voltage limits.  Then let's 
discuss changing the chip drivers.

:v)

Grant Coady wrote:

>Hi there,
>
>vid and vrm are two of the strangest things I met in lmsensors.
>
>Here we have user space telling kernel how to scale a value the 
>kernel does nothing with.  If I produce a set of patches to remove 
>vid scaling from the drivers: adm1025.c, adm1026.c, asb100.c, 
>it87.c, lm85.c, lm87.c, pc87360.c, w83627hf.c and w83781d.c we 
>save nine write accessors and can remove the vrm stuff to user-
>space where it belongs, with the other scaling, simplifying the 
>read accessors by removing the scaling requirement.
>
>vid sense pins don't do anything, thus the vid sense state should 
>be reported truthfully to user-space, it may do something with the 
>value.  
>
>Please somebody tell me what I've missed here?
>
>Cheers,
>Grant.
>
>  
>
