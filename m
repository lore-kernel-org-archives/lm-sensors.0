From: patric <pakar@imperialnet.org>
Date: Tue, 05 Jun 2007 22:30:35 +0000
Subject: Re: [lm-sensors] Fintek F71882 on MSI mainboard
Message-Id: <4665E40B.70304@imperialnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <18021.51591.422191.587646@gate.local.mgri>
In-Reply-To: <18021.51591.422191.587646@gate.local.mgri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,


Just been thinking a while about all these non-standard motherboards,
and maybe it's time soon to implement something that enables lm-sensors
to behave differently on different boards...


One possibility could be to borrow some code from dmidecode to detect
the make/model...


And the hard part would be the implementation to keep the code-changes
to a minimum for all the different drivers if the same driver should
behave in a different way on different boards.. But it could at least
enable lm-sensors to get if-statements for the sensors.conf depending on
the specific mainboard that the person is using, and that small part
could still be very useful, and should require just some minimal changes
to the parser code and an addition of the dmidecode to detect the actual
board.

Another thing that this could be used for is to generate a known list of
options that are needed for different mainboards, and maybe provide a
list of modules for the motherboard instead of having to scan for sensors.


Just brainstorming here but maybe they trigger a new idea in some
developer that knows the code a bit better...


And ignore the spelling... Not a native English-speaker and just about
to fall asleep X-)



/Patric



Hans Edgington wrote:

> Hi,
>
> Thanks for taking a look at the driver.
>
>   
>> I hacked the f71882fg driver so it works on my MSI P6N SLI Platinum
>> mainboard (Socket 775 with Nvidia 650).
>>     
>
>   
>> The critical fix was to use the address values and logic from the
>> existing f71805f driver (see diff).
>>     
>
> I haven't had much time to look at your work, but as I understand it your
> version is kind of a cross between the f71882fg & f71805f driver. Which
> means it now won't work on the Epox mobo's and possibly others.
> So somehow we are going to have to detect which mobo is being used.
>  
>   
>> Note that the driver still causes a kernel oops on rmmod, this is
>> probably because f71882fg_exit doesn't call f71882fg_remove but I didn't
>> feel like working on that, after all I don't remove the module at all...
>> ;-)
>>     
>
> Is already fixed.
>
>
> I'll have a closer look at it, as soon as I can.
>
> Regards,
> Hans
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
