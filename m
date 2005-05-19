From: lamar@synque.com (Lamar)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: MPX2/LM90 switching discussion
Message-Id: <40F6F2A2.50503@synque.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>Jean,
>>    Was support for the Iwill MPX2's particular method of switching 
>>LM90s ever incorporated into lm_sensors? I could not find any
>>indication that it had been. If not, I am interested in helping
>>implement that feature.
>>    
>>
>
>Unfortunately (for you) it was not. Only the method for the Gigabyte
>board was, because it relies on a more standard (Philips) chip.
>
>However, Alex van Kaam provided me with some code explaining how to do
>it. As I read it, it looks like the board uses a GPIO pin of the
>Super-I/O chipset. So it's heavily motherboard dependant and as such it
>doesn't belong to the lm90 driver IMHO. We better do an external tool to
>handle that specific case.
>
>Here's the code (original by Alex, simplified by me):
>
>begin
>    // Enter Super-I/O
>    WritePortByte($2E,$87);
>    WritePortByte($2E,$87);
>
>    // Select logical device 7
>    WritePortByte($2E,$07);
>    WritePortByte($2F,$07);
>
>    // now we need to set the GPIO10 to high or low
>    WritePortByte($2E,$F1);
>    X:=ReadPortByte($2F);
>
>    if (X and $01) then
>    begin
>      X:=X and $FE;                // if we want it low
>    end
>    else
>    begin
>      X:=X or $01;                // if we want it high
>    end;
>
>    WritePortByte($2F,X);
>
>    // exit Super-I/O
>    WritePortByte($2E,$AA);
>  end;
>
>You should be able to easily convert this to user-space C code (see
>proc/dump/isadump.c for an example). Then running that new tool will
>switch which CPU is monitored.
>
>You could then add functionality to the tool (force one given CPU, show
>selected CPU, etc...).
>
>Once the tool is working we could integrate it into our package.
>
>Remember that there really is only one LM90 on the board, and the lm90
>driver doesn't know about the tweak, so:
>1* You must ensure that you are not switching while the lm90 driver is
>updating its data. This excludes the use of any app repeatedly updating
>the data.
>2* Since the lm90 caches the data it reads, it may take up to 2 seconds
>before you will get the data from the CPU you just switched to.
>
>Good luck, let us know if you need additional help.
>
>  
>
Jean,
    I understand your desire to move the solution out into user-space, 
but I would think the end goal would be for the utilities that use 
lm_sensors to work with little or no modifications, such as gkrellm, and 
the like. That would require the introduction of a virtual LM90 for 
these programs to detect. Since there are 5 access methods of varying 
levels, it would seem to me that in order to ensure the widest support, 
the solution should be implemented in the kernel. I will admit my 
personal preference is to have gkrellm and sensors to work, and for this 
user-level is sufficient, assuming gkrellm uses libsensors.
    Of course, there is the challenge of synchronizing LM90 sensor 
switching with the driver updating. How could this be enforced from 
user-land? It seems some support is required in kernel-space to at least 
signal when updating is in progress, perhaps there already is.  
Actually, I'm not sure this approach would work, I think that the 
switching would have to take place within kernel-space to truly avoid a 
switch during update!
    At any rate, my goal would be for a second, virtual LM90 to appear 
via the libsensors APIs. I have only started to investigate this so any 
comments would be appreciated. Also, I am greatly impressed by the 
existing body of work, and so my comments are made as humbly and 
respectfully as possible.

Lamar
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040715/582810fe/attachment.html
