From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: [PATCH ] LM87: Add code to retry reads on error
Message-Id: <416EB02C.7040505@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <23812885.1096307898769.JavaMail.root@huey.psp.pas.earthlink.net>
In-Reply-To: <23812885.1096307898769.JavaMail.root@huey.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>>In the w83l785ts driver I do return the last know value for that
>>>register, passed as an additional parameter by the caller. It doesn't
>>>help for the first read, of course, and tends to hide errors, but is
>>>IMHO better than arbitrarily returning 0.
>>
>>I see what you did.  I'm not a C coder, so I'm not sure I can pull it
>>off.  I will see what I can do.
> 
> 
> My method needs more changes to the code since it alters the function
> prototype. If you don't feel a need for it in your case, let's not
> change anything.

Well, it works fine the way it is.   I would like to enhance it, but I 
have a lot of other stuff that are higher priority...

> 
> 
>>>There's something strange in your patch, methinks. You issue warnings on
>>>read errors, but you don't actually issue an error message if you are
>>>not able to recover from the successive errors. You may provide a patch
>>>against CVS that fixes that and I'll apply it.
>>
>>Yeah, I thought of that after I sent the patch off.   The patch I have
>>been using logs when the maximum number of retries has been exhausted.
>>I held back from sending a patch to my patch until I got some feedback :^)
> 
> 
> And does it actually happen? The delay between retries may be
> experimented with. I came with a very simple model but other approaches
> could lead to better results in some cases. Feel free to alter the
> delays and see if it helps.

I have only ever seen the maximum number of retries reached once, and 
that was under extreme system stress.  In fact, all other times that I 
have seen, exactly 3 retries required if there is an error.  I'll try a 
bit longer wait and see what happens.

> 
> 
> Do you suggest that you have a new product using LM87 chips? I thought
> these chips were pretty old and not used for new designs anymore.
> 

Yes, we have new products that are using the LM87.  I don't select the 
hardware, so I don't know much about how that particular chip was 
selected.  They do check for single sources and get input from the 
vendor concerning predicted lifespan, so they must feel it will be 
available for a long time (we build telco products with a minimum 5 year 
support life).

David Knierim
