From: Michael Hampton <error@ioerror.us>
Date: Wed, 25 Feb 2009 16:18:23 +0000
Subject: Re: [lm-sensors] W83667HG driver test for in6 and temp3
Message-Id: <49A56F4F.1050506@ioerror.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

JGong@nuvoton.com wrote:
> Dear all,
>
>   
>> I suggest that you make a patch implementing what was said above. Then
>> Michael will test it and we'll see which of in6 or temp3 will be
>> created on his board. If in6 the problem is solved (as far as Michael's
>> system is concerned, at least.) If the incorrect temp3 is displayed
>> then we will have to think of a workaround. Either we check the
>> temperature value and discard it if it looks unreasonable, or we let
>> the user override the configuration manually as I initially proposed. I
>> think I prefer the second option. Choosing the configuration based on
>> the monitored values somehow voids the point of monitoring.
>> Please make sure you include my fan fixes into your patch:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025232.html
>>     
>
> I've made the patch out with what we discussed above (including the fan fix from Jean). It has been tested on my ASUS P5QL PRO.
>   

[snip]

> To Michael:
> 	Please try it on your platform. I am looking forward to your response.
>
> Best regards,
> Gong Jun
>   

I applied this patch to my current Fedora 10 kernel but the patched
module fails to load:
root@underground ~ # modprobe w83627ehf
FATAL: Error inserting w83627ehf
(/lib/modules/2.6.27.15-170.2.24.fc10.x86_64/kernel/drivers/hwmon/w83627ehf.ko):
No such device

I haven't tried with a vanilla kernel yet. I don't usually run them.

Interestingly, sensors-detect says the device has a different ID:

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0xa513
    (logical device B has address 0x290, could be sensors)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No


-- 
Homeland Stupidity <http://www.homelandstupidity.us/>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
