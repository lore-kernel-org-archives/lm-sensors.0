From: miguel@rozsas.xx.nom.br (Miguel Angelo Rozsas)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Can't access /proc file for writing
Message-Id: <1067811343.3000.51.camel@hahasiah.rozsas.xx.nom.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
In-Reply-To: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2003-11-02 at 17:17, Jean Delvare wrote:

> 
> That would be interesting for sure, but we have to solve the /proc
> problem before.
> 
Yes, I agree. 


> OK, file permissions look good (most files have mode 644, which means
> you are supposed to be allowed to write to them). Now I'd like you to
> try actually writing to a file. For example, go to
> /proc/sys/dev/sensors/as99127f-i2c-0-2d and do:
> echo 70 > temp1
> 

Yes, it worked. I think I triggered some alarm or something like that.
The internal speaker started to beep, but the things goes back to the
normal after I echoed the previous value back to temp1. (Yes, I do "cat
temp1", first ). Currently the temp1 value is "60.0 127.0 40.0".

I set vrm to 9.0 too, without changes....


> Then run sensors. Temp1's limit should now be 70 instead of 60.

Playing with others variables, like In5_min and In5_max, I can see
changes in the output of sensors.

> 
> If it works, this means that libsensors is having trouble.
> 

Is it fine the directories have permissions 0444 ? The error message
show a write problem with the 0444 directory as99127f-i2c-0-2d, not with
the files...just a idea, in case you haven't noticed....
For your convenience, the error message was:

# sensors -s
as99127f-i2c-0-2d: Can't access /proc file for writing;
Run as root?
#

> If it doesn't, this means that the /proc interface itself is having
> trouble.
> 
> > I think is worth to mention that in single user mode, the umask is
> > 022. I expected 222 to explain theses permissions....
> 
> The mask as you set it in your shell is completely independant from the
> /proc files permissions, which are set by the drivers.

I see. 

If you have a beta code, I will be happy to test in my system.
This is my personal workstation, so testing a beta code would be fine (I
hope !). 

However, I prefer to not test an alpha code because the risk to damage
my system beyond repair is too much for me. You know, I don't have a
tape for take a full backup, just the essential in CDR and Zip disks.

Let me know if I can help, or if you want some more information.

thank you for your help so far,


 
-- 
Miguel Angelo Rozsas
miguel@rozsas.xx.nom.br
