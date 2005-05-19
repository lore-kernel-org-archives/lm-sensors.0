From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: lmsensors 2.7.0 kann auf SuSE 7.2 nicht kompiliert werden
Message-Id: <3DFA6875.3010600@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <02121221483700.10542@lighthouse>
In-Reply-To: <02121221483700.10542@lighthouse>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if you do 'make -k' then make will keep going after an error,
then you should be able to get your w83781d fix compiled.

Jean Delvare wrote:
>>I do not have the time to update my old SuSE to the newest release 8.1
>>
>>although I tenure the 8.1 distribution of SuSE. Maybe I can do the
>>update in january.
> 
> 
> I think you can update the kernel and the kernel tools without updating
> the whole system. I don't know SuSE, but all other distributions I know
> (Slackware, Red Hat, Debian) let the user do so.
> 
> 
>>But I do not understand why the parse error has something to do with
>>my kernel source.
> 
> 
> We do include some header files from linux/include, which define some
> structures or types we use in our code. If these definitions are "wrong"
> (or at least, are not what we think they are) it can annoy the compiler
> enough to lead to the result you had. And I doubt we'll change our code
> to make it compile with the early 2.4 kernel sources.
> 
> 
>>It's is not neccessary to install lm_sensors 2.7.0 because my hardware
>>is supported by the older version of lm_sensors. The only thing I'm
>>affected by 2.7.0 is a bugfix in the w83781d modul (initialization of
>>in0/in1). But I think this fix can be backported to the 2.6.5 which I
>>will try in the next days.
> 
> 
> Yes, should work also.
> 

