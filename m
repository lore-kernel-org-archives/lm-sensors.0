From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 29 Mar 2007 14:56:16 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <460BD390.5000407@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ed Lucas wrote:
 >
> Can anyone point me towards a description of the "dynamic chips support" 
> for libsensors that Jean mentioned. (Sorry, my googling failed on this).
>

Currently libsensors has a table, with for each supported chip a table in this 
table (thus a tabel of tables) the per chip table lists all the features of the 
chip and how they are related to each other (IOW if they share computation 
rules, etc).

The big downside of this is that every time a new chip gets supported (like the 
uguru) then this table and thus libsensors need to be updated. Since some 
distro's tend to update the kernel more often then userspace libs, this means 
that people can have a kernel supported chip which is not working because 
libsensors doesn't understand it.

With the new sysfs interface in kernel 2.6, all the needed information can 
actually be "queried" from the sysfs interface, thus removing the need for this 
table, this is what we call "dynamic chips support", AFAIK the impact on the 
dmi based autoconfig stuff we're working on is minimal. The only relevant 
change is the libsensors names of sensors. For most chips sensors currently are 
named things like in0, in1, etc. So one can write:
label in1 "foo bar"

However some chips (GRRR) have names like VDD5V, so one should write:
label VDD5V "foo bar"

With dynamic chip supports, things become consistent and for example volt 
sensors will always be called in0 in1, etc. This actually is an improvement, 
but does mean that old sensors.conf's need to be converted. This is very much 
AFAIK, others please correct me if I'm wrong here.

As discussed earlier the plan is to only target the new 3.x version of 
libsensors with the dmi based stuff, so there is no real problem, we just need 
to make sure any sensors.conf files in the "database" use the new names.

> For motherboard specific sensors.conf files, would it make sense to use 
> the same fan labels that are used in the manual and on the motherboard 
> itself? (What is the offical naming policy? - grepping  sensors.conf 
> shows a range of names)
> 

For the abituguru files in the wiki I've tried to use the exact same names as 
in the bios. AFAIK there is no policy for this. Also notice that libsensors 3.x 
will have a new api funciton, allowing one to query the type of a sensor, so 
then it will not be needed to prefix labels like you've done to find out the type.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
