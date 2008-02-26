From: "Jordan Crouse" <jordan.crouse@amd.com>
Date: Tue, 26 Feb 2008 20:50:22 +0000
Subject: Re: [lm-sensors] First shot at Asus M2N-SLI Deluxe config file
Message-Id: <20080226205022.GD7456@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 26/02/08 21:39 +0100, Hans de Goede wrote:
> Jordan Crouse wrote:
>> On 26/02/08 20:33 +0100, Hans de Goede wrote:
>>> Matt Roberds wrote:
>>>> On Tue, 26 Feb 2008, Jordan Crouse wrote:
>>>>> On 21/02/08 08:19 -0600, Matt Roberds wrote:
>>>>>
>>>>>> My second shot is attached.  I have changed the name to inlclude the
>>>>>> "deluxe" designation.  This second shot also requires a small patch to
>>>>>> Jordan Crouse's latest adt7475.c driver to work; a diff is attached as
>>>>>> well.
>>>>> Thanks.  Patch integrated into the driver and I also removed the URL to
>>>>> the datasheet due to the upstream churn.  Full patch is attached.
>>>> Disclaimer: I haven't tried it yet.
>>>> Having said that, in show_voltage(), this patch has
>>>>> case LABEL:
>>>>>  return sprintf(buf, "%s\n",
>>>>>    sattr->index = 0 ? "1" : "2");
>>>> which I think should be
>>>> ---
>>>> case LABEL:
>>>>   return sprintf(buf, "in%s\n",
>>>>     sattr->index = 0 ? "1" : "2");
>>>> ---
>>>> Note the string constant "in".
>>> Ah, good catch.
>>>
>>> Actually, the xxx_label attributes should be completely removed, those 
>>> are only meant to be use by drivers which can give an end user 
>>> presentable labels, other drivers should rely on a proper label being set 
>>> in /etc/sensors.conf
>> I don't understand the criteria - what do you mean by "presentable
>> labels"?
>
> Sorry, I mean labels like:
>
> Northbridge Temp
> CPU Temp
> Powersupply1 Temp
>
> Etc, remote / local doesn't say much to the end user, as the user doesn't 
> know where the adt7475 ic is located, nor where the remote temp diode will 
> be, so the default temp1 temp2 labels will be as usefull as locale_temp and 
> remote_temp.

Okay - I understand.   So I should just get rid of all of the labels in
the whole driver?  

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
