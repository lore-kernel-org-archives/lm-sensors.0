From: Curt.Blank@curtronics.com (Curt Blank)
Date: Wed, 21 Mar 2007 01:58:27 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use
Message-Id: <46009143.6050506@curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070320181903.A0F4F4DA8@mta-fe.casema.nl>
In-Reply-To: <20070320181903.A0F4F4DA8@mta-fe.casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well that explains it. In kernel 2.6.21 and I have 2.6.16.

If I'm reading things right that's not even a stable kernel yet. Any 
chance of me being able to backport it to the 2.6.16 w83627ehf driver 
for my use?

Looks like I'm slightly on the bleeding edge.

-Curt

Curt Blank wrote:

>In the meantime....
>
>Winbond W83627DHG
>
>http://www.curtronics.com/Pics/MSI_K9N4_SLI-F_Winbond.jpg
>
>How's that for Hi-Res. Couldn't use a flash and lighting was a bitch 
>(running server).
>
>-Curt
>
>Jan van Tiggelen wrote:
>
>  
>
>>OK, the question is out to MSI. I expect it to take up to about a day or 2
>>before we have the full answer.
>>
>>Will post back to you in a personal message when I get the schematics.
>>
>>Kind regards,
>>
>>Jan van Tiggelen
>>
>>
>>-----Original Message-----
>>From: Curt Blank [mailto:curt at curtronics.com] 
>>Sent: Tuesday, March 20, 2007 7:44 PM
>>To: David Hubbard
>>Cc: Jan van Tiggelen; lm-sensors at lm-sensors.org
>>Subject: Re: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use
>>w83627ehfbut it won't load
>>
>>Jan/David
>>
>>Thanks! Man you guys are great.
>>
>>I built this server so I am familiar with the MB but it sounds like Jan 
>>has the answer.
>>
>>I did try installing all the Winbond drivers one at a time but no luck.
>>
>>-Curt
>>
>>On Tue, 20 Mar 2007, David Hubbard wrote:
>>
>> 
>>
>>    
>>
>>>Hi Jan,
>>>
>>>On 3/20/07, Jan van Tiggelen <den_tichel at zonnet.nl> wrote:
>>>   
>>>
>>>      
>>>
>>>>Curt / David,
>>>>
>>>>Would it be of any help if you get a full spec of the motherboard,
>>>>     
>>>>
>>>>        
>>>>
>>including
>> 
>>
>>    
>>
>>>>the schematics? I have access to that.
>>>>
>>>>That way you don't need to take the server apart, and you can be sure
>>>>     
>>>>
>>>>        
>>>>
>>that
>> 
>>
>>    
>>
>>>>the chip is used exactly for what purpose you would expect.
>>>>
>>>>Kind regards,
>>>>
>>>>Jan van Tiggelen
>>>>     
>>>>
>>>>        
>>>>
>>>Yes, that would be the best way.
>>>
>>>David
>>>
>>>
>>>   
>>>
>>>      
>>>
>
>
>_______________________________________________
>lm-sensors mailing list
>lm-sensors at lm-sensors.org
>http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>  
>


