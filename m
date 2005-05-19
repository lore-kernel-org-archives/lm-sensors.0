From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: ...no subject... (fwd)
Message-Id: <3E35A592.3030904@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301261540.h0QFeENU001922@shire.frodo.local>
In-Reply-To: <200301261540.h0QFeENU001922@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ah, yeah.  Hey Kyosti, are you our official kernel patch submitter?  The 
MAINTAINERS document needs some tweaks:

Frodo's name/address needs to be replaced with Mark's. (Use 
mdsxyz123@yahoo.com for his address)

And, match I2C maintainer info with Sensors. (mailing list and web site 
are wrong last time I checked)

Oh, and if you want to be an official patch /receiver/  you can replace 
my name and address with yours.


Phil


Frodo Looijaard wrote:

>
>hi,
>perhaps you should post that to the MAINTAINES maintainer too. the www is also
>not reachable and your address is the only working one.
>
>just an idea,
>
>	walter
>
>
>
>
>
>- - - - - - - - - - - - - - Original Message - - - - - - - - - - - - - -
>From: Frodo Looijaard <frodol@dds.nl>
>Subject: Re: ...no subject...
>Date: 01/26/03 16:40
>
>WHarms@bfs.de wrote:
>  
>
>>hi frodo,
>>i coudnt reach pelican,
>>    
>>
>
>True. I have had problems too.
>
>Try sensors@Stimpy.netroedge.com for now (I've cc-ed this).
> 
>  
>
>><linux-i2c@pelican.tk.uni-linz.ac.at>... Deferred: Connection timed out with pelican.tk.uni-linz.ac.at. 
>>
>>because you are mentioned as i2c maintainer this is of
>>interessed for you also.
>>
>>	walter
>>
>>
>>
>>Hi, 
>>i was looking into the i2c code and found that some 
>>sprintf() statement simply print without any 
>>range restictions. 
>>I dont thing this is a security problem but an buffer overflow is basicly possible. 
>>e.g. 
>>/* from i2c-core.c */ 
>>if (i2cproc_initialized) { 
>>char name[8]; 
>>struct proc_dir_entry *proc_entry; 
>>
>>-> sprintf(name,"i2c-%d", i); 
>>
>>
>>In this example i=1..I2C_ADAP_MAX what is now 16 but 
>>sprintf(name,"i2c-%02d", i); is a simple solution that 
>>secures agains any accidentle overflow. 
>>
>>
>>hope that helps, 
>>walter 
>>
>>ps: if you like i can send a patch 
>>
>>    
>>
>
>  
>
