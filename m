From: "everythingsfree@lineone.net" <everythingsfree@lineone.net>
Date: Thu, 16 Jun 2011 20:06:10 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <3598004.286421308254770429.JavaMail.defaultUser@defaultHost>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Thanks Guenter & Jean for the replies.

I found this web page with some 
info and was following that (but just used the Makefile as downloaded):


https://wiki.ubuntu.com/CoreTemp
That checked and updated a few things 
plus downloaded other (it covered everything Guenter had suggested) but 
I still get errors:

  CC [M]  /home/dave/coretemp/coretemp.o

/home/dave/coretemp/coretemp.c: In function âget_tjmaxâ:

/home/dave/coretemp/coretemp.c:290: error: 
âMSR_IA32_TEMPERATURE_TARGETâ undeclared (first use in this function)

/home/dave/coretemp/coretemp.c:290: error: (Each undeclared identifier 
is reported only once
/home/dave/coretemp/coretemp.c:290: error: for 
each function it appears in.)
/home/dave/coretemp/coretemp.c: In 
function âget_pkg_tjmaxâ:
/home/dave/coretemp/coretemp.c:326: error: 
âMSR_IA32_TEMPERATURE_TARGETâ undeclared (first use in this function)

/home/dave/coretemp/coretemp.c: In function âcreate_name_attrâ:

/home/dave/coretemp/coretemp.c:338: error: implicit declaration of 
function âsysfs_attr_initâ
/home/dave/coretemp/coretemp.c: In function 
âupdate_ttargetâ:
/home/dave/coretemp/coretemp.c:401: error: 
âMSR_IA32_TEMPERATURE_TARGETâ undeclared (first use in this function)

/home/dave/coretemp/coretemp.c: In function âinit_temp_dataâ:

/home/dave/coretemp/coretemp.c:467: error: 
âMSR_IA32_PACKAGE_THERM_STATUSâ undeclared (first use in this function)

/home/dave/coretemp/coretemp.c: In function âget_core_onlineâ:

/home/dave/coretemp/coretemp.c:715: error: âX86_FEATURE_DTSâ undeclared 
(first use in this function)
/home/dave/coretemp/coretemp.c:732: error: 
âX86_FEATURE_PTSâ undeclared (first use in this function)
make[2]: *** 
[/home/dave/coretemp/coretemp.o] Error 1
make[1]: *** 
[_module_/home/dave/coretemp] Error 2
make: *** [modules] Error 2

I 
would have assumed that 'MSR_IA32_TEMPERATURE_TARGET' would be defined 
in a header file and that that would be in the 'linux-headers-2.6.32-24-
server' package that was downloaded, perhaps not?

Any suggestions?  
I'll keep looking on-line...

Thanks,
Dave

>> 
>> Sadly that may be 
where my knowledge of building things under Ubuntu 
>> (or any Linux) 
falls somewhat flat.  I'll take a look on-line for how 
>> to do it but 
if you can quickly let me know that'll make the turn 
>> around faster.

>> 
>Download the two files into some directory, then run "make" in it.

>You may have to install the linux-headers package first, and possibly

>the C compiler (gcc) and/or make.
>
>After make succeeds, run "sudo 
make install" followed by "sudo modprobe -r coretemp"
>and "sudo 
modprobe coretemp".
>
>Something like
>
>mkdir coretemp
>cd coretemp

>wget http://roeck-us.net/linux/drivers/coretemp/coretemp.c>wget http://roeck-us.net/linux/drivers/coretemp/Makefile
>sudo apt-get install make 				# if necessary
>sudo apt-get install 
gcc 				# if necessary
>make
># Note: make will likely fail and tell 
you the missing headers, such as 
>#make: *** /usr/src/linux-headers-
2.6.35-25-server: No such file or directory.  Stop.
>#make: *** 
[modules] Error 2
>sudo apt-get install linux-headers-2.6.35-25-server	
# or whatever linux version you run
>make
>sudo make install
>sudo 
modprobe -r coretemp
>sudo modprobe coretemp
>
>Guenter
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
