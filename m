From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: adm1026 on dual opteron : No sensors Found
Message-Id: <3EE7D911.1020308@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1053468785.3ecaa871cebf7@rand.angstrom.com>
In-Reply-To: <1053468785.3ecaa871cebf7@rand.angstrom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The change is near the top of lib/Module.mk
The proposal is 2.0.0
What do you all think?


Jean Delvare wrote:
>>I have not had segfault problems running 'sensors'.
>>
>>segfaults are most often caused when there are different versions of 
>>libsensors installed on the system and the wrong one is being picked. 
>>(/lib/libsensors instead of lm_sensors-2.7.0/lib/libsensors).  Did you
>>replace or delete the original /lib/libsensors libraries or set
>>LD_LIBRARY_PATH to modify the library search path?
> 
> 
> By the way, someone once suggested that this kind of issue could be
> avoided if we bumped the library revision number. I think that person
> was right, but I don't know how to do this and I don't want to break
> anything. Could someone with more knowledge with regards to this topic
> take care of it?
> 
> If nobody does, I guess I'll end up doing it by myself, but beware the
> consequences ;)
> 
