From: jwa@fasytek.dk (J. W. Andersen)
Date: Wed, 14 Jun 2006 16:13:11 +0000
Subject: [lm-sensors] ASUS NCCH-DR confusing 83792 vs. 83627THF
Message-Id: <44903597.5080609@fasytek.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <44901813.3080703@fasytek.dk>
In-Reply-To: <44901813.3080703@fasytek.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi rudolf, thanks a lot for your quick reply - and for clearing me up 
about the chip hidden
in the mulriplexor.

Rudolf Marek wrote:
> It is "hidden" using the multiplexer. Please upgrade to latest BIOS.
> If sensors-detect cannot find it - we have a contact at ASUS and they will fix it.
>
>   
BIOS is already version 1005,  which is the latest - and presumably 
greatest - according to ASUS
download pages.  Looks like we need your ASUS contact anyway...
>>     
>
> This chip is known to be unused for the fans/temps. You dont need to load this
> driver.
>
>   
Duly noted.
>> The other thing that puzzles me: In an X86_64 system, I would expect to
>> find
>> the libsensor libraries in a the /lib64 directory, but they actually get
>> nstalled
>> in /usr/local/lib. What must I do to get these libraries in the proper
>> place ?
>>
>>     
>
> # You should not need to change this. It is the directory into which the
>
> # library files (both static and shared) will be installed.
>
> LIBDIR := $(PREFIX)/lib
>
> maybe you can change this to lib64 so the dir will be /usr/local/lib64 but I
> dont know if such directory can exist.
>
> You may also change the PREFIX to / to get it to /lib64 if you like. (all in top
> Makefile)
>
>   

Well, I am not sure of the significance of this. Probably the system 
will just look in the  normal library
path (such as /usr/local/lib) if it cannot find the libraries in 
/usr/lib64. Will try to figure that out from here.

Going on standby till you get the news from ASUS - tnx again !

Regards, Joern.



