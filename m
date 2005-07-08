From: timm@fnal.gov (Steven Timm)
Date: Fri, 08 Jul 2005 21:06:08 +0000
Subject: [lm-sensors] problems loading i2c-proc
Message-Id: <Pine.LNX.4.62.0507081403010.14792@snowball.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 8 Jul 2005, Jean Delvare wrote:

> Hi Steven,
>
>>> Another possibility is a problem with symbol versioning, which you
>>> seem to have enabled. It should work, but maybe you could try
>>> without versioning, just in case.
>>
>> I have no idea either how to enable or disable symbol versioning.
>> Have never had to do anything about this before in previous i2c
>> releases compiled on the same machines.
>
> This is enabled at kernel compilation time in Loadable module support >
> Set version information on all module symbols.
>
> You didn't tell us how you are installing i2c. Have you patched your
> kernel sources tree? Or are you compiling i2c separately? In the latter
> case, is the kernel a stock one or did you recompile it at some point?
>
My process
1) take the kernel-source rpm as it comes from RedHat
2) recompile it as it is
3) compile the i2c sources separately, but pointed at the
kernel configs and includes in that kernel tree.

> Can you share your kernel configuration file so that I try reproducing
> the problem?

Kernel config is just the one that would be in
red hat 2.4.21-32.0.1.ELsmp.  I haven't changed anything.
Can send by separate E-mail if you want.

Steve Timm


>
> Thanks,
>

-- 
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
