From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: FW: ADM1021 on Xeon ...
Message-Id: <3DCAA055.3070908@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Have you run sensors-detect?  From my understanding, a basic temp sensor 
is on the xeon, but the chip (adm1021) is not.  I.e., for it to work, 
your motherboard needs some sort of chip which we can drive which is 
connected to the sensor on the Xeon.


Phil

Manish Lachwani wrote:

>Hello,
>
>  
>
>> -----Original Message-----
>>From: 	Manish Lachwani  
>>Sent:	Wednesday, November 06, 2002 1:17 PM
>>To:	'David_Papasan@Dell.com'; 'mds@paradyne.com';
>>'sensors@Stimpy.netroedge.com'
>>Cc:	Manish Lachwani
>>Subject:	ADM1021 on Xeon ...
>>
>>Hello,
>>
>>I am making use of 2.4 GHZ Xeon CPUs. Do they have a adm1021 chip on it? I
>>am using a adm1021.c driver and it cannot detect the adm1021 chip on the
>>processor. How do I use force_adm1021 when using the adm1021.c compiled in
>>the kernel? 
>>
>>Any help is appreciated ...
>>
>>Thanks
>>manish
>>    
>>
>
>  
>
