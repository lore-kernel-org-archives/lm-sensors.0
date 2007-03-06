From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Tue, 06 Mar 2007 12:33:59 +0000
Subject: [lm-sensors] #2159: lm-sensors doesn't work on Abit AB9 Pro
Message-Id: <45ED5FB7.7000203@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45DEA193.6050100@hhs.nl>
In-Reply-To: <45DEA193.6050100@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Once again through the list as I still can do nothing with the ticket, 
even though its assigend to me. Notice that just might be me being a 
total trac noop, I see no edit link or whatever anywhere and reading the 
trac guide learns me that I need to annotate the bug, but I see no 
annotate link / button either.

Anyways on to the ticket:

lm-sensors wrote:
> #2159: lm-sensors doesn't work on Abit AB9 Pro
> -----------------------+----------------------------------------------------
>   Reporter:  ticket    |       Owner:  jwrgoede
>       Type:  defect    |      Status:  new     
>   Priority:  major     |   Milestone:          
>  Component:  hardware  |     Version:  2.10.0  
> Resolution:            |    Keywords:          
> -----------------------+----------------------------------------------------
> Comment (by ticket):
> 
>  Hi,
> 
>  I tried to use the abituguru2 driver (0.1.2) but it wasn't able to find
>  the device.

Yes, that reminds me that the detection code needs to be even less 
strict. To work around this do: "insmod abituguru2.ko force=1"

> I have an AB9 Pro running Ubuntu Feisty Fawn (2.6.20-6)
>  x86_64. I also downloaded the openguru tool and this is the output of the
>  first few lines on the first run:
> 
> 
>  {{{
>  Detect: 08 ac
>  uGuru wasn't found on motherboard.
>  AC2005 board id 0014
>  }}}
> 
>  This is the beginning of the output of the second and all following runs:
> 
>  {{{
>  Detect: 00 05
>  uGuru wasn't found on motherboard.
>  AC2005 board id 0014
>  }}}
> 

Okay, thats once again the detection code not working, but unlike the 
kernel driver openguru continues even when the detection fails, 
confusing I know, but please keep in mind that openguru is meant only as 
a debug tool to help developing the kernel driver.

>  I noticed that the all values seemed to be OK but I miss the fan
>  information for AUX1 to AUX3.
> 

Strange, the motherboard information used to determine what inputs to 
show and how to label them is taken straight from Abit .ini files, well 
  I've seen a bug in one of those .ini files before :)

Try putting the attached version of config0014.h in the openguru dir and 
then recompiling that should give you those fans too.

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config0014.h
Type: text/x-chdr
Size: 722 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070306/d3b6940c/attachment.bin 
